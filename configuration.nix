{ config, pkgs, systemSettings, userSettings, ... }:

{
  imports =
    [
      ./system/hardware-configuration.nix
      ./system/hyprland.nix
      ./system/gaming.nix
      ./system/bluetooth.nix
      ./system/stylix.nix
      ./system/tailscale.nix
      ./system/framework.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
  boot.loader.efi.efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
  boot.loader.grub.enable = if (systemSettings.bootMode == "uefi") then false else true;
  boot.loader.grub.device = systemSettings.grubDevice; # does nothing if running uefi rather than bios

  # Plymouth 
  boot = {
    plymouth = {
      enable = true;
      theme = "pie";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "pie" ];
        })
      ];
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    loader.timeout = 0;

  };

  # Enable networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  # Locale Settings
  time.timeZone = systemSettings.timezone; # time zone
  i18n.defaultLocale = systemSettings.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = systemSettings.locale;
    LC_IDENTIFICATION = systemSettings.locale;
    LC_MEASUREMENT = systemSettings.locale;
    LC_MONETARY = systemSettings.locale;
    LC_NAME = systemSettings.locale;
    LC_NUMERIC = systemSettings.locale;
    LC_PAPER = systemSettings.locale;
    LC_TELEPHONE = systemSettings.locale;
    LC_TIME = systemSettings.locale;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    uid = 1000;
  };

  # Starship Setup
  programs.starship = {
    enable = true;
    presets = [ "nerd-font-symbols" ];
  };

  # Configure keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable Priting
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    cups-filters
    curl
    git
    vim
    wget
    killall
    discord
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
    noto-fonts-cjk-sans
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "@wheel" ];
      download-buffer-size = 500000000; # 500MB
    };
  };

  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    flake = "/home/max/dotfiles";
    flags = [
      "--update-input" "nixpkgs"
    ];
    allowReboot = true;
  };

  system.stateVersion = "24.11";

}
