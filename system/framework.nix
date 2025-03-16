{ pkgs, lib, inputs, ... }:

{

  imports =
    [
      ./battery.nix
    ];

  services.fwupd.enable = true;

  ### Fingerprint BS ###

  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-vfs0090;
    };
  };


}
