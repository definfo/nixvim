{ mylib, ... }:
{
  plugins.oil = {
    enable = true;
    lazyLoad = mylib.lazyUI;
    settings = {
      columns = [
        "icon"
      ];
      keymaps = {
        "<C-c>" = false;
        "<C-l>" = false;
        "<C-r>" = "actions.refresh";
        "<leader>qq" = "actions.close";
        "y." = "actions.copy_entry_path";
      };
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = false;
      };
      win_options = {
        concealcursor = "ncv";
        conceallevel = 3;
        cursorcolumn = false;
        foldcolumn = "0";
        list = false;
        signcolumn = "no";
        spell = false;
        wrap = false;
      };
    };
  };
}
