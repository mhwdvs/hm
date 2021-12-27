{ pkgs, ... }: {
    home-manager.users.matthew = {
          home.packages = [ 
              pkgs.docker 
              pkgs.docker-compose ];
    };
    virtualisation.docker.enable = true;
}
