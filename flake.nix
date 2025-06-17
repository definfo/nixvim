{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-cmp-dict.url = "github:NixOS/nixpkgs?rev=e5d1c87f5813afde2dda384ac807c57a105721cc";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";
  };

  outputs =
    { nixvim, flake-parts, ... }@inputs:
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
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          pkgs-unfree = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          pkgs-cmp-dict = import inputs.nixpkgs-cmp-dict { inherit system; };
          nixvimModule = {
            inherit pkgs;
            module = import ./config; # import the module directly
            # You can use `extraSpecialArgs` to pass additional arguments to your module files
            extraSpecialArgs = {
              inherit
                system
                pkgs-unfree
                pkgs-cmp-dict
                ;
              mylib = import ./lib { inherit (pkgs) lib; };
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          # Lets you run `nix run .` to start nixvim
          packages.default = nvim;

          # https://flake.parts/options/treefmt-nix.html
          # Example: https://github.com/nix-community/buildbot-nix/blob/main/nix/treefmt/flake-module.nix
          treefmt = {
            projectRootFile = ".git/config";
            programs = {
              deadnix.enable = true;
              nixfmt.enable = true;
              statix.enable = true;
              stylua.enable = true;
              mdformat.enable = true;
            };
          };

          # https://flake.parts/options/git-hooks-nix.html
          # Example: https://github.com/cachix/git-hooks.nix/blob/master/template/flake.nix
          pre-commit.settings.hooks = {
            commitizen.enable = true;
            eclint.enable = true;
            editorconfig-checker.enable = true;
            markdownlint.enable = true;
            lua-ls.enable = true;
            treefmt.enable = true;
          };

          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.pre-commit.installationScript}
              echo 1>&2 "Welcome to the development shell!"
            '';
            packages = config.pre-commit.settings.enabledPackages;
          };
        };
    };
}
