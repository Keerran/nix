{config, pkgs, ...}:
{
  home.packages = with pkgs; [
    neovim
    nil
    tree-sitter
    rust-analyzer
    fzf
    ripgrep
    fd
  ];

  xdg.configFile."nvim" = {
    source = config.lib.dotfiles.link "nvim";
    recursive = true;
  };
}
