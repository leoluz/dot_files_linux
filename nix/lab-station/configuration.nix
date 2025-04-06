# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "lab-station"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [
      # Palworld server
      27015 8211
    ];
  };

  # docker configs
  virtualisation.docker.enable = true;

  # enable usb redirection on quickemu
  #https://github.com/quickemu-project/quickemu/wiki/05-Advanced-quickemu-configuration#usb-redirection
  virtualisation.spiceUSBRedirection.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # enables support for Bluetooth
  hardware.bluetooth.enable = true; 
  # powers up the default Bluetooth controller on boot
  hardware.bluetooth.powerOnBoot = true;

  hardware.enableAllFirmware = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  # enables scanner HP
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # https://nixos.wiki/wiki/Tailscale
  services.tailscale.enable = false;

  # https://flatpak.org/setup/NixOS
  services.flatpak.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
      defaultSession = "plasma";
      sddm = { 
        enable = true;
        wayland.enable = true;
      };
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable Sunshine service
  # To manually start the service run: systemctl --user start sunshine
  services.sunshine = {
      enable = true;
      autoStart = false;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        output_name = 1;
      };
      applications = {
        env = {
          PATH = "$(PATH):$(HOME)/.local/bin";
        };
        apps = [
          {
            name = "Steam";
            output = "sunshine-steam.log";
            detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://open/bigpicture"];
            image-path = "steam.png";
          }
          {
            name = "Palworld";
            output = "sunshine-palworld.log";
            detached = ["${pkgs.util-linux}/bin/setsid ${pkgs.steam}/bin/steam steam://rungameid/1623730"];
            image-path = "/home/leoluz/.config/sunshine/covers/igdb_151665.png";
          }
          {
            name = "Steam Flatpak";
            output = "sunshine-steam-flatpak.log";
            cmd = "${pkgs.flatpak}/bin/flatpak run com.valvesoftware.Steam steam://open/bigpicture";
            image-path = "steam.png";
          }
        ];
      };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.leoluz = {
    isNormalUser = true;
    description = "Leo";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      firefox
      google-chrome
      _1password-gui
      _1password
      vrrtest
      discord
      protonup-qt
      steamPackages.steamcmd
      qbittorrent
      docker-compose
      delve
      popsicle # flash image utility
      sabnzbd # usenet downloader
      spotify
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    kdePackages.partitionmanager
    kdePackages.kate
    gcc
    neovim
    git
    go
    python3
    cmake
    gnumake
    nodejs_22
    vesktop
    mangohud
    quickemu
    hplip # HP printer drivers
    simple-scan
    # linuxKernel.packages.linux_zen.xpadneo
    # xwaylandvideobridge
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    gamescopeSession.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "leoluz" ];
  };

  programs.gamemode.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Configure AppImage to be invoked directly
  # https://nixos.wiki/wiki/Appimage
  programs.appimage = {
      enable = true;
      binfmt = true;
  };

  # https://github.com/viperML/nh
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/leoluz/git/dot_files_linux/nix/lab-station";
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
}
