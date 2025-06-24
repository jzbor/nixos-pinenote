{ flake, pkgs, ... }: flake.legacyPackages."${pkgs.system}".linuxPackages-pinenote.kernel
