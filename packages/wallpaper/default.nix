{ pkgs, inputs, ... }:

inputs.nix-wallpaper.packages."${pkgs.system}".default.override {
  backgroundColor = "#ffffff";
  width = 1872;
  height = 1872;
  logoSize = 30.0;
  logoColors = rec {
    color0 = "#000000";
    color1 = color0;
    color2 = color0;
    color3 = color0;
    color4 = color0;
    color5 = color0;
  };
}
