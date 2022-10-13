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
      # Window manager
      ./system/wm/xmonad.nix
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

  # SET DEFAULT BOOT LOADER
  boot.loader = {    
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
    efi.efiSysMountPoint = "/boot";
  };
  
  networking.hostName = "dino-flash"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    earlySetup = true;
  #   useXkbConfig = true; # use xkbOptions in tty.
  };
  
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager = {
    sddm.enable = true;
  };

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable Bluetooth Support
  hardware.bluetooth.enable = true;

  # Enable Bluetooth Service
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
    git # Open source version control system.
    helix # Advanced Terminal Text Editor.
    vscodium # Advanced Text editor.
    nodejs # Latest LTS NodeJS version.
    python310 # Python 3.10.
    playerctl # Command-Line Utility and Library for controlling media players.
    direnv # Create Dynamic Development Environment using Nix.
    ghc # A Glasgow Haskell Compiler.
    betterlockscreen # Better Clean and Stable Lock Screen.
    python310Packages.pip # Python Package Instaler.
    python39Packages.virtualenv # Python Virtual Environment Instaler.
 ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  system.stateVersion = "22.05"; # Did you read the comment?

}
