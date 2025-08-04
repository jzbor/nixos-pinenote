inputs: { pkgs, lib, config, ... }:

with lib;
let
  cfg = config.jzbor-pinenote.hardware;
  flakePkgs = inputs.self.packages.${pkgs.system};
in {
  options.jzbor-pinenote.hardware = {
    enable = mkEnableOption "Enable hardware customizations for pinenote";
  };

  config = mkIf cfg.enable {
    # udev rules
    services.udev.packages = [
      (pkgs.writeTextDir "lib/udev/rules.d/81-libinput-pinenote.rules" ''
        ACTION=="remove", GOTO="libinput_device_group_end"
        KERNEL!="event[0-9]*", GOTO="libinput_device_group_end"

        ATTRS{phys}=="?*", ATTRS{name}=="cyttsp5", ENV{LIBINPUT_DEVICE_GROUP}="pinenotetouch"
        ATTRS{phys}=="?*", ATTRS{name}=="w9013 2D1F:0095 Stylus", ENV{LIBINPUT_DEVICE_GROUP}="pinenotetouch"
        #ATTRS{phys}=="?*", ATTRS{name}=="w9013 2D1F:0095 Stylus", ENV{ID_INPUT_HEIGHT_MM}=""
        #ATTRS{phys}=="?*", ATTRS{name}=="w9013 2D1F:0095 Stylus", ENV{ID_INPUT_WIDTH_MM}=""
        #ATTRS{phys}=="?*", ATTRS{name}=="cyttsp5", PROGRAM=="/usr/local/bin/is_smaeul_kernel", ENV{LIBINPUT_CALIBRATION_MATRIX}="-1 0 1 0 -1 1"
        ATTRS{phys}=="?*", ATTRS{name}=="cyttsp5", ENV{LIBINPUT_CALIBRATION_MATRIX}="-1 0 1 0 -1 1"

        LABEL="libinput_device_group_end"
      '')

      (pkgs.writeTextDir "lib/udev/rules.d/83-backlight.rules" ''
        SUBSYSTEM=="backlight", ACTION=="add", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
      '')

      (pkgs.writeTextDir "lib/udev/rules.d/84-rockchip-ebc-power.rules" ''
        DRIVER=="rockchip-ebc", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/%p/power/control", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/%p/power/control"
      '')
    ];

    # libinput quirks for touch input
    environment.etc."libinput/local-overrides.quirks".text = ''
      [PineNote]
      MatchName=cyttsp5
      AttrPalmPressureThreshold=27
      AttrThumbPressureThreshold=28
      AttrSizeHint=210x157
      #AttrResolutionHint=4x4
      #AttrPalmSizeThreshold=1
    '';

    # file system setup
    fileSystems."/" = {
      label = "nixos";
      fsType = "f2fs";
    };

    hardware.deviceTree.name = "rockchip/pn.dtb"; # workaround: current uboot has a 127 char limit for the path
    hardware.firmware = [
      flakePkgs.pinenote-firmware
      pkgs.raspberrypiWirelessFirmware
    ];
  };
}
