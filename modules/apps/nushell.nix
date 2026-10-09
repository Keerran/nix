{
  home.modules.shell =
    {
      lib,
      pkgs,
      osConfig,
      config,
      ...
    }:
    {
      programs.nushell = {
        enable = true;
        settings = {
          show_banner = false;
          buffer_editor = "nvim";
          edit_mode = "vi";
        };
        shellAliases = {
          clr = "clear";
          imcat = "wezterm imgcat";
          lj = "lazyjj";
          grep = "rg";
          df = "duf";
          du = "dust";
        };
        extraConfig = ''
          source ${config.lib.dotfiles.link "nushell/config.nu"}
        '';
        extraEnv = ''
          source ~/.config/nu/session-vars.nu
        '';
        plugins = with pkgs.nushellPlugins; [
          polars
          gstat
          query
        ];
      };

      programs.nix-your-shell = {
        enable = true;
        enableNushellIntegration = true;
      };

      xdg.configFile."nu/session-vars.nu".text = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (
          name: value: ''$env.${name} = "${toString value}"''
        ) osConfig.environment.sessionVariables
      );
    };
}
