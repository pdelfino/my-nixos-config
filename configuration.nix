# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running â€˜nixos-helpâ€™).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hosts.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.useOSProber = true;

  # Use the latest kernel
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "system"; # Define your hostname.
  networking.networkmanager.enable = true; 
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.wireless.networks = {
  #"La Fazenda Fase1" = { # SSID with spaces and/or special characters
  #psk = "fazenda2017"; };
  #};
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";
  # nix.gc.automatic = true;
  # nix.gc.options = "--delete-older-than 10d";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! 
    wget firefox emacs sbcl git
    htop xorg.xkill fish curl gzip zip unzip tldr pcmanfm nitrogen
    #pkgs.gnome3.gnome-tweaks
    wl-clipboard xclip xsel libsForQt5.kdenlive 
     haskellPackages.osdkeys simplescreenrecorder
    kooha
    cloc gnupg pass pinentry-gtk2
    ispell gnumake sqlitebrowser zeal
    calibre vlc gimp dia inkscape pandoc libreoffice transmission-qt imagemagick apngasm
    partition-manager
    skype
    marble kontact korganizer kaddressbook kleopatra kmail konversation digikam kcalc
    okular spectacle ccl audacity stow libsForQt5.kmail-account-wizard thunderbird rescuetime wakatime haskellPackages.arbtt gnomeExtensions.arbtt-stats
    postman
    discord
    cabal-install ghc stack haskell-language-server
    python38
    insomnia
    maven jdk8 jetbrains.idea-community
    foxitreader
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # Fingerprint reader: login and unlock with fingerprint (if you add one with `fprintd-enroll`)
  # services.fprintd.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  # services.avahi.enable = true;
  # services.avahi.nssmdns = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  # use the intel/nvidia driver
  # services.xserver.videoDrivers = [ "intel" "nvidia" ];

  # use the external dock
  # services.xserver.videoDrivers = [ "displaylink" "intel" ];

  # simplest configuration
  services.xserver.videoDrivers = [ "modesetting" "intel"];

  services.xserver = {
     enable = true;
     displayManager.gdm.enable = true;
     desktopManager.gnome.enable = true;
     xkbOptions = "ctrl:swapcaps";
  };
  
  environment.gnome.excludePackages = [  pkgs.epiphany ];

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  #services.xserver.layout = "us";
  #services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.autoLogin.enable = false;
  #services.xserver.desktopManager.plasma5.enable = true;

  # Virtualization services
  virtualisation.docker.enable = false;
  virtualisation.virtualbox.host.enable = true;
  
  # Define a user account. Don't forget to set a password with â€˜passwdâ€™.
  users.users.pedro = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable â€˜sudoâ€™ for the user.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. Itâ€˜s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}
