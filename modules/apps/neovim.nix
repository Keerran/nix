{
  home.modules.base = {config, pkgs, ...}: {
      home.packages = with pkgs; [
        lua51Packages.lua
        lua51Packages.luarocks
        python313Packages.jupytext
        neovim
        nil
        ty
        tree-sitter
        rust-analyzer
        fzf
        ripgrep
        fd
      ];

      xdg.configFile."nvim" = {
          source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nix/dotfiles/nvim";
          recursive = true;
      };
  };
}
