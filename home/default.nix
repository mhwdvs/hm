{ pkgs, ... }: 
let 
  packages = with pkgs; [
    # Tools
    ## Terminal rice
    starship
    neofetch

    ## Text editors
    vim
    vscodium

    ## Utilities
    firefox
    ripgrep-all
    syncthing
    okular
    
    ## Gnome
    gnome.gnome-tweaks
  ];
in
{
  imports = [
    ./git.nix
    ./fish.nix
    #./doom-emacs.nix
    ./diversus.nix
    ./docker.nix
  ];

  home.packages = packages;

  # use fish shell
  # i probably only need one of these O_o
  users.users.matthew.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  home.stateVersion = "21.05";
  programs.home-manager.enable = true;
}