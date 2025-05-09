{ config, pkgs, userSettings, ... }:

{

  imports = [
    ./user/sh.nix
    ./user/firefox.nix
    ./user/hyprland.nix
    ./user/school.nix
    ./user/nvim.nix
    ./user/git.nix
  ];


  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  home.stateVersion = "24.11"; 

  home.sessionVariables = {
    EDITOR = userSettings.editor;
    SPAWNEDITOR = userSettings.spawnEditor;
    TERM = userSettings.term;
    BROWSER = userSettings.browser;
  };

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = "${config.home.homeDirectory}/Media/Videos";
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = "${config.home.homeDirectory}/Templates";
    download = "${config.home.homeDirectory}/Downloads";
    documents = "${config.home.homeDirectory}/Documents";
    desktop = null;
    publicShare = null;
  };
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;
  xdg.configFile."mimeapps.list".force = true;

  news.display = "silent";
  programs.home-manager.enable = true;
}
