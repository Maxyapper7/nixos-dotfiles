{

  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nvf.url = "github:notashelf/nvf";

  };

  outputs = { self, nixpkgs, home-manager, hyprland, nixos-hardware, stylix, nvf, ... }@inputs:
    let

      # ---- SYSTEM SETTINGS ---- #
      systemSettings = {
        hostname = "Oakland";
        device = "framework";
        timezone = "America/Denver";
        locale = "en_US.UTF-8";
        bootMode = "uefi"; 
        bootMountPath = "/boot";
        system = "x86_64-linux";
      };

      # ----- USER SETTINGS ----- #
      userSettings = {
        username = "max";
        name = "Max";
        dotfilesDir = "~/dotfiles";
        term = "kitty";
        editor = "nvim";
        spawnEditor = "nvim";
        browser = "firefox";
        cursorTheme = "capitaine-cursors";
        cursorSize = 24;
      };

      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${systemSettings.system};
      supportedSystems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];
      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor =
        forAllSystems (system: import inputs.nixpkgs { inherit system; });
    in {
      nixosConfigurations = {
        system = lib.nixosSystem {
          system = systemSettings.system;
          specialArgs = { inherit inputs; inherit systemSettings; inherit userSettings; inherit nixos-hardware; };
          modules = [
            ./configuration.nix
            stylix.nixosModules.stylix
          ];
        };
      };

      homeConfigurations = {
        user = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; inherit userSettings; };
          modules = [
            ./home.nix 
            inputs.nvf.homeManagerModules.default
          ];
        };
      };

      packages = forAllSystems (system:
        let pkgs = nixpkgsFor.${system};
        in {
          default = self.packages.${system}.install;

          install = pkgs.writeShellApplication {
            name = "install";
            runtimeInputs = with pkgs; [ git vim ];
            text = ''${./install.sh} "$@"'';
          };
        });

      apps = forAllSystems (system: {
        default = self.apps.${system}.install;

        install = {
          type = "app";
          program = "${self.packages.${system}.install}/bin/install";
        };
      });

    };
}
