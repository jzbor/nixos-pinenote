{ lib, ... }:

with lib;
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./initial.nix
    ./graphical.nix
    ./integration.nix
  ];

  config = {
    jzbor-pinenote = {
      boot.enable = mkDefault true;
      hardware.enable = mkDefault true;
      graphical.enable = mkDefault true;
    };
  };
}
