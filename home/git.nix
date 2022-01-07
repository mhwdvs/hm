{ lib, ... }: {
  # Install `git`, the stupid content tracker.
  programs.git = {
    enable = true;
    userName = "Matthew Davis";
    userEmail = "matt@mhwdvs.com";
    ignores = [ "" ];
    extraConfig = {
      core = {
        # Always use Unix line endings.
        eol = "lf";
        # Don't automatically convert line endings.
        autocrlf = false;
      };
      # Use `main` as the default branch name.
      init.defaultBranch = "main";
      # Use the same branch names on the local and remote end.
      push.default = "current";
      # Automatically stash unstaged changes then reapply after an action completes.
      rebase.autoStash = true;
      # Remember git authentication credentials
      credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
        }/bin/git-credential-libsecret";
    };
  };
}
