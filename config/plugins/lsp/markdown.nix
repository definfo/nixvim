{ mylib, ... }:
{
  lsp.servers = {
    markdown_oxide.enable = true;
  };
  plugins.markview = {
    enable = true;
    lazyLoad = mylib.noVsc;
  };
}
