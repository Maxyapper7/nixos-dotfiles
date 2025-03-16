{ config, pkgs, ... }:

{

  imports = [
    ./user/sh.nix
    ./user/firefox.nix
    ./user/hyprland.nix
    ./user/school.nix
    ./user/nvim.nix
    ./user/git.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.stateVersion = "24.11"; 

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;
}
