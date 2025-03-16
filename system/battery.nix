{ pkgs, lib, inputs, ... }:

{

  hardware.opengl.extraPackages = with pkgs; [
    mesa_drivers
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
    intel-media-driver
  ];

  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = lib.mkDefault "ondemand";
  };

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_latest.override {
    argsOverride = rec {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v5.x/linux-${version}.tar.xz";
        sha256 = "1j0lnrsj5y2bsmmym8pjc5wk4wb11y336zr9gad1nmxcr0rwvz9j";
      };
      version = "5.15.1";
      modDirVersion = "5.15.1";
    };
  });

  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };

    boot.kernelParams = [ "mem_sleep_default=deep" ];

  };
}
