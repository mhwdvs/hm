{ pkgs, stdenv, ... }: {
    gnupg-createconfig = stdenv.mkDerivation {
        name = "gnupg-createconfig";
        phases = "installPhase";

        installPhase = ''
            echo "
	    enable-ssh-support
            disable-scdaemon
            default-cache-ttl 21600
            default-cache-ttl-ssh 21600
            max-cache-ttl 21600
            max-cache-ttl-ssh 21600" > /home/matthew/.gnupg/gpg-agent.conf
        '';
    };

    home-manager.users.matthew = {
        home.packages = [ 
            pkgs.gnupg
            pkgs.pinentry 
            pkgs.gnupg-createconfig
        ];
    };
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
        pinentryFlavor = "curses";
    };
}
