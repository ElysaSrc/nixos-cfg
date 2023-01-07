{ lib, stdenv, pkgs, config, flake-self, ... }:
with lib;

let
  cfg = config.elysa.services.noisegate;
  config_file = let
    lib_path = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
  in ''
    context.modules = [{
      name = libpipewire-module-filter-chain
      args = {
        node.description =  "Noise Canceling source"
        media.name = "Noise Canceling source"
        filter.graph = {
          nodes = [
            {
              type = ladspa
              name = rnnoise
              plugin = ${lib_path}
              label = noise_suppressor_mono
              control = {
                "VAD Threshold (%)" = ${cfg.vadThreshold}
                "VAD Grace Period (ms)" = ${cfg.vadGracePeriod}
                "Retroactive VAD Grace (ms)" = ${cfg.retroactiveVad}
              }
            }
          ]
        }
        capture.props = {
          node.name =  "capture.rnnoise_source"
          node.passive = true
          audio.rate = 48000
        }
        playback.props = {
          node.name =  "rnnoise_source"
          media.class = Audio/Source
          audio.rate = 48000
        }
      }
    }]
  '';
in {
  options.elysa.services.noisegate = {
    enable = mkEnableOption "Enable noisegate";

    vadThreshold = mkOption {
      type = types.str;
      description = "VAD Threshold (%)";
      default = "50.0"; 
    };

    vadGracePeriod = mkOption {
      type = types.str;
      description = "VAD Grace Period (ms)";
      default = "200";
    };

    retroactiveVad = mkOption {
      type = types.str;
      description = "Retroactive VAD Grace (ms)";
      default = "0";
    };
  };

  config = mkIf cfg.enable {
    environment.etc."pipewire/pipewire.conf.d/99-input-denoising.conf".text = config_file;
  };
}
