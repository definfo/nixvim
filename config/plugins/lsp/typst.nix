{ mylib, ... }:
{
  lsp.servers.tinymist = {
    enable = true;
  };
  plugins.typst-preview = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
