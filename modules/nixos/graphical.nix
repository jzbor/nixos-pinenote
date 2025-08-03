inputs: { pkgs, config, lib, ... }:

with lib;
with builtins;
let
  cfg = config.jzbor-pinenote.graphical;
in {
  options.jzbor-pinenote.graphical = {
    enable = mkEnableOption "Enable graphical environment for pinenote";

    autologinUser = mkOption {
      type = types.str;
      description = "User to login as";
      default = "pinenote";
    };
  };

  config = mkIf cfg.enable {
    jzbor-pinenote.integration.sway.enable = true;

    environment.systemPackages = with pkgs; [
      sway
      waybar
      wl-clipboard
      xmenu
      brightnessctl
      glib  # for gsettings
      foot
      wmenu
      networkmanagerapplet
      inputs.self.packages."${pkgs.system}".scripts
    ];

    fonts = {
      packages = with pkgs; [
        comic-mono
      ];
      fontconfig.enable = true;
      fontconfig.defaultFonts.monospace = [ "Comic Mono" ];
    };

    services.greetd = {
      enable = true;
      settings = rec {
        initial_session.command = "${pkgs.sway}/bin/sway";
        initial_session.user = cfg.autologinUser;
        default_session = initial_session;
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
      /bin/sh
    '';
  };
}
