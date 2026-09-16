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
            bat
            direnv
            duf
            dust
            fd
            lsd
            ripgrep-all
            sd
            starship

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
