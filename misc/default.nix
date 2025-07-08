inputs:

inputs.nixpkgs.lib.recursiveUpdate (
  inputs.flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in {
      legacyPackages = {
        test-vm = pkgs.callPackage ./test-vm.nix { inherit inputs; };
        scripts = import ../scripts/packages.nix pkgs inputs;
      };
    }
  )
) (
  let
    pkgs = inputs.nixpkgs.legacyPackages.aarch64-linux;
  in {
    legacyPackages.aarch64-linux = import ./kernels pkgs;
  }
)

