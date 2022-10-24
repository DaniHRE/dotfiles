{ config, lib, pkgs, ... }:

{
  programs.dconf.enable = true;

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

      # Enable Touchpad Support in Xmonad Environment
      # libinput = {
      #   enable = true;
      #   touchpad = {
      #       disableWhileTyping = true;
      #     };
      # };

      serverLayoutSection = ''
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"     "0"
      '';

      displayManager.defaultSession = "none+xmonad";

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };

      xkbOptions = "caps:ctrl_modifier";
    };
  };

  # Enable Bluetooth Support
  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  # Enable Blueman Service
  services.blueman.enable = true;

  systemd.services.upower.enable = true;
}