{ pkgs, ... }:
let
  googlesans-code-nerd =
    with pkgs;
    (googlesans-code.overrideAttrs (o: {
      nativeBuildInputs = [
        fontc
        nerd-font-patcher
      ];
      postInstall = ''
        mkdir -p $out/share/fonts/googlesans-code-nerd
        for f in $out/share/fonts/googlesans-code/*.ttf; do
          nerd-font-patcher --complete --outputdir $out/share/fonts/googlesans-code-nerd/ "$f"
        done
      '';
    }));
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    googlesans-code-nerd
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
