{ pkgs, lib, inputs, ... }:

{

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
    blueman
  ];

  hardware.bluetooth.settings = {
    General = {
      ControllerMode = "bredr";
    };
  };

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

}
