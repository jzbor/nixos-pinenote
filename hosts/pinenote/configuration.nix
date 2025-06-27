{ flake, ... }:

{
  imports = [ flake.nixosModules.default ];
  nixpkgs.hostPlatform = "aarch64-linux";
}
