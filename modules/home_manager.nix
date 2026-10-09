{inputs, lib, ...}: {
  options.home = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.deferredModule
      );
    };
  };

  config.nixos.modules.base = {
    imports = [
      inputs.home-manager.nixosModules.default
    ];

    home-manager = {
      sharedModules = [
        ({osConfig, ...}: {
          home.stateVersion = osConfig.system.stateVersion;
        })
      ];
    };
  };

  config.home.modules.base = {
    programs.home-manager.enable = true;
  };
}
