{ mylib, ... }:
{
  lsp.servers = {
    markdown_oxide.enable = true;
  };
  plugins.render-markdown = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
  plugins.markview = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
