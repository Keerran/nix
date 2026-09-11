{ config, inputs, pkgs, ... }:
{
    home.packages = with pkgs; [
        kdePackages.qtdeclarative
        material-symbols
        inputs.quickshell.packages.${stdenv.hostPlatform.system}.default
        inputs.matugen.packages.${stdenv.hostPlatform.system}.default
        inputs.ugly.packages.${stdenv.hostPlatform.system}.default
    ];

    xdg.configFile."quickshell" = {
        source = config.lib.dotfiles.link "quickshell";
        recursive = true;
    };
}
