{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "codeforces-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "yunusey";
        repo = "codeforces-nvim";
        rev = "7a2fafba46dbea6b6d1098f33eb577a189132665";
        hash = "sha256-H7P1QDQP7ln7CgojMifdiVloCrhc/8YOAjI1e4nG4X8=";
      };
    })
  ];
  extraConfigLua = builtins.readFile ./codeforces.lua;
  extraPackages = [
    (pkgs.callPackage ./pkgs/codeforces-extractor.nix { })
  ];
}
