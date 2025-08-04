inputs: { pkgs, config, lib, ... }:

with lib;
with builtins;
let
  cfg = config.jzbor-pinenote.initial;
  firmwareDir = "/lib/firmware/rockchip";
  flakePkgs = inputs.self.packages.${pkgs.system};
in {
  options.jzbor-pinenote.initial = {
    enable = mkEnableOption "Enable initial settings for pinenote";
  };

  config = mkIf cfg.enable {
    # basic packages
    environment.systemPackages = with pkgs; [
      git
      htop
      neofetch
      neovim
      squeekboard
    ];

    # Nix settings
    nix.settings = {
      max-substitution-jobs = 128;
      http-connections = 128;
      experimental-features = [ "nix-command" "flakes" ];
    };

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

    # networking, bluetooth and ssh
    networking.networkmanager.enable = true;
    networking.hostName = "pinenote";
    services.openssh.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;

    systemd.services = {
      initial-home = {
        description = "Convert rockchip_ebc ebc.wbf waveform to custom_wf.bin";
        wantedBy = [ "display-manager.service" ];
        after = [ "pinenote-hrdl-extract-waveform.service" ];
        before = [ "display-manager.service" ];

        serviceConfig = {
          Type = "oneshot";
          ExecCondition = concatStringsSep " && " [
            "${pkgs.coreutils}/bin/test ! -e /home/pinenote/.config"
          ];
          ExecStart = "/bin/sh -c '" +(concatStringsSep " && " [
            "cp -rv ${./initial-home} /home/pinenote/.config"
          ]) + "'";
        };
      };

      pinenote-init-convert-waveform = {
        description = "Convert rockchip_ebc ebc.wbf waveform to custom_wf.bin";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "${pkgs.writeShellScript "init-waveform.sh" ''
            if [ -e ${firmwareDir}/custom_wf.bin ]; then
              echo "Nothing to do (${firmwareDir}/custom_wf.bin already exists)"
              exit 0
            fi


            if [ -e ${firmwareDir}/ebc.wbf ]; then
              echo "Removing old extraction file ${firmwareDir}/ebc.wbf"
              rm -f "${firmwareDir}/ebc.wbf"
            fi


            echo "Extracting waveforms"
            mkdir -vp ${firmwareDir}
            ${flakePkgs.hrdl-utils}/bin/waveform_extract.sh


            echo "Converting waveforms"
            cd /tmp
            ${flakePkgs.hrdl-utils}/bin/wbf_to_custom.py ${firmwareDir}/ebc.wbf
            mv -v custom_wf.bin ${firmwareDir}/


            echo "Reloading driver"
            modprobe -v -r rockchip_ebc
            modprobe -v rockchip_ebc

            echo "Done"
          ''}";
        };
      };

      # pinenote-hrdl-convert-waveform = {
      #   description = "Convert rockchip_ebc ebc.wbf waveform to custom_wf.bin";
      #   wantedBy = [ "display-manager.service" ];
      #   after = [ "pinenote-hrdl-extract-waveform.service" ];
      #   before = [ "display-manager.service" ];

      #   serviceConfig = {
      #     Type = "oneshot";
      #     ExecCondition = concatStringsSep " && " [
      #       "${pkgs.coreutils}/bin/test ! -e /lib/firmware/rockchip/custom_wf.bin"
      #       "${pkgs.coreutils}/bin/test -e /lib/firmware/rockchip/ebc.wbf"
      #     ];
      #     ExecStart = "/bin/sh -c '" +(concatStringsSep " && " [
      #       "cd /tmp"
      #       "${flakePkgs.hrdl-utils}/bin/wbf_to_custom.py ${firmwareDir}/ebc.wbf"
      #       "mv custom_wf.bin ${firmwareDir}/custom_wf.bin"
      #       # "mkinitcpio -P"  -- Not sure what the NixOS equivalent would be
      #       "(modprobe -r rockchip_ebc; modprobe rockchip_ebc)"
      #     ]) + "'";
      #   };
      # };

      # pinenote-hrdl-extract-waveform = {
      #   description = "Extract rockchip_ebc ebc.wbf waveform from waveform partition";
      #   wantedBy = [ "default.target" ];

      #   serviceConfig = {
      #     Type = "oneshot";
      #     ExecCondition = "${pkgs.coreutils}/bin/test ! -e /lib/firmware/rockchip/ebc.wbf";
      #     ExecStart = "${flakePkgs.hrdl-utils}/bin/waveform_extract.sh";
      #   };
      # };
    };
  };
}
