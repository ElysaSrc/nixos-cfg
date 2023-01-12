{ config, pkgs, flake-self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
    ./vm.nix
  ];

  networking.hostName = "nest";

  console = {
    keyMap = "fr";
  };

  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    steam-run
  ];

  elysa = {
    base = {
      enable = true;
      extraGroups = [ "libvirtd" ];
    };

    services = {
      hyprland = {
        enable = true;
      };

      noisegate = {
        enable = true;
        vadThreshold = "95.0";
        vadGracePeriod = "300";
        retroactiveVad ="5";
      };
    };
  };
}
