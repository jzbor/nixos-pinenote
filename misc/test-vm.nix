{ pkgs, inputs, ...}:

let
  hostPkgs = pkgs;
  system = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      ../hosts/pinenote/configuration.nix
      ({ lib, config, ...}:
      {
        jzbor-pinenote.boot.enable = false;
        boot.loader.grub.enable = false;

        virtualisation.vmVariant.virtualisation = {
          host.pkgs = hostPkgs;
          cores = 4;
          memorySize = 4096;
        };
      })
    ];
    specialArgs = { inherit inputs; };
  };
in system.config.system.build.vm
