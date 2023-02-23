# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <musnix>
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 1;

  systemd.sleep.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
    HibernateDelaySec=35m
  '';

  networking.hostName = "glitter"; # Define your hostname.
  # Pick only one of the below networking options.
  # Use the below lines to enable WPS
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.wireless.userControlled.enable = true;
  # networking.wireless.extraConfig = ''
  #   update_config=1
  # '';
  # Disable these to use WPS
  networking.networkmanager.enable = true;
  networking.enableIPv6 = false; # Disable this once booted successfully
  # The doc for this option says it all, i have this problem at Northeastern
  networking.resolvconf.dnsSingleRequest = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "dvorak";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  location = {
    provider = "manual";
    latitude = 42.32;
    longitude = -71.09;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager = {
    defaultSession = "none+awesome";
    lightdm.enable = true;
    autoLogin = {
      enable = true;
      user = "luna";
    };
  };
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.luaPackages; [
      luarocks
      luadbi-mysql
    ];
  };
  #services.getty.autologinUser = "luna";

  # Configure keymap in X11
  services.xserver.layout = "dvorak";
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  services.blueman.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 2200;
  };

  services.udev.extraRules =
    ''SUBSYSTEM=="power_supply", '' +
    ''ATTR{status}=="Discharging", '' +
    ''ATTR{capacity}=="[0-5]", '' +
    ''RUN+="${pkgs.systemd}/bin/systemctl hibernate"'';

  services.gnome.gnome-keyring.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth = {
      enable = true;
      settings = {
          General = {
              Enable = "Source,Sink,Media,Socket";
          };
      };
  };

  # For grapejuice / roblox, apparently
  # https://brinkervii.gitlab.io/grapejuice/docs/Installing-Graphics-Libraries.html
  hardware.opengl.driSupport32Bit = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  programs.zsh.enable = true;

  # digital audio
  musnix.enable = true;
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.luna = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "input" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config = { allowUnfree = true; };
  # 22.11 broke my networkmanager for eduroam (1.40.2 changed something about EAP maybe?)
  # so i tried to backport 1.38.4 to my system. but, webkitgtk depends on
  # libproxy depends on networkmanager (why??), thus requiring me to built
  # webkit, which is a non-starter. so, onto a different solution
  #nixpkgs.overlays = [
  #  (self: super: {
  #    networkmanager = super.networkmanager.overrideAttrs (oldAttrs: {
  #      version = "1.38.4";
  #      src = self.fetchurl {
  #        url = "mirror://gnome/sources/NetworkManager/1.38/NetworkManager-1.38.4.tar.xz";
  #        sha256 = "sha256-hB9k1Bd2qt2SsVH0flD2K+igYRqQVv5r+BiBAk5qlsU=";
  #      };
  #      patches = [
  #        (with self; self.substituteAll {
  #          src = /etc/nixos/networkmanager-fix-paths.patch;
  #          inherit iputils kmod openconnect ethtool gnused systemd;
  #          inherit runtimeShell;
  #        })
  #        # there's an existing path here idk how path's work so just steal it
  #        (builtins.elemAt oldAttrs.patches 1)
  #      ];
  #      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [self.intltool];
  #    });
  #  })
  #];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # likely to run from dmenu / .desktop
    (discord.override {
        nss = pkgs.nss_latest;
    })
    dmenu
    firefox
    # roblox + wine is called grapejuice, which is out-of-date
    (grapejuice.overrideAttrs (oldAttrs: {
      version = "7.2.1";
      src = fetchFromGitLab {
        owner = "BrinkerVII";
        repo = "grapejuice";
        rev = "v7.2.1";
        sha256 = "sha256-bx0jqG03GSHj1lO9NRh8DJRUyJBbyVUKCy/2pZ3OWas=";
      };
      propagatedBuildInputs = with python3Packages; oldAttrs.propagatedBuildInputs ++ [
        pydantic
      ];
    }))
    gthumb
    killall
    kitty
    krita
    libreoffice-fresh
    okular
    pavucontrol
    qbittorrent
    scrot
    signal-desktop
    vlc
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        github.copilot
        rust-analyzer
        vscodevim.vim
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "flowistry";
          publisher = "wcrichton";
          version = "0.5.34";
          sha256 = "sha256-6jYjum+AkLxbtsDmZipshFZSk/IuE4nnDMDOrRq6JMU=";
          # homeless shelter prevents me from putting this in a hook, maybe
          # so i ran it myself *before* switching and running vscode
          #  rustup toolchain install nightly-2022-11-07 --profile minimal -c rust-src -c rustc-dev -c llvm-tools-preview
          #  cargo +nightly-2022-11-07 install flowistry_ide --version 0.5.34 --force
        }
      ];
    })
    zoom-us
    zotero
    # likely to run from terminal
    antigen
    delta
    dtrx
    fzf
    gdb
    git
    imagemagick
    kakoune
    mullvad-vpn
    ncdu
    parted
    pmount
    silver-searcher
    tree
    unzip
    valgrind-light
    vim
    wget
    # everything is a programming language,
    # but these are *really* programming languges
    clang
    nodejs
    ocaml
    ocamlPackages.ocamlbuild
    racket
    rustup
    texlive.combined.scheme-small
    zsh
    # drivers and such?
    bluez
    # x11 config and support
    awesome
    # xdotool support got broken in 4.3. but, this upgrade is more complicated
    # than that
    #(awesome.overrideAttrs (oldAttrs: {
    #  version = "2022-12-18";
    #  src = fetchFromGitHub {
    #    owner = "awesomewm";
    #    repo = "awesome";
    #    rev = "ee0663459922a41f57fa2cc936da80d5857eedc9";
    #    sha256 = "sha256-K9qOOdzo/KEcEb6DJ1Q1W6sqarbDAQ3cm7Oa6pbikHI=";
    #  };
    #  # merged!
    #  patches = [];
    #}))
    brightnessctl
    libsForQt5.kdeconnect-kde
    libinput-gestures
    nitrogen
    nm-tray
    picom
    xcape
    xclip
    xdotool
    xorg.xmodmap
    # non-x11 config and support
    mold
    python3
    rust-analyzer
    wineWowPackages.stable
    # digital audio
    ardour
    chuck
    drumgizmo
    hydrogen
    puredata
    qsynth
    soundfont-fluid
  ];

  security.wrappers = {
    pmount = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.pmount}/bin/pmount";
    };
    pumount = {
      setuid = true;
      owner = "root";
      group = "root";
      source = "${pkgs.pmount}/bin/pumount";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.passwordAuthentication = false;
  services.mullvad-vpn.enable = true;
  services.tlp.enable = true;

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  #services.picom.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

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

