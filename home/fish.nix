{ ... }: {
    imports = [
        ./starship.nix
    ];

    programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting; 
          starship init fish | source;
          neofetch;
        '';
    };
}
