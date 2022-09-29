{ config, pkgs, ... }:

let
  mypolybar = pkgs.polybar.override {
    alsaSupport = true;
    githubSupport = true;
    mpdSupport = true;
    pulseSupport = true;
  };

  # theme adapted from: https://github.com/adi1090x/polybar-themes#-polybar-5
  bars = builtins.readFile ../../config/bars.ini;
  colors = builtins.readFile ../../config/colors.ini;
  mods1 = builtins.readFile ../../config/modules.ini;
  mods2 = builtins.readFile ../../config/user_modules.ini;



  playerctl = ''
    [module/playerctl]
    type = custom/script
    tail = true
    exec = stdbuf -o0 playerctl metadata -Ff '♪ {{trunc(title,20)}} ({{trunc(artist,15)}}) %{A1:playerctl previous:}%{A} %{A1:playerctl play-pause:}<<{{uc(status)}}>>%{A} %{A1:playerctl next:}%{A}' | stdbuf -i0 -o0 sed -e 's/<<PLAYING>>//' -e 's/<<PAUSED>>//'
    exec-if = playerctl metadata -f {{playerName}} 2>/dev/null | grep -v mopidy >/dev/null

    label-maxlen = 60
  '';

  xmonad = ''
    [module/xmonad]
    type = custom/script
    tail = true
    exec = ${pkgs.xmonad-log}/bin/xmonad-log
  '';
in
{
  services.polybar = {
    enable = true;
    package = mypolybar;
    config = ./config.ini;
    extraConfig = bars + colors + mods1 + mods2 + playerctl + xmonad;
    script = ''
      polybar
    '';
  };
}