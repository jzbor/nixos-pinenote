{ pkgs, fetchFromSourcehut, ... }:

pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_15.override {
  argsOverride = rec {
    src = fetchFromSourcehut {
      owner = "~hrdl";
      repo = "linux";
      rev = "v6.15-rc3";
      sha256 = "sha256-wcReSz4PryusANbjMQylnzHXMgmKZ+s4+L57gpEayF0=";
    };
    version = "6.15.0-rc3";
    modDirVersion = "6.15.0-rc3";
    config = builtins.readFile "${src}/arch/arm64/configs/pinenote_defconfig";
  };
})
