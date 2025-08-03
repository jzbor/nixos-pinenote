{
  description = "jzbor's NixOS port for the pinenote";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    nix-wallpaper = {
      url = "github:lunik1/nix-wallpaper";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = inputs: (inputs.blueprint {
    inherit inputs;
    systems = [ "aarch64-linux" ];
  })
  // (import ./misc inputs)
  // {
    nixosModules.default = import ./modules/nixos inputs;
  };
}
