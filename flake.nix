{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixvim,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.treefmt-nix.flakeModule
        inputs.pre-commit-hooks.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        {
          pkgs,
          config,
          system,
          ...
        }:
        let
          extraSpecialArgs = {
            inherit system;
            mylib = import ./lib { inherit (pkgs) lib; };
          };

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            inherit pkgs extraSpecialArgs;
            module = import ./config; # import the module directly
          };
          nixvim-nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          # Lets you run `nix run .` to start nixvim
          packages.default = nixvim-nvim;

          # https://flake.parts/options/treefmt-nix.html
          # Example: https://github.com/nix-community/buildbot-nix/blob/main/nix/treefmt/flake-module.nix
          treefmt = {
            projectRootFile = "flake.nix";
            programs = {
              autocorrect.enable = true;
              deadnix.enable = true;
              formatjson5.enable = true;
              nixfmt.enable = true;
              statix.enable = true;
              stylua = {
                enable = true;
                settings = {
                  indent_type = "Spaces";
                  indent_width = 4;
                };
              };
              zizmor.enable = true;
            };
          };

          # https://flake.parts/options/git-hooks-nix.html
          # Example: https://github.com/cachix/git-hooks.nix/blob/master/template/flake.nix
          pre-commit.settings.hooks = {
            eclint.enable = true;
            editorconfig-checker.enable = true;
            markdownlint.enable = true;
            lua-ls.enable = true;
            treefmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.treefmt.build.devShell
              config.pre-commit.devShell
            ];
            shellHook = ''
              echo 1>&2 "Welcome to the development shell!"
            '';
          };
        };
    };
}
