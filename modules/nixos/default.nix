{ lib, ... }:

with lib;
{
  imports = [
    ./boot.nix
    ./hardware.nix
  ];

  config = {
    jzbor-pinenote.boot.enable = mkDefault true;
    jzbor-pinenote.hardware.enable = mkDefault true;
  };
}
