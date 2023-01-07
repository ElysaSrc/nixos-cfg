{ pkgs, ... }: 

{
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
    wofi
  ];

  programs.git = {
    enable = true;
    userName  = "Élysæ";
    userEmail = "101974839+ElysaSrc@users.noreply.github.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
