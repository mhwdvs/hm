{ pkgs, lib, system, ... }:
let
  packages = with pkgs; [
    # Development tools
    ## Version control systems
    git
    ## Text editors
    vim
    ## Container orchestration
    docker-compose

    # Utilities
    htop # Interactive proccess viewer
    ripgrep-all # In-text search
    neofetch # System information
    syncthing # File sync
    libreoffice # Office productivity suite
    okular # PDF viewer
    ## Web-browsers
    firefox
  ];
  nixosPackages = with pkgs; [];
in
{
  home.packages = packages
    ++ lib.optionals pkgs.stdenv.isLinux nixosPackages;
}
