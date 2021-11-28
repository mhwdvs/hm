{ ... }: {
    imports = [
        ./starship.nix
    ];

    programs.fish = {
        enable = true;
        interactiveShellInit = "set fish_greeting; neofetch;";
    };
}
