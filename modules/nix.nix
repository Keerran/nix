{
  nixos.modules.base = { pkgs, ... }: {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    programs.nix-ld.enable = true;

    programs.nix-ld.libraries = with pkgs; [

      # Add any missing dynamic libraries for unpackaged programs

      # here, NOT in environment.systemPackages
      libcxx
    ];
  };
}
