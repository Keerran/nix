{
  config,
  inputs,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings = {

    };
    extraLuaFiles."config.lua" = {
      content = config.lib.dotfiles.link "hyprland.lua";
      autoLoad = true;
    };
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal.extraPortals = [
    inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
  ];

  programs.rofi = {
    enable = true;
    plugins = [
      pkgs.rofi-emoji
    ];
  };

  home.packages = with pkgs; [
    xdg-utils
    wl-clipboard
    wlsunset
    cliphist
    thunar
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      # preload = [ "~/Wallpapers/nomai.jpeg" ];
      wallpaper = [
        {
          monitor = "";
          path = "~/Wallpapers/nomai.jpeg";
          fit_mode = "cover";
        }
      ];
      splash = false;
    };
  };

  programs.bash.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      exec Hyprland
    fi
  '';

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    trusted-users = [
      "root"
      "wheel"
    ];
  };
}
