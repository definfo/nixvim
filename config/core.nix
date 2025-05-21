{
  config = {
    # Color scheme.
    colorscheme = "catppuccin";
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "auto";
    };

    # Options.
    opts = {
      # Indent settings.
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      # Line number.
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      # Search case sensitivity.
      ic = true;
      # Treesitter folding.
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldcolumn = "auto:9";
      foldlevel = 99;
      foldlevelstart = 99;
      fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:";
    };

    # Clipboard.
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    # Filetypes.
    filetype.extension = {
      "slang" = "slang";
    };

  };
}
