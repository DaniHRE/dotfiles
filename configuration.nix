# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [ 
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # User config
      ./home/home.nix
    ];
  
  # DEFINE ZSH TO ENABLE TO USER
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  users.users.dino.shell = pkgs.zsh;

  # FONTS
  fonts = {
    fonts = with pkgs; [
      # Regular fonts
      (nerdfonts.override {
        fonts = [ "FiraCode" "DroidSansMono" "FiraMono" ];
      })
      dejavu_fonts
      font-awesome

      # Japanese fonts
      rictydiminished-with-firacode
      hanazono
      ipafont
      kochi-substitute
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" "IPAGothic" ];
        sansSerif = [ "DejaVu Sans" "IPAPGothic" ];
        serif = [ "DejaVu Serif" "IPAPMincho" ];
      };
    };
  };

  # ALLOW SOFTWARE WITH UNFREE LICENSE
  nixpkgs.config.allowUnfree = true;

    
  networking.hostName = "dino-nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    earlySetup = true;
  #   useXkbConfig = true; # use xkbOptions in tty.
  };
  
  services.xserver = {
  	enable = true;
  	displayManager.gdm.enable = true;
  	desktopManager.gnome.enable = true;
  };  

  # Enable Audio
  sound.enable = true;

  # Pulseaudio Config
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable Blueman Service
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dino = {
    isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      initialPassword = "password";
  };

  # DISCORD AUTO UPDATE (CHANGE TARBAL LINK .TAR.GZ)
  nixpkgs.overlays = [(self: super: { discord = super.discord.overrideAttrs (_: { src = builtins.fetchTarball https://dl.discordapp.net/apps/linux/0.0.19/discord-0.0.19.tar.gz; });})];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget # Download Internet Data by HTTPS, HTTPS or FTP Protocol.
    calc # C-Style Calculator
    pywal # Generate and change colorschemes on the fly.
    git # Open source version control system.
    vscodium # Advanced Text editor.
    papirus-icon-theme # Papirus Icon Theme
    terminus-nerdfont # Terminus Nerd Font Pack
    iosevka # Iosevka Font
    nodejs # Latest LTS NodeJS version.
    yarn # Dependency manager for javascript
    python310 # Python 3.10.
    hyper # Hyper Terminal Emulator
    playerctl # Command-Line Utility and Library for controlling media players.
    direnv # Create Dynamic Development Environment using Nix.
    betterlockscreen # Better Clean and Stable Lock Screen.
    python310Packages.pip # Python Package Instaler.
    python39Packages.virtualenv # Python Virtual Environment Instaler.
    pkgs.nodePackages_latest.pnpm # Alternative Node Package Manager
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true; 
  };

  # List services that you want to enable:

  system.stateVersion = "24.05"; # Did you read the comment?

}
