{ config, pkgs, lib, flake, ... }:

with lib;
let
  cfg = config.jzbor-pinenote.boot;
in {
  options.jzbor-pinenote.boot = {
    enable = mkEnableOption "Enable boot customizations for pinenote";
  };

  config = mkIf cfg.enable {
    boot = {
      loader.grub.enable = false;
      loader.generic-extlinux-compatible.enable = true;

      kernelPackages = flake.legacyPackages.${pkgs.system}.linuxPackages-pinenote;

      initrd.includeDefaultModules = false;
      initrd.availableKernelModules = [
        "gpio-rockchip"
        "ext4"
        "mmc_block"
        "usbhid"
        "hid_generic"
      ];

      extraModprobeConfig = ''
        options rockchip_ebc dithering_method=2 default_hint=0xa0 early_cancellation_addition=2 redraw_delay=200
        options brcmfmac feature_disable=0x82000
      '';
    };
  };
}
