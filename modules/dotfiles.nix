{
  home.modules.base = { config, ... }:
  {
    config.lib.dotfiles.link =
      path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/dotfiles/${path}";
  };
}
