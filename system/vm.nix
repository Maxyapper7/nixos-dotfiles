{ pkgs, lib, inputs, userSettings, ... }:

{

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["${userSettings.username}"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

}
