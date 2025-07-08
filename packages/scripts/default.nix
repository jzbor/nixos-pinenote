{ pkgs, inputs, ...}:

with builtins;
pkgs.symlinkJoin {
  name = "pinenoteScripts";
  paths = attrValues inputs.self.legacyPackages.${pkgs.system}.scripts;
}
