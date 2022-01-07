{ pkgs, lib, ... }: {
  # Define users.
  users.users.matthew = lib.mkMerge [
    {
      shell = pkgs.fish;
    }
    (lib.mkIf pkgs.stdenv.isLinux {
      home = "/home/matthew";
      isNormalUser = true;
      extraGroups = [ "wheel" "dialout" "networkmanager" "docker" ];
    })
  ];
}
