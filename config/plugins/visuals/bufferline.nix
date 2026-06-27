{
  plugins.bufferline = {
    enable = true;
    settings.highlights.__raw = "require('catppuccin.special.bufferline').get_theme()";
    lazyLoad.settings.lazy = true; # Lazy load manually
  };
}
