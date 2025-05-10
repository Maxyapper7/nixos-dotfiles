{ pkgs, lib, inputs, userSettings, ... }:

{
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    spice 
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    win-spice
    win-virtio
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  users.users.${userSettings.username}.extraGroups = [ "libvirtd" ];
  users.groups.libvirtd.members = ["${userSettings.username}"];

}
