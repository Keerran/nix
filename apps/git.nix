{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    libsecret
    git-credential-manager
    delta
    pre-commit
    jujutsu
    lazyjj
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
      };

      core = {
        pager = "delta";
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        navigate = true;
      };

      merge = {
        conflictStyle = "zdiff3";
      };

      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        credentialStore = "secretservice"; # or "gpg" / "plaintext" / "cache", see below
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        diffRenderers = [
          {
            colorArg = "always";
            command = "delta --dark --paging=never";
          }
        ];
      };
    };
  };
}
