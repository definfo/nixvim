{ mylib, ... }:
{
  plugins.lspconfig = {
    enable = true;
    lazyLoad = mylib.lazyUI;
  };
  # Prefer local LSP
  lsp.servers."*".config.packageFallback = true;
  lsp.servers."*".config.enabled = mylib.noVsc;
  lsp.servers = {
    asm_lsp.enable = true;
    ast_grep.enable = true;
    bashls.enable = true;
    lua_ls.enable = true;
    neocmake.enable = true;
    yamlls.enable = true;
  };
}
