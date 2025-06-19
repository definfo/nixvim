{ mylib, ... }:
{
  lsp.servers.markdown_oxide = {
    enable = true;
  };
  # `:MarkdownPreview`
  plugins.markdown-preview = {
    enable = true;
  };
  plugins.render-markdown = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
}
