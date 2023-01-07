{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "22.11";

  imports = [
    ./dotfiles.nix
    ./terminal.nix
    ./programs.nix
  ];
}
