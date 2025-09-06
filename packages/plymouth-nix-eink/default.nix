{ pkgs, ... }: pkgs.stdenvNoCC.mkDerivation {
  name = "plymouth-nix-eink";
  src = ./.;

  dontBuild = true;

  installPhase = ''
    mkdir -pv $out/share/plymouth/themes/nix-eink
    cp -v nix-eink.plymouth nix-eink.script *.png $out/share/plymouth/themes/nix-eink/
    find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
  '';
}
