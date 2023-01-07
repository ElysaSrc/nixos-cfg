{ lib, stdenv, pkgs, config, flake-self, ... }:
with lib;

let
  cfg = config.elysa.base;
in {
  options.elysa.base = {
    enable = mkEnableOption "Base items (boot, user, timezone, remote access)";
  };

  config = mkIf cfg.enable {
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Default programs installed
    environment.systemPackages = with pkgs; [
      git
    ];

    # Locales
    i18n = {
      defaultLocale = "en_US.UTF-8";
      extraLocaleSettings = {
        LANG = "en_US.UTF-8";
        LANGUAGE = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
        LC_COLLATE="en_US.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_MESSAGES = "en_US.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
      };
    };

    # Pinning the state version for all machines
    system.stateVersion = "22.11";

    # Allow unfree packages everywhere
    nixpkgs.config.allowUnfree = true;

    # France TimeZone
    time.timeZone = "Europe/Paris";
  
    # Tailscale and remote access
    services.tailscale.enable = true;
    networking.firewall.checkReversePath = "loose";
    services.openssh.enable = true;

    # UEFI related settings
    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = false;
      };
    };

    # Fish shell with starship prompt
    programs.fish = {
      enable = true;
      shellInit = ''
        set fish_greeting
        ${import ./fish_theme.nix { lib = pkgs.lib; }}
        ${pkgs.starship}/bin/starship init fish | source
      '';
      shellAliases = {
        "nxs" = "sudo nixos-rebuild switch";
        "nxb" = "sudo nixos-rebuild boot";
        "ngc" = "sudo nix-collect-garbage -d";
      };
    };

    # Base common user configuration
    users = {
      users = {
        root = {
          shell = pkgs.fish;
        };
        elysa = {
          name = "elysa";
          description = "Élysa";
          home = "/home/elysa";
          createHome = true;
          isSystemUser = false;
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          shell = pkgs.fish;
        };
      };
    };
  };
}
