{ flake, inputs, ... }:

{
  imports = [ flake.nixosModules.default ];
  nixpkgs.hostPlatform = "aarch64-linux";

  jzbor-pinenote.initial.enable = false;
  jzbor-pinenote.boot.enable = false;

  virtualisation.vmVariant.virtualisation.host.pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

}
