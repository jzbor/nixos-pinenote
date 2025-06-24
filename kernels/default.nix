pkgs:

rec {
  linuxPackages-pinenote = linuxPackages-hrdl_v6_15_rc3;
  linuxPackages-hrdl_v6_15_rc3 = pkgs.callPackage ./hrdl_v6_15_rc3.nix {};
}

