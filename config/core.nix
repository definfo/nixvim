{
  pkgs,
  lib,
  ...
}:
{
  config = {
    # Core plugins
    plugins = {
      lz-n.enable = true;
    };

    # Color scheme
    colorscheme = "catppuccin";
    colorschemes.catppuccin = {
      enable = true;
      lazyLoad.enable = true;
      settings.flavour = "auto";
    };

    # Deps
    dependencies = {
      # coreutils.enable = true;
      # cornelis.enable = true; # agda-mode
      direnv.enable = true;
      fzf.enable = true;
      git = {
        enable = true;
        package = pkgs.gitMinimal;
      };
      ripgrep.enable = true;
    };

    # NOTE: corenelis (agda-mode for neovim) should depend on global binaries
    # let g:cornelis_use_global_binary = 1 / vim.g.cornelis_use_global_binary = 1
    # globals.cornelis_use_global_binary = 1;

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
      # Fold settings, see nvim-ufo for details.
      foldenable = true;
      foldcolumn = "1";
      foldlevel = 99;
      foldlevelstart = 99;
      fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:";
      # Session settings
      sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions";
    };

    # Clipboard.
    clipboard = lib.mkIf pkgs.stdenv.isLinux {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    # Filetypes.
    # filetype.extension = {
    #   "slang" = "slang";
    # };

    # NOTE: Experimental
    performance.combinePlugins.enable = true;
  };
}
