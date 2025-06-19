{
  # NOTE: should not be lazyloaded
  plugins.nvim-ufo = {
    enable = true;
    settings = {
      # FIXME: https://github.com/kevinhwang91/nvim-ufo/issues/33
      provider_selector = ''
        function(bufnr, filetype, buftype)
            local ftMap = {
                vim = "indent",
                python = { "indent" },
                git = "",
            }
            return ftMap[filetype] or {'treesitter', 'indent'}
        end
      '';
    };
  };

  extraConfigLua = ''
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "nvcheatsheet", "neo-tree" },
        callback = function()
            require("ufo").detach()
            vim.opt_local.foldenable = false
        end
    })
  '';
}
