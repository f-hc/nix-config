{
  description = "Global system tools";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.default = pkgs.buildEnv {
          name = "global-system-tools";

          paths = with pkgs; [
            aria2
            direnv
            grex
            harper
            hyperfine
            jq
            lychee
            rumdl
            starship
            yq-go
            zoxide

            # AI
            codex
            opencode
            skills

            # Cryptography & secrets
            b3sum
            pqc-scanner
            pqcscan
            pwgen
            sops

            # Jujutsu VCS + other VCS tools
            git
            hanko
            jujutsu
            lazyjj

            # Just
            just
            just-lsp

            # Nix
            nix-direnv
            nix-output-monitor
            nix-tree
            nix-your-shell
            nixd
            nixfmt

            # Replace std tools
            bat # cat
            bottom # top/htop
            delta # diff
            duf # df
            dust # du
            fd # find
            lsd # ls
            ripgrep-all # grep
            sd # sed
            xcp # cp
            xh # curl/wget
          ];
        };
      }
    );
}
