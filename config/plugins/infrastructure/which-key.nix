{ mylib, ... }:
{
  plugins.which-key = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
