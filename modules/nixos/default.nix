inputs: { lib, ... }:

with lib;
{
  imports = [
    (import ./boot.nix inputs)
    (import ./hardware.nix inputs)
    (import ./initial.nix inputs)
    (import ./graphical.nix inputs)
    (import ./integration.nix inputs)
  ];

  config = {
    jzbor-pinenote = {
      boot.enable = mkDefault true;
      hardware.enable = mkDefault true;
      graphical.enable = mkDefault true;
    };
  };
}
