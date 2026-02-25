{ pkgs, ... }:

pkgs.linuxPackagesFor ((pkgs.callPackage ({ pkgs, buildLinux, ... }@args: pkgs.buildLinux (args // rec {
    src = pkgs.fetchFromSourcehut {
      owner = "~hrdl";
      repo = "linux";
      rev = "46028a0e2658877625568f2134e243b304966ef4";  # v6.19
      sha256 = "sha256-Y96Yae3SLoTJoRLqjeMK7lubBCsJUrc/1Lk6Eyfm6K0=";
    };
    version = "6.19.0";
    modDirVersion = version;
    defconfig = "pinenote_defconfig";

    # These are required to make the build work:
    extraConfig = ''
      VIDEO_THP7312 n
      CRYPTO_AEGIS128_SIMD n
      ROCKCHIP_DW_HDMI_QP n
    '';
    ignoreConfigErrors = true;
  }
)) {}).overrideAttrs (old: {
  postInstall = ''
    cp "$out/dtbs/rockchip/rk3566-pinenote-v1.2.dtb" "$out/dtbs/rockchip/pn.dtb"
    ${old.postInstall}
  '';
}))
