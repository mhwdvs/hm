{ ... }: {
  imports = [
    ./fish.nix
    ./font.nix
    ./git.nix
    ./pkg.nix
    ./starship.nix
    ./vscode
    ./gtk.nix
  ];

  programs.home-manager.enable = true;
}
