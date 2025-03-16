{ pkgs, inputs, ... }:

{

  home.packages = with pkgs; [
    batsignal
    hypridle
    hyprpaper
    hyprshot
    hyprlock
    playerctl
    swayosd
    dunst
    nautilus
    loupe
    mpv
    sushi
  ];

  services.udiskie = {
    enable = true;
    automount = true;
    notify = true;
  };

  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
    settings = {
      font_family = "MesloLGS Nerd Font Mono";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      font_size = 14.0;
      background_opacity = 0.95;
    };
  };

  programs.rofi.enable = true;
  programs.waybar.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      cursor-theme = "capitaine-cursors";
    };
  };


  home.file = {
    ".config/hypr".source = ../dotfiles/hypr;
    ".config/wallpapers".source = ../dotfiles/wallpapers;
    ".config/dunst".source = ../dotfiles/dunst;
    ".config/waybar".source = ../dotfiles/waybar;
    ".config/rofi".source = ../dotfiles/rofi;
  };

}
