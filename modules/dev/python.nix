{
  home.modules.dev = { pkgs, ... }: {
    home.packages = with pkgs; [
      uv
    ];
  };
}
