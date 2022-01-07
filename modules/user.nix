{ pkgs, lib, ... }: {
  # Define users.
  users.users.matthew = lib.mkMerge [
    {
      shell = pkgs.fish;
    }
    (lib.mkIf pkgs.stdenv.isLinux {
      isNormalUser = true;
      home = "/home/matthew";
      description = "Matthew Davis";
      extraGroups = [ "wheel" "networkmanager" "docker" ];
    })
  ];
}
