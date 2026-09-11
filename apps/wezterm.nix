{
  config,
  inputs,
  pkgs,
  ...
}:
{

  xdg.configFile."wezterm" = {
    source = config.lib.dotfiles.link "wezterm";
    recursive = true;
  };

  home.packages = [
    inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs = {
    zoxide.enable = true;
    bat.enable = true;
    btop = {
      enable = true;
      package = pkgs.btop.override {
        cudaSupport = true;
        rocmSupport = true;
      };
      settings = {
        theme_background = false;
        vim_keys = true;
      };
    };
  };

  nix.settings = {
    substituters = [ "https://wezterm.cachix.org" ];
    trusted-public-keys = [ "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0=" ];
    trusted-users = [
      "root"
      "@wheel"
    ];
  };
}
