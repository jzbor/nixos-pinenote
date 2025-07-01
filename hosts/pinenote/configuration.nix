{ inputs, ... }:

{
  imports = [ inputs.self.nixosModules.default ];
  nixpkgs.hostPlatform = "aarch64-linux";

  jzbor-pinenote.initial.enable = true;
}
