{ pkgs, inputs, ... }:

{

programs.firefox = {
    enable = true;

    policies = {
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = "never";
      DisplayMenuBar = "default-off";

      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      ExtensionSettings = {
        "*".installation_mode = "blocked";
        "extension@tabliss.io" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/tabliss/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
      };


    };

    profiles.max = {
      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
      };

      search.default = "ddg";
      search.force = true;

    };
  };
}
