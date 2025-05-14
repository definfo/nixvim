{ pkgs, ... }:

{
  # TRigger all fold/unfold with `zR`/`zM`
  # Trigger fold/unfold with `zr`/`zm`
  extraPlugins = with pkgs.vimPlugins; [
    nvim-ufo
  ];
  extraConfigLua = ''
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
    })
  '';
}
