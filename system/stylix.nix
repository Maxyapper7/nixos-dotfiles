{ pkgs, userSettings, ... }: 

{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    autoEnable = true;
    cursor = {
      package = pkgs.capitaine-cursors;
      name = userSettings.cursorTheme; 
      size = userSettings.cursorSize;
    };

  };

}
