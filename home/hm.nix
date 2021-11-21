{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  nixpkgs.config.allowUnfree = true;

  home-manager.users.matthew = {
    /* Here goes your home-manager config, eg home.packages = [ pkgs.foo ]; */
    home.packages = 
      [ pkgs.vim
	      pkgs.vscodium
	      pkgs.git
	      pkgs.fish
        pkgs.ripgrep-all
	      pkgs.neofetch
	      pkgs.starship
	      pkgs.firefox
	      pkgs.syncthing
	      pkgs.libreoffice
        pkgs.okular
	      pkgs.gnome.gnome-tweaks ];

    programs.git = {
      enable = true;
      userName = "mhwdvs";
      userEmail = "matt@mhwdvs.com";
      extraConfig = {
      credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
    };
  };

  # use fish shell
  users.users.matthew.shell = pkgs.fish;
}

