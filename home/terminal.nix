{ pkgs, lib, ... }: 

let
  c = import ../lib/colors.nix { lib = lib; };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
      };
      colors = {
        primary = {
          background = "0x${c.nohex c.background.hard}";
          foreground = "0x${c.nohex c.white}";
        };
        normal = {
          black =   "0x${c.nohex c.white}";
          red =     "0x${c.nohex c.red}";
          green =   "0x${c.nohex c.green}";
          yellow =  "0x${c.nohex c.yellow}";
          blue =    "0x${c.nohex c.blue}";
          magenta = "0x${c.nohex c.purple}";
          cyan =    "0x${c.nohex c.aqua}";
          white =   "0x${c.nohex c.white}";
        };
        bright = {
          black =   "0x${c.nohex c.bright.white}";
          red =     "0x${c.nohex c.bright.red}";
          green =   "0x${c.nohex c.bright.green}";
          yellow =  "0x${c.nohex c.bright.yellow}";
          blue =    "0x${c.nohex c.bright.blue}";
          magenta = "0x${c.nohex c.bright.purple}";
          cyan =    "0x${c.nohex c.bright.aqua}";
          white =   "0x${c.nohex c.bright.white}";
        };
      };
    };
  };
}
