{ pkgs, lib, inputs, ... }:

{

  programs.git = {
    enable = true;
    userName = "Maxyapper7";
    userEmail = "thisisreal@example.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

}
