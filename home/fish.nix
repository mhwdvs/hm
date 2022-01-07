{ ... }: {
  # Install fish, the user friendly shell.
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting;   # Disable welcome message
      starship init fish | source;
      neofetch;
    '';
  };
}
