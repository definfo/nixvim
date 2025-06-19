{ mylib, ... }:
{
  plugins.flash = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
