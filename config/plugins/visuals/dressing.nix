{
  # TODO: snacks.nvim for `vim.ui.input`
  plugins.dressing = {
    enable = true;
    luaConfig.content = builtins.readFile ./dressing.lua;
  };
}
