{ pkgs, inputs, ...}:

let
  hostPkgs = pkgs;
  system = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = [
      ../hosts/pinenote/configuration.nix
      ({ lib, config, ...}:
      {
        jzbor-pinenote.boot.enable = false;
        jzbor-pinenote.graphical.enable = false;
        boot.loader.grub.enable = false;

        virtualisation.vmVariant.virtualisation.host.pkgs = hostPkgs;

        # programs.sway.enable = true;

        services.xserver = {
          enable = true;
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };

        environment.gnome.excludePackages = (with pkgs; [
          atomix # puzzle game
          cheese # webcam tool
          epiphany # web browser
          evince # document viewer
          geary # email reader
          gedit # text editor
          gnome-characters
          gnome-music
          gnome-photos
          gnome-terminal
          gnome-tour
          hitori # sudoku game
          iagno # go game
          tali # poker game
          totem # video player
        ]);

      })
    ];
    specialArgs = { inherit inputs; };
  };
in system.config.system.build.vm
