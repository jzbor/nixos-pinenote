{ pkgs, config, lib, ... }:

with lib;
with builtins;
let
  cfg = config.jzbor-pinenote.graphical;
in {
  options.jzbor-pinenote.graphical = {
    enable = mkEnableOption "Enable graphical environment for pinenote";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session.command = "${pkgs.sway}/bin/sway";
        initial_session.user = "pinenote";
        default_session = initial_session;
      };
    };
  };
}
