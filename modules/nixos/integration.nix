inputs: { pkgs, config, lib, ... }:

with lib;
with builtins;
let
  cfg = config.jzbor-pinenote.integration;
  flakePkgs = inputs.self.packages.${pkgs.system};
in {
  options.jzbor-pinenote.integration = {
    sway.enable = mkEnableOption "Enable compositor integration for pinenote service";
    package = mkPackageOption flakePkgs "pinenote-service" {};
  };

  config = {
    systemd.user.services.sway-dbus-integration = mkIf cfg.sway.enable {
      description = "sway-dbus-integration";
      wantedBy = [ "graphical.target" ];
      wants = [ "graphical.target" ];
      after = [ "graphical.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${flakePkgs.hrdl-utils}/bin/sway_dbus_integration.py";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    systemd.user.services.pinenote-service-sway = mkIf cfg.sway.enable {
      description = "pinenote-service";
      wantedBy = [ "graphical.target" ];
      wants = [ "graphical.target" ];
      after = [ "graphical.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = "${flakePkgs.pinenote-service}/bin/pinenote-service --sway";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
