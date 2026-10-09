{ config, ... }: {
  nixos.configurations.attlerock.module = {
    system.stateVersion = "25.05";

    imports = with config.nixos.modules; [
      base
      wsl
    ];

    home-manager.useGlobalPkgs = true;
    home-manager.users."keerran" = {
      imports = with config.home.modules; [
        base
        dev
        shell
      ];
    };
  };
}
