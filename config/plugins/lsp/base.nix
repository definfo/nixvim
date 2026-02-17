{ lib, mylib, ... }:
{
  plugins.lspconfig = {
    enable = true;
    lazyLoad = mylib.noVsc;
  };
  # Prefer local LSP
  lsp.servers."*".config.packageFallback = true;
  lsp.servers."*".config.enabled = lib.nixvim.mkRaw ''
    function()
      return not vim.g.vscode
    end
  '';
  lsp.servers = {
    asm_lsp.enable = true;
    ast_grep.enable = true;
    bashls.enable = true;
    lua_ls.enable = true;
    neocmake.enable = true;
    yamlls.enable = true;
  };
}
