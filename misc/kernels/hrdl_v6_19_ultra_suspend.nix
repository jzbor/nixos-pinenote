{ pkgs, ... }:

pkgs.linuxPackagesFor ((pkgs.callPackage ({ pkgs, buildLinux, ... }@args: pkgs.buildLinux (args // rec {
    src = pkgs.fetchFromSourcehut {
      owner = "~hrdl";
      repo = "linux";
      rev = "ee2c553f7893e82223e42436cebbcf8c4958464d";  # v6.19_ultra_suspend
      sha256 = "sha256-whCqW5t/yZGdJR6ZkX/4lbQ7RhYM3jikHZhO4TEhZLc=";
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
