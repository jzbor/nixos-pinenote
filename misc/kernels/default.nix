pkgs:

rec {
  linuxPackages-pinenote = linuxPackages-hrdl_v6_19_ultra_suspend;
  linuxPackages-hrdl_v6_15_rc3 = pkgs.callPackage ./hrdl_v6_15_rc3.nix {};
  linuxPackages-hrdl_v6_17_rc5 = pkgs.callPackage ./hrdl_v6_17_rc5.nix {};
  linuxPackages-hrdl_v6_19 = pkgs.callPackage ./hrdl_v6_19.nix {};
  linuxPackages-hrdl_v6_19_ultra_suspend = pkgs.callPackage ./hrdl_v6_19_ultra_suspend.nix {};
}

