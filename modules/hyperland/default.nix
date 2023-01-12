{ lib, stdenv, pkgs, config, flake-self, ... }:
with lib;

let
  cfg = config.elysa.services.hyprland;
in {
  options.elysa.services.hyprland = {
    enable = mkEnableOption "Hyprland wayland compositor service";
  };

  config = mkIf cfg.enable {
    # Hyprland itself
    programs.hyprland = {
      enable = true;
      nvidiaPatches = true;
    };

    # Session manager
    services = {
      xserver = {
        enable = true;
        displayManager.gdm = {
          enable = true;
        };
      };
    };

    fonts.fonts = with pkgs; [
      jetbrains-mono
    ];

    # Various usefull GUI services
    services.dbus.enable = true;
    security.rtkit.enable = true;
    programs.dconf.enable = true;

    # Enable home (linked to UI)
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.elysa = import ../../home/elysa.nix;
    };

    # Sound server
    sound.enable = true;
    services.pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    # Module for virtual webcam used for streaming (OBS, discord ...)
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.kernelModules = [ "v4l2loopback" ];

    environment.sessionVariables = {
      CLUTTER_BACKEND = "wayland";
      GBM_BACKEND = "nvidia-drm";
      GLFW_IM_MODULE = "ibus";
      LIBSEAT_BACKEND = "logind";
      LIBVA_DRIVER_NAME = "nvidia";
      NIXPKGS_ALLOW_UNFREE = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_RENDERER = "vulkan";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NIXOS_OZONE_WL = "1";
    };
  };
}
