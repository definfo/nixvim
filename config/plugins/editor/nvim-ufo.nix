{
  # NOTE: should not be lazyloaded
  plugins.nvim-ufo = {
    enable = true;
    settings = {
      # FIXME: https://github.com/kevinhwang91/nvim-ufo/issues/33
      provider_selector = ''
        function(bufnr, filetype, buftype)
            return {'treesitter', 'indent'}
        end
      '';
    };
  };
}
