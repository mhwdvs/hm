{ pkgs, ... }:
{
  imports = [
    ./git.nix
    ./fish.nix
    #./doom-emacs.nix
    ./diversus.nix
    ./docker.nix
    ./pkgs.nix
  ];

  # use fish shell
  # i probably only need one of these O_o
  users.users.matthew.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  home.stateVersion = "21.05";
  programs.home-manager.enable = true;
}