{ pkgs, lib, ... }:
with lib;

let
  importer = folder: (map
    (file: rec {
      name = "${folder}/" + (if (hasSuffix ".nix" file) then 
                              (removeSuffix ".nix" file) else
                              file);

      value =
        if (hasSuffix ".nix" file) then {
          # If source is nix file, import with passing lib
          text = import (./configs + "/${folder}/${file}") {
            lib = lib;
            pkgs = pkgs;
          };
        } else {
          # If source is flat file
          source = ./configs + "/${folder}/${file}";
        };
    })
    (builtins.attrNames (builtins.readDir (./configs + "/${folder}"))));
in {
  # Custom configurations (more standard dotfiles)
  xdg.configFile = builtins.listToAttrs (flatten (map
    importer
    (builtins.attrNames (builtins.readDir ./configs))
  ));
}
