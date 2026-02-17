{ lib, nixvimLib }:
rec {
  scanPaths =
    _path:
    map (f: (_path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          _path': _type:
          (_type == "directory") # include directories
          || (
            (_path' != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" _path') # include .nix files
          )
        ) (builtins.readDir _path)
      )
    );

  lazyUI = {
    enable = true;
    settings.event = "DeferredUIEnter";
  };

  noVsc = lazyUI // {
    settings.enabled = nixvimLib.nixvim.mkRaw ''
      function()
        return not vim.g.vscode
      end
    '';
  };
}
