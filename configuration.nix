# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

# SET HOME-MANAGER REPOSITORY TO INSTAL
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-22.05.tar.gz";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];

  # HOME MANAGER CONFIG
  home-manager.users.dino = {
      /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
      home.packages = with pkgs; [ cbonsai tree ];

      # HOME-MANAGER VARIABLES
      home.sessionVariables = {
        TERMINAL="kitty";
      };

      # KITTY TERMINAL CONFIG
      programs.kitty = {
        enable = true;
        settings = {
          font_size = "16.0";
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

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "br-abnt2";
    earlySetup = true;
  #   useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "br";
  #services.xserver.xkbOptions = {
  #  "eurosign:e";
  #  "caps:escape" #map caps to escape.
  #};
  
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.sddm.enable = true;  
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dino = {
    isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      initialPassword = "password";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget helix vscodium
    nodejs python310
    firefox git
    google-chrome
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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

