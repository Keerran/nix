{
  config,
  inputs,
  lib,
  ...
}:
{
  options.nixos = {
    modules = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.deferredModule
      );
    };

    configurations = lib.mkOption {
      type = lib.types.lazyAttrsOf (
        lib.types.submodule {
          options = {
            system = lib.mkOption {
              type = lib.types.str;
              default = "x86_64-linux";
            };
            module = lib.mkOption {
              type = lib.types.deferredModule;
            };
          };
        }
      );
    };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    name: { system, module }: inputs.nixpkgs.lib.nixosSystem {
      system = system;
      modules = [ module ];

    }
  ) config.nixos.configurations;
}
