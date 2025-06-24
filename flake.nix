{
  description = "jzbor's NixOS port for the pinenote";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: (inputs.blueprint {
    inherit inputs;
    systems = [ "aarch64-linux" ];
  }) // {
    legacyPackages."aarch64-linux" = import ./kernels inputs.nixpkgs.legacyPackages."aarch64-linux";
  };
}
