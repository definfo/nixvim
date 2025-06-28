{
  config = {
    # Core plugins
    plugins = {
      lz-n.enable = true;
      auto-session.enable = true;
    };

    extraConfigLua = ''
      require("auto-session").setup {
          log_level = "error",
          auto_session_suppress_dirs = { "~/", "~/projects", "~/Downloads", "/" },
          pre_save_cmds = {"tabdo Neotree close"},
          post_restore_cmds = {"Neotree"}
      }
    '';

    # Color scheme
    colorscheme = "catppuccin";
    colorschemes.catppuccin = {
      enable = true;
      lazyLoad.enable = true;
      settings.flavour = "auto";
    };

    # Deps
    dependencies = {
      coreutils.enable = true;
      # cornelis.enable = true; # agda-mode
      direnv.enable = true;
      fzf.enable = true;
      git.enable = true;
      ripgrep.enable = true;
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
    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    # Filetypes.
    filetype.extension = {
      "slang" = "slang";
    };

    # NOTE: Experimental
    performance.combinePlugins.enable = true;
  };
}
