{ mylib, ... }:
{
  imports = mylib.scanPaths ./.;

  plugins.web-devicons.enable = true;
}
