{ pkgs, lib, inputs, nixos-hardware, ... }:

{
  imports = [
    "${nixos-hardware}/framework/13-inch/12th-gen-intel"
  ];

  ### Battery ###
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  services.tlp = {
    enable = true;
  };

  services.thermald.enable = true;

  ### BIOS Updates ###
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];
  services.fwupd.uefiCapsuleSettings.DisableCapsuleUpdateOnDisk = true;

  ### Fingerprint BS ###
  # services.fprintd = {
  #   enable = true;
  #   tod = {
  #     enable = true;
  #     driver = pkgs.libfprint-2-tod1-vfs0090;
  #   };
  # };


}
