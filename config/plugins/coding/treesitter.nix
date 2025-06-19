{ mylib, ... }:
{
  plugins.treesitter = {
    enable = true;
    lazyLoad = mylib.lazyUI;
    settings = {
      folding.enable = false;
      highlight.enable = true;
      indent.enable = true;
    };
  };
}
