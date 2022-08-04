{
  description = "Home-manager configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "/nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    general = 
      let
        cfg = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [ 
            ./home
            {
              home = {
                username = "matthew";
		homeDirectory = "/home/matthew";
		stateVersion = "22.11";
              };
            }
          ];
        };
      in cfg.activationPackage;
    };
}
