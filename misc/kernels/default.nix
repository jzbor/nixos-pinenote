pkgs:

rec {
  linuxPackages-pinenote = linuxPackages-hrdl_v6_17_rc5;
  linuxPackages-hrdl_v6_15_rc3 = pkgs.callPackage ./hrdl_v6_15_rc3.nix {};
  linuxPackages-hrdl_v6_17_rc5 = pkgs.callPackage ./hrdl_v6_17_rc5.nix {};
}

