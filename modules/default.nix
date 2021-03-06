{ pkgs, lib, system, ... }: {
  imports = [
    ./cachix.nix
    ./user.nix
  ];

  nix = {
    # Use flakes for **maximum hermeticism**.
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
      # Uses more disk space but speeds up nix-direnv.
      keep-derivations = true
      keep-outputs = true
    '';
  };

  # Allow proprietary packages.
  nixpkgs.config.allowUnfree = true;
  # System-wide packages.
  environment.systemPackages = with pkgs; [ ];

  # Setup `home-manager`.
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.matthew.imports = [ ../home ];
  };

  # Integrate with shells.
  programs = {
    fish.enable = true;
  };
}
