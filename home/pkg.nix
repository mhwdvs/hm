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
  ];
  nixosPackages = with pkgs; [];
in
{
  home.packages = packages
    ++ lib.optionals pkgs.stdenv.isLinux nixosPackages;
}
