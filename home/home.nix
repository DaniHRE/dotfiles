{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";

  defaultPkgs = with pkgs; [
    firefox
    google-chrome
    discord
    lazygit
    cbonsai
    tree
  ];

in {

  imports = [(import "${home-manager}/nixos")]; 

  # HOME MANAGER CONFIG
  home-manager.users.dino = {
      home.packages = defaultPkgs;

      # IMPORT ALL PROGRAMS INSIDE FOLDER
      imports = (import ./programs) ++ (import ./services);

      # ZSH
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableSyntaxHighlighting = true;
        history = {
          size = 5000;
          path = "$HOME/.local/share/zsh/history";
        };
        plugins = [
          {
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
            file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          }
          {
            name = "powerlevel10k-config";
            src = ../config/term;
            file = "p10k.zsh";
          }
        ];
      };

      # HOME-MANAGER VARIABLES
      home.sessionVariables = {
        TERMINAL="kitty";
      };

      # KITTY TERMINAL CONFIG
      programs.kitty = {
        enable = true;
        settings = {
          font_size = "14.0";
          font_family      = "FiraCode Nerd Font";
          bold_font        = "auto";
          italic_font      = "auto";
          bold_italic_font = "auto";
          background = "#001e26";
          foreground = "#708183";
          selection_foreground ="#93a1a1";
          selection_background = "#002b36";
          cursor = "#708183";

          color0  = "#002731";
          color1  = "#d01b24";
          color2  = "#728905";
          color3  = "#a57705";
          color4  = "#2075c7";
          color5  = "#c61b6e";
          color6  = "#259185";
          color7  = "#e9e2cb";
          color8  = "#001e26";
          color9  = "#bd3612";
          color10 = "#465a61";
          color11 = "#52676f";
          color12 = "#708183";
          color13 = "#5856b9";
          color14 = "#81908f";
          color15 = "#fcf4dc";

        };
      };

      # GIT CONFIG
      programs.git = {
        enable = true;
        userName  = "Daniel Henrique";
        userEmail = "henriqueevaldo@outlook.com";
      };
  };

}