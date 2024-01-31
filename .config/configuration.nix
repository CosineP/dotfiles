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

  boot.kernel.sysctl = {
    "vm.dirty_background_ratio" = 10;
    "vm.dirty_ratio" = 20;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  systemd.sleep.extraConfig = ''
    HandleLidSwitch=suspend-then-hibernate
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
    provider = "geoclue2";
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
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
  };
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # Improve I/O performance on my SSD?  i checked lsblk --discard to ensure
  # DISC-GRAN and DISC-MAX were non-zero.  This is important to avoid data loss.
  services.fstrim.enable = true;

  services.blueman.enable = true;

  # Following 1 to 2 lines may not be necessary.  Added them hoping to fix a
  # problem with redshift that was ultimately fixed with a system restart
  services.avahi.enable = true;
  services.geoclue2.enable = true;

  services.redshift = {
    enable = true;
    temperature.night = 2200;
  };

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

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;

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

  nixpkgs.config = {
    allowUnfree = true;
    # i don't like this, but i'm waiting for fix i guess
    permittedInsecurePackages = [ "zotero-6.0.26" ];
  };
  nixpkgs.overlays = [
    (self: super: {
      # https://kisonecat.com/blog/eduroam-openssl-wpa-supplicant/
      # Fixed patch to use tabs and correct filenames
      wpa_supplicant = super.wpa_supplicant.overrideAttrs (attrs: {
        patches = attrs.patches ++ [ ./eduroam.patch ];
      });
      # xdotool support and more got broken in 4.3. Staying on 4.2 at least
      # until 4.4 comes out
      awesome = (super.awesome.overrideAttrs (oldAttrs: {
        version = "2022-12-18";
        src = super.fetchFromGitHub {
          owner = "awesomewm";
          repo = "awesome";
          rev = "ee0663459922a41f57fa2cc936da80d5857eedc9";
          sha256 = "sha256-K9qOOdzo/KEcEb6DJ1Q1W6sqarbDAQ3cm7Oa6pbikHI=";
        };
        patches = []; # merged!
        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
        '';
        buildInputs = oldAttrs.buildInputs;
      }));
    })
  ];
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # chat / communication
    (discord.override {
        nss = pkgs.nss_latest;
    })
    signal-desktop
    wire-desktop
    zoom-us
    # video (games)
    #itch
    qbittorrent
    syncplay
    vlc
    # likely to run from dmenu / .desktop
    dmenu
    firefox
    gthumb
    kitty
    krita
    libreoffice-fresh
    lyx
    okular
    pavucontrol
    scrot
    (import ./vscode.nix { inherit pkgs; })
    zotero
    # likely to run from terminal
    delta
    difftastic
    dtrx
    fzf
    gdb
    git
    kakoune
    killall
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
    elmPackages.elm
    ghc
    nodejs
    ocaml
    ocamlPackages.ocamlbuild
    python3
    racket
    typescript
    rustup
    rust-analyzer
    (texlive.combine { inherit (texlive) scheme-small bbding; })
    zsh
    # drivers and such?
    bluez
    # x11 config and support
    antigen
    autokey
    brightnessctl
    libinput-gestures
    nitrogen
    nm-tray
    picom
    xcape
    xclip
    xdotool
    xorg.xmodmap
    # non-x11 config and support
    hunspell # support lyx
    hunspellDicts.en_US # hunspell dict
    mold
    #monaspace
    # digital audio
    ardour
    (import ./drmr.nix {})
    drumgizmo
    hydrogen
    # jack2 # nothing but trouble
    # qjackctl
    puredata
    qsynth
    soundfont-fluid
    x42-avldrums
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
  services.openssh.settings.PasswordAuthentication = false;
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
  # https://discourse.nixos.org/t/connected-to-mullvadvpn-but-no-internet-connection/35803/8
  services.resolved.enable = true;

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
