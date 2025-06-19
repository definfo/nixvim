{ mylib, ... }:
{
  plugins.nvim-autopairs = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
