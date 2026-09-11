{ inputs, pkgs, config, ... }:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./lib/dotfiles.nix
    ./apps/bitwarden.nix
    ./apps/git.nix
    ./apps/fonts.nix
    ./apps/feh.nix
    ./apps/7z.nix
    ./apps/ffmpeg.nix
    ./apps/hyprland.nix
    ./apps/mpv.nix
    ./apps/neovim.nix
    ./apps/nushell.nix
    ./apps/quickshell.nix
    ./apps/spotify.nix
    ./apps/starship.nix
    ./apps/vesktop.nix
    ./apps/wezterm.nix
    ./apps/yazi.nix
  ];

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "maroon";
  };

  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-maroon-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "maroon" ];
        variant = "mocha";
      };
    };
  };

  gtk.gtk4.theme = config.gtk.theme;

  home.packages = with pkgs; [
    vivaldi
  ];

  home.pointerCursor = {
    enable = true;
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 32;
    gtk.enable = true;
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  home.username = "keerran";
  home.homeDirectory = "/home/keerran";

  home.stateVersion = "24.11";
}
