{ mylib, ... }:
{
  plugins.lspconfig = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
  # Prefer local LSP
  lsp.servers."*".settings.packageFallback = true;
  lsp.servers = {
    asm_lsp.enable = true;
    ast_grep.enable = true;
    bashls.enable = true;
    lua_ls.enable = true;
    neocmake.enable = true;
    yamlls.enable = true;
  };
}
