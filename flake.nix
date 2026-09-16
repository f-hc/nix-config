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
            bat
            bottom
            direnv
            duf
            dust
            fd
            grex
            harper
            hyperfine
            lsd
            lychee
            pwgen
            ripgrep-all
            rumdl
            sd
            starship
            xcp
            xh

            # cryptography & secrets
            b3sum
            pqc-scanner
            pqcscan
            sops

            # Jujutsu VCS + other VCS tools
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
          ];
        };
      }
    );
}
