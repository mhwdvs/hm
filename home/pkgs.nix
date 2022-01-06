{ pkgs, lib, system, ... }:
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
  home-manager.users.matthew.home.packages = packages;
}