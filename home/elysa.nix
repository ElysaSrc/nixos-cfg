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

  # Custom configurations (more standard dotfiles)
  xdg.configFile = builtins.listToAttrs (map
    (x: {
      name = x;
      value = {
        recursive = true;
        source = ./configs + "/${x}";
      };
    })
    (builtins.attrNames (builtins.readDir ./configs))
  );

  home.stateVersion = "22.11";
}
