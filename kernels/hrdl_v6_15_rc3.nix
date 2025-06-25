{ pkgs, fetchFromSourcehut, ... }:

pkgs.linuxPackagesFor (pkgs.linuxKernel.kernels.linux_6_15.override {
  argsOverride = rec {
    src = fetchFromSourcehut {
      owner = "~hrdl";
      repo = "linux";
      rev = "f75fe16d81ae784b8cd2b915113f3a99ff812777";  # v6.15-rc3
      sha256 = "sha256-DhMiZMcwownJJRqIYOj87E/j34jJZb2/rTOhYuMumG4=";
    };
    version = "6.15.0-rc3";
    modDirVersion = "6.15.0-rc3";
    config = builtins.readFile "${src}/arch/arm64/configs/pinenote_defconfig";
  };
})
