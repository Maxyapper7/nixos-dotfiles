{ pkgs, lib, inputs, ... }:

{

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/mnt/Toronto" = {
    device = "//toronto/Max";
    fsType = "cifs";
    options = [ "username=max" "password=T#Ld*9PtS8^Mr3X4tZaU" ];
  };

}
