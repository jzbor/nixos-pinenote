{ flake, ... }:

{
  imports = [ flake.nixosModules.default ];
  nixpkgs.hostPlatform = "aarch64-linux";

  jzbor-pinenote.initial.enable = false;
  jzbor-pinenote.boot.enable = false;

}
