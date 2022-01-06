{ ... }: {
  imports = [
    ./git.nix
    ./fish.nix
    #./doom-emacs.nix
    ./diversus.nix
    ./docker.nix
  ];

   home-manager.users.matthew = {
    home.packages = 
      [ pkgs.starship
        pkgs.vim
        #pkgs.jetbrains.rider
        pkgs.vscodium
        pkgs.ripgrep-all
        pkgs.neofetch
        pkgs.firefox
        pkgs.syncthing
        #pkgs.libreoffice
        pkgs.okular
        pkgs.gnome.gnome-tweaks
        #pkgs.mono
      ];
  };

  # use fish shell
  # i probably only need one of these O_o
  users.users.matthew.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  home.stateVersion = "21.05";
  programs.home-manager.enable = true;
}