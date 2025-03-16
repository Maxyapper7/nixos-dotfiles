{ config, pkgs, ... }:

{
  imports =
    [
      ./system/hardware-configuration.nix
      ./system/hyprland.nix
      ./system/random.nix
      ./system/gaming.nix
      ./system/bluetooth.nix
      ./system/stylix.nix
      ./system/tailscale.nix
      ./system/smb.nix
    ];

  networking.hostName = "nixos"; # Define your hostname.


  # Enable networking
  networking.networkmanager.enable = true;

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
  users.users.max = {
    isNormalUser = true;
    description = "Max Allred";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.meslo-lg
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
#      download-buffer-size = 500000000; # 500MB
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
