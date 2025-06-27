{ pkgs, config, lib, perSystem, ... }:

with lib;
with builtins;
let
  cfg = config.jzbor-pinenote.initial;
  firmwareDir = "/lib/firmware/rockchip";
in {
  options.jzbor-pinenote.initial = {
    enable = mkEnableOption "Enable initial settings for pinenote";
  };

  config = mkIf cfg.enable {

    # user
    users.users.pinenote = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "pinenote";
    };
    security.sudo = {
      enable = true;
      execWheelOnly = true;
    };

    # networking and ssh
    networking.networkmanager.enable = true;
    networking.hostName = "pinenote";
    services.openssh.enable = true;

    systemd.services.pinenote-hrdl-convert-waveform = {
      description = "Convert rockchip_ebc ebc.wbf waveform to custom_wf.bin";
      requiredBy = [ "display-manager.service" ];
      after = [ "pinenote-hrdl-extract-waveform.service" ];
      before = [ "display-manager.service" ];

      serviceConfig = {
        Type = "oneshot";
        ExecCondition = concatStringsSep " && " [
          "${pkgs.coreutils}/bin/test ! -e /usr/lib/firmware/rockchip/custom_wf.bin"
          "${pkgs.coreutils}/bin/test -e /usr/lib/firmware/rockchip/ebc.wbf"
        ];
        ExecStart = "/bin/sh -c '" +(concatStringsSep " && " [
          "cd /tmp"
          "${perSystem.self.hrdl-utils}/bin/wbf_to_custom.py ${firmwareDir}/ebc.wbf"
          "mv custom_wf.bin ${firmwareDir}/custom_wf.bin"
          # "mkinitcpio -P"  -- Not sure what the NixOS equivalent would be
          "(modprobe -r rockchip_ebc; modprobe rockchip_ebc)"
        ]) + "'";
      };
    };

    systemd.services.pinenote-hrdl-extract-waveform = {
      description = "Extract rockchip_ebc ebc.wbf waveform from waveform partition";
      wantedBy = [ "default.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecCondition = "${pkgs.coreutils}/bin/test ! -e /usr/lib/firmware/rockchip/ebc.wbf";
        ExecStart = "${perSystem.self.hrdl-utils}/bin/waveform_extract.sh";
      };
    };
  };
}
