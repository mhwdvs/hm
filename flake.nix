{
  description = "System configuration";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.matthew = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./machines/P50.nix ];
    };
  };
}
