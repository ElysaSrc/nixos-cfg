{ pkgs, ... }: 

{
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    firefox
    signal-desktop
    vscode
    discord
    cider
    obs-studio
    obs-studio-plugins.wlrobs
    prismlauncher
    inkscape
    lutris
    tor-browser-bundle-bin
    qbittorrent
    vlc
    chromium
  ];

  home.stateVersion = "22.11";
}
