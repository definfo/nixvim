{ mylib, ... }:
{
  plugins.mini = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
