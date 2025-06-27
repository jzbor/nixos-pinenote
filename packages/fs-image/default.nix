{ flake, inputs, pkgs }:

let
  inherit (inputs) nixpkgs;
  make-disk-image = import "${nixpkgs}/nixos/lib/make-disk-image.nix";
  image = make-disk-image {
    inherit (flake.nixosConfigurations.pinenote) config;
    inherit pkgs;
    inherit (pkgs) lib;

    bootSize = "0M";
    installBootLoader = false;
    copyChannel = false;
    memSize = 4096;
    format = "raw";
  };
in pkgs.stdenvNoCC.mkDerivation {
  name = "pinenote-image.img.zstd";
  dontUnpack = true;
  buildPhase = ''
    ${pkgs.zstd}/bin/zstd ${image}/nixos.img -o $out
  '';
}
