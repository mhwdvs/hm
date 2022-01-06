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

  home-manager.users.matthew = { pkgs, ... }: {
    # use fish shell
    # i probably only need one of these O_o
    #environment.shells = [ pkgs.fish ];
    shell = pkgs.fish;

    programs.home-manager.enable = true;
    home.stateVersion = "21.05";
  };
}