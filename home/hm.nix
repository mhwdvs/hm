{ pkgs, config, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./git.nix
    ./fish.nix
    #./doom-emacs.nix
    ./diversus.nix
    ./docker.nix
    #./gpg.nix
  ];

  nixpkgs.config.allowUnfree = true;

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

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

}
