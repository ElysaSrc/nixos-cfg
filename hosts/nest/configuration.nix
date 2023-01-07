{ config, pkgs, flake-self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  networking.hostName = "nest";

  console = {
    keyMap = "fr";
  };

  programs.steam.enable = true;
  services = {
    xserver.layout = "fr";
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };

  elysa = {
    base.enable = true;

    services = {
      hyprland = {
        enable = true;
      };

      noisegate = {
        enable = true;
        vadThreshold = "90.0";
        vadGracePeriod = "300";
        retroactiveVad ="5";
      };
    };
  };
}
