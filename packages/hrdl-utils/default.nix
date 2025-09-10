{ pkgs, ... }:

let
  inherit (pkgs) lib;
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    numpy
    dbus-next
    i3ipc
    crcmod
    (with pkgs.python3Packages; buildPythonPackage {
      name = "pylibi2c";
      version = "unstable";
      format = "pyproject";
      propagatedBuildInputs = [ setuptools setuptools-scm ];
      src = pkgs.fetchFromGitHub {
        owner = "amaork";
        repo = "libi2c";
        rev = "dcdf6c671e84d88ab82a863251e01c024e2fdf94";
        sha256 = "sha256-ZXP699wDab2wJnHUK6EDojCcXMarvKURP9d6dHNSPck=";
      };
    })
  ]);
in pkgs.stdenvNoCC.mkDerivation {
  name = "hrdl-utils";
  meta = with lib; {
    description = "Various scripts from hrdls pinenote-dist repo";
    license = licenses.gpl3Only;
    homepage = "https://git.sr.ht/~hrdl/pinenote-dist";
  };

  src = pkgs.fetchFromSourcehut {
    owner = "~hrdl";
    repo = "pinenote-dist";
    rev = "717409008ec30b1673ce0ad615c8ab22f341eda4";
    sha256 = "sha256-c2aWd++3dAOaTSrm6auL2NhI5LBhI4QYAbXiJpRc2Ys=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper ];
  buildInputs = with pkgs; [ pythonEnv hexdump ];

  patchPhase = ''
    sed -i 's/\/usr\/lib\//\/lib\//g' bin/waveform_extract.sh
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp bin/read_file.py $out/bin/
    cp bin/wbf_to_custom.py $out/bin/
    cp bin/waveform_extract.sh $out/bin/
    cp bin/rockchip_ebc_custom_ioctl.py $out/bin/
    cp bin/sway_dbus_integration.py $out/bin/
    cp bin/cyttsp5_update_config.py $out/bin/

    wrapProgram $out/bin/waveform_extract.sh \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [ coreutils hexdump ])}
  '';
}
