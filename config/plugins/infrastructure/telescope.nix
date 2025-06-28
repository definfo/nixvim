{ mylib, ... }:
{
  plugins.telescope = {
    enable = true;
    # lazyLoad = {
    #   enable = true;
    #   settings.cmd = "Telescope";
    # };
    lazyLoad = mylib.lazyUI;
  };
}
