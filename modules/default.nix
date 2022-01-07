{ pkgs, lib, system, ... }: {
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

  # Setup `home-manager`.
  home-manager = {
    users.matthew.imports = [ ../home ];
  };
}