{ pkgs, ... }:

let
  inherit (pkgs) lib;
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    numpy
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
    rev = "28d2c05ab4e80a7972611cd3188f3e8be4197f6a";
    sha256 = "sha256-r+Dy4lyu1G4eDdmYAQRJho8J/66Cbp91hGTrsPrIU6A=";
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

    wrapProgram $out/bin/waveform_extract.sh \
      --prefix PATH : ${lib.makeBinPath (with pkgs; [ coreutils hexdump ])}
  '';
}
