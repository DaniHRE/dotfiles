{
  xsession = {
    enable = true;

    initExtra = ''
      nitrogen --restore &
      pasystray &
      blueman-applet &
      nm-applet --sm-disable --indicator &
    '';

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
      config = ./config.hs;
    };
  };
}