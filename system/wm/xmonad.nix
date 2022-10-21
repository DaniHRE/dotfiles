{ config, lib, pkgs, ... }:

{
  services = {
    gnome.gnome-keyring.enable = true;
    upower.enable = true;

    dbus = {
      enable = true;
      packages = [ pkgs.dconf ];
    };

    xserver = {
      enable = true;
      layout = "br";

      libinput = {
        enable = true;
        touchpad = {
            disableWhileTyping = true;
          };
      };

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "caps:ctrl_modifier";
    };
  };

  # Pulseaudio Config
  hardware.pulseaudio = {
    enable = true;
    # extraModules = [ pkgs.pulseaudio-modules-bt ];
    package = pkgs.pulseaudioFull;
  };

  # Enable Bluetooth Support
  hardware.bluetooth.enable = true;

  # Enable Blueman Service
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}