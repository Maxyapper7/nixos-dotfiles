{ pkgs, lib, inputs, ... }:

{

  environment.systemPackages = [ pkgs.cifs-utils ];
  fileSystems."/home/max/Toronto" = {
    device = "//toronto/Max";
    fsType = "cifs";
    options = [ "username=max" "password=T#Ld*9PtS8^Mr3X4tZaU" ];
  };

}
