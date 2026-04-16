{ lib, ... }:
{
  lsp.servers = {
    markdown_oxide.enable = true;
  };
  plugins.markdown-preview = {
    enable = true;
    settings.enabled = lib.nixvim.mkRaw ''
      function()
        return vim.bo.filetype == "markdown"
          and not vim.g.vscode
      end
    '';
  };
}
