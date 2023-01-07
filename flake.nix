{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs-wayland
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    # hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # vscode-server fix
    vscode-server.url = "github:msteen/nixos-vscode-server";
  };

  outputs = { self, ... }@inputs:
    with inputs;
  {
    # Output all modules in ./modules to flake. Modules should be in
    # individual subdirectories and contain a default.nix file
    nixosModules = builtins.listToAttrs (map
      (x: {
        name = x;
        value = import (./modules + "/${x}");
      })
      (builtins.attrNames (builtins.readDir ./modules))
    );

    # Each subdirectory in ./hosts is a host. Add them all to
    # nixosConfigurations. Host configurations need a file called
    # configuration.nix that will be read first
    nixosConfigurations = builtins.listToAttrs (map
      (x: {
        name = x;
        value = nixpkgs.lib.nixosSystem {
          specialArgs = { flake-self = self; };
          system = "x86_64-linux";
          modules = [
            {
              nix.settings = {
                trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
                substituters = [
                  "https://cache.nixos.org"
                  "https://nixpkgs-wayland.cachix.org"
                  "https://hyprland.cachix.org"
                ];
              };
            }

            (./hosts + "/${x}/configuration.nix")
            { imports = builtins.attrValues self.nixosModules; }
            home-manager.nixosModules.home-manager
            hyprland.nixosModules.default
            vscode-server.nixosModule
          ];
        };
      })
      (builtins.attrNames (builtins.readDir ./hosts))
    );
  };
}
