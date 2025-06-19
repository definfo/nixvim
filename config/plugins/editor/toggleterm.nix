{ mylib, ... }:
{
  plugins.toggleterm = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
