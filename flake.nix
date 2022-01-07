{
  description = "System configuration";

  inputs = {
    # Nix package manager.
    nix.url = "github:nixos/nix/latest-release";
    # nixOS support.
    nixos.url = "github:nixos/nixpkgs/nixos-unstable";
    # Manages user home directories declaratively.
    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixos";
    };
    # Nix user repository.
    nur = {
      url = github:nix-community/NUR;
      inputs.nixpkgs.follows = "nixos";
    };
    # Nix cache configurator.
    cachix.url = "github:jonascarpay/declarative-cachix";
  };

  outputs = { self, nix, nixos, home, nur, cachix, ... }:
    let
      # Package overlays.
      overlays = { nixpkgs.overlays = [ nix.overlay nur.overlay ]; };
      # Shared modules.
      sharedModules = [ ./modules overlays cachix.nixosModules.declarative-cachix ];
      # nixOS specific modules.
      nixosModules = [
        ./modules/nixos
        home.nixosModules.home-manager
      ];

      # Creates a nixOS system configuration.
      nixosConfig = { system, modules }:
        nixos.lib.nixosSystem {
          inherit system;
          modules = modules ++ nixosModules ++ sharedModules;
        };
    in
    {
      # nixOS hosts.
      nixosConfigurations = {
        # Lenovo P50 (4K PANTONE, 2016).
        P50-personal = nixosConfig {
          system = "x86_64-linux";
          modules = [ ./hosts/P50 ./profiles/personal ];
        };
        P50-work = nixosConfig {
          system = "x86_64-linux";
          modules = [ ./hosts/P50 ./profiles/work ];
        };
      };
    };
}
