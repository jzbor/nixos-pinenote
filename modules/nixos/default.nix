{ lib, ... }:

with lib;
{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./initial.nix
    ./graphical.nix
  ];

  config = {
    jzbor-pinenote.boot.enable = mkDefault true;
    jzbor-pinenote.hardware.enable = mkDefault true;
    jzbor-pinenote.graphical.enable = mkDefault true;
  };
}
