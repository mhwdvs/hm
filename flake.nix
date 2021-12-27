{
  description = "System configuration";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.05";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let # local variables
      system = "x86_64-linux";
    in {
      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;
  };
}
