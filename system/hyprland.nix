{ pkgs, lib, inputs, userSettings, ... }:

{

  imports = [
#    ./thunar.nix
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
  };

  environment.sessionVariables = {
    XCURSOR_THEME = userSettings.cursorTheme;
    XCURSOR_SIZE = "${toString userSettings.cursorSize}";
  };


  services.gvfs.enable = true;

  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "kitty";

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

}
