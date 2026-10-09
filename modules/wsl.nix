{inputs, ...}: {
  nixos.modules.wsl = {
    imports = [
      inputs.nixos-wsl.nixosModules.default
    ];

    wsl = {
      enable = true;
      defaultUser = "keerran";
      wslConf.interop.appendWindowsPath = false;
    };
  };
}
