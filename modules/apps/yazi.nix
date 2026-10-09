{
  home.modules.catppuccin = {
      catppuccin.yazi.enable = false;
  };

  home.modules.shell =
    { pkgs, ... }:
    {
      programs.yazi = {
        enable = true;
        flavors =
          let
            repo = pkgs.fetchFromGitHub {
              owner = "yazi-rs";
              repo = "flavors";
              rev = "20b47bfd78880c2674899597fd26bc01b21ff48c";
              hash = "sha256-NGnfrQdsnQITKCZ0oh6DCxeCR2ozJoPAZetsi3ghHAI=";
            };
          in
          {
            catppuccin-mocha = repo + "/catppuccin-mocha.yazi";
          };
        keymap = {
          mgr.prepend_keymap = [
            {
              on = [ "<C-y>" ];
              run = "plugin wl-clipboard";
              desc = "Yank to system clipboard";
            }
            {
              on = [
                "g"
                "c"
              ];
              run = "plugin vcs-files";
              desc = "Show Git file changes";
            }
          ];
        };
        theme = {
          flavor = {
            dark = "catppuccin-mocha";
            light = "catppuccin-mocha";
          };
          mgr = {
            cwd = {
              bg = "reset";
            };
          };
          status = {
            overall = {
              bg = "reset";
            };
          };
        };
        plugins = with pkgs.yaziPlugins; {
          "vcs-files" = vcs-files;
          "wl-clipboard" = wl-clipboard;
        };
        shellWrapperName = "y";
      };
    };
}
