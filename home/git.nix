{ pkgs, ... }: {
    home-manager.users.matthew.programs.git = {
        enable = true;
        userName = "mhwdvs";
        userEmail = "matt@mhwdvs.com";
        extraConfig = {
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
        };
    };
}