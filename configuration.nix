{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./apps/steam.nix
  ];

  environment.systemPackages = [
    pkgs.floorp-bin
    pkgs.grub2
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "maroon";
  };

  # Use the systemd-boot EFI boot loader.
  # Bootloader.
  boot.loader.grub = {
    enable = true;
    useOSProber = true;
    devices = [ "nodev" ];
    efiSupport = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  networking.hostName = "nixos";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.keerran = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bkup";
    extraSpecialArgs = { inherit inputs; };
    users = {
      "keerran" = import ./home.nix;
    };
  };

  services.getty.autologinUser = "keerran";

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  fileSystems."/mnt/shared" = {
    device = "dev/disk/by-uuid/086AD1657A2F1B65";
    fsType = "ntfs";
    options = [
      "uid=1000"
      "gid=1000"
      "allow_other"
    ];
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH =
      with pkgs;
      lib.makeLibraryPath [
        wayland
      ];
    NIXOS_OZONE_WL = "1";
  };

  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "video=DP-4:2560x1440@60"
  ];

  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    wayland
  ];

  nixpkgs.config = {

    allowUnfree = true;
    cudaSupport = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "24.11";
}
