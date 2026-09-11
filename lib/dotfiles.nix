{ config, ... }:
{
  config.lib.dotfiles.link =
    path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixv2/dotfiles/${path}";
}
