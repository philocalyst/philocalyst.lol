{
  description = "NuNuShell development environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      git-hooks,
      devshell,
    }:
    let
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];

      eachSystem =
        f:
        nixpkgs.lib.genAttrs systems (
          system:
          f {
            inherit system;
            pkgs = nixpkgs.legacyPackages.${system};
          }
        );
    in
    {
      checks = eachSystem (
        {
          pkgs,
          system,
          ...
        }:
        {
          pre-commit-check = git-hooks.lib.${system}.run {
            src = ./.;
            package = pkgs.prek;
            default_stages = [ "pre-push" ];
            hooks = {
              convco = {
                enable = true;
                pass_filenames = false;
                entry = toString (
                  pkgs.writeShellScript "convco-pre-push" ''
                    while read local_ref local_sha remote_ref remote_sha; do
                      ${pkgs.convco}/bin/convco check "$remote_sha..$local_sha"
                    done
                  ''
                );
                stages = [ "pre-push" ];
              };

              nixfmt.enable = true;

              markdownfmt = {
                enable = true;
                name = "hongdown";
                entry = "hongdown --write";
                files = "\\.md$";
                language = "system";
              };

              clj-kondo = {
                enable = true;
                name = "clj-kondo";
                entry = "clj-kondo --lint";
                files = "\\.(clj|cljs|cljc|edn)$";
                language = "system";
                stages = [
                  "pre-merge-commit"
                  "pre-push"
                ];
              };
            };
          };
        }
      );

      devShells = eachSystem (
        {
          pkgs,
          system,
        }:
        let
          hooks = self.checks.${system}.pre-commit-check;
        in
        {
          default = (devshell.legacyPackages.${system}.mkShell) {
            name = "NuNuShell";
            env = [
              {
                name = "MAIN_PACKAGE";
                value = "nudox";
              }
              {
                name = "OUTPUT_DIRECTORY";
                value = "dist";
              }
              {
                name = "LD_LIBRARY_PATH";
                value = "${pkgs.openssl.out}/lib:$LD_LIBRARY_PATH";
              }
              {
                name = "OPENSSL_DIR";
                value = "${pkgs.openssl.dev}";
              }
              {
                name = "OPENSSL_LIB_DIR";
                value = "${pkgs.openssl.out}/lib";
              }
              {
                name = "OPENSSL_INCLUDE_DIR";
                value = "${pkgs.openssl.dev}/include";
              }
            ];

            motd = ''
              $($(type -p kittysay) --think "the nu is the now" | dotacat)
            '';

            packages = builtins.filter (x: x != null) [
              pkgs.git
              pkgs.nixfmt
              pkgs.tombi
              pkgs.typos
              pkgs.hongdown
              pkgs.radicle-node
              pkgs.radicle-tui
              pkgs.kittysay
              pkgs.marksman
              pkgs.taplo
              pkgs.nil
              pkgs.jsonfmt
              pkgs.dotacat
              pkgs.goreleaser
              pkgs.cuelsp
              pkgs.b3sum
              # Clojure
              pkgs.clojure
              pkgs.clj-kondo
              pkgs.clojure-lsp
              # TypeScript (via GTS - Go TypeScript compiler)
              pkgs.typescript-go
              # LightningCSS
              pkgs.lightningcss
              (if pkgs.stdenv.isLinux then pkgs.openssl else null)
            ];

            commands = [ ];

            devshell.startup.shellHook.text = ''
              ${hooks.shellHook}
              nu
            '';
          };
        }
      );

      packages = eachSystem (
        { system, ... }:
        {
          default = self.devShells.${system}.default;
        }
      );

      formatter = eachSystem ({ pkgs, ... }: pkgs.nixfmt-rfc-style);
    };
}
