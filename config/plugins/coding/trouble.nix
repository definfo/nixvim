{ mylib, ... }:
{
  plugins.trouble = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
