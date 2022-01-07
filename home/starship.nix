{ ... }: {
  # Enable the `starship` prompt.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
