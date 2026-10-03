{
  description = "Global system tools";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      eachSystem =
        systems: f:
        builtins.foldl' (
          a: s: a // builtins.mapAttrs (k: v: (a.${k} or { }) // { ${s} = v; }) (f s)
        ) { } systems;
    in
    eachSystem systems (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
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
            attic-client
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
