{ helpers, ... }:
{
  # <leader> := SPACE
  globals.mapleader = " ";
  keymaps =
    # NOTE:
    # blink-cmp is defined elsewhere
    #
    # nvim-ufo :
    # Trigger all fold/unfold with `zR`/`zM`
    # Trigger fold/unfold with `zr`/`zm`
    #
    # Wrapped line
    [
      {
        mode = [
          "n"
          "v"
        ];
        key = "j";
        action = "v:count == 0 ? 'gj' : 'j'";
        options = {
          expr = true;
          remap = false;
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "k";
        action = "v:count == 0 ? 'gk' : 'k'";
        options = {
          expr = true;
          remap = false;
        };
      }
    ]
    # Window
    ++ [
      # Window movement
      {
        mode = [ "n" ];
        key = "<c-h>";
        action = "<c-w>h";
        options = {
          remap = true;
        };
      }
      {
        mode = [ "n" ];
        key = "<c-j>";
        action = "<c-w>j";
        options = {
          remap = true;
        };
      }
      {
        mode = [ "n" ];
        key = "<c-k>";
        action = "<c-w>k";
        options = {
          remap = true;
        };
      }
      {
        mode = [ "n" ];
        key = "<c-l>";
        action = "<c-w>l";
        options = {
          remap = true;
        };
      }
      # Window resize
      {
        mode = [ "n" ];
        key = "<c-up>";
        action = "<cmd>resize +2<cr>";
      }
      {
        mode = [ "n" ];
        key = "<c-down>";
        action = "<cmd>resize +2<cr>";
      }
      {
        mode = [ "n" ];
        key = "<c-left>";
        action = "<cmd>vertical resize -2<cr>";
      }
      {
        mode = [ "n" ];
        key = "<c-right>";
        action = "<cmd>vertical resize +2<cr>";
      }
      # Window split
      {
        mode = [ "n" ];
        key = "<leader>-";
        action = "<C-W>s";
        options = {
          desc = "Split Window Horizontally";
          remap = true;
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>|";
        action = "<C-W>v";
        options = {
          desc = "Split Window Vertically";
          remap = true;
        };
      }
    ]
    # Tab
    ++ [
      {
        mode = [ "n" ];
        key = "<leader><tab><tab>";
        action = "<cmd>tabnew<cr>";
        options = {
          desc = "New Tab";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader><tab>l";
        action = "<cmd>tabnext<cr>";
        options = {
          desc = "Next Tab";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader><tab>h";
        action = "<cmd>tabprevious<cr>";
        options = {
          desc = "Previous Tab";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader><tab>d";
        action = "<cmd>tabclose<cr>";
        options = {
          desc = "Close Tab";
        };
      }
    ]
    # Buffer
    ++ [
      # Buffer movement
      {
        mode = [ "n" ];
        key = "<s-h>";
        action = "<cmd>bprevious<cr>";
        options = {
          desc = "Previous Buffer";
        };
      }
      {
        mode = [ "n" ];
        key = "<s-l>";
        action = "<cmd>bnext<cr>";
        options = {
          desc = "Next Buffer";
        };
      }
      # Bufferline
      {
        mode = [ "n" ];
        key = "<leader>bp";
        action = "<cmd>BufferLineTogglePin<cr>";
        options = {
          desc = "Pin Current Buffer";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>bP";
        action = "<cmd>BufferLineGroupClose ungrouped<cr>";
        options = {
          desc = "Delete Unpinned Buffers";
        };
      }
      # Mini.nvim
      # Remove current buffer(tab)
      {
        mode = [ "n" ];
        key = "<leader>bd";
        action = helpers.mkRaw ''
          function()
          	  local bd = require("mini.bufremove").delete
          	  if vim.bo.modified then
          		    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
          		    if choice == 1 then -- Yes
          			      vim.cmd.write()
          			      bd(0)
          		    elseif choice == 2 then -- No
          			      bd(0, true)
          		    end
          	  else
          		    bd(0)
          	  end
          end
        '';
        options = {
          desc = "Remove Buffers";
        };
      }
      # Misc
      {
        mode = [ "n" ];
        key = "<leader>qq";
        action = "<cmd>qa<cr>";
        options = {
          desc = "Quit All";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hh";
        action = "<cmd>nohlsearch<cr>";
        options = {
          desc = "Clear Search Highlight";
        };
      }
      # Telescope
      {
        mode = [ "n" ];
        key = "<leader>/";
        action = helpers.mkRaw ''
          function()
              require("telescope.builtin").live_grep()
          end
        '';
        options = {
          desc = "Live Grep";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader><space>";
        action = helpers.mkRaw ''
          function()
              require("telescope.builtin").find_files()
          end
        '';
        options = {
          desc = "Find Files";
        };
      }
      # Neo-tree
      {
        mode = [ "n" ];
        key = "<leader>e";
        action = helpers.mkRaw ''
          function()
            require("neo-tree.command").execute({ toggle = true })
          end
        '';
        options = {
          desc = "Toggle Neo-Tree";
        };
      }
      # Toggle Terminal
      {
        mode = [ "n" ];
        key = "<c-\\>";
        action = "<cmd>ToggleTerm<cr>";
        options = {
          desc = "Toggle Terminal";
        };
      }
      # LazyGit
      {
        mode = [ "n" ];
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options = {
          desc = "Toggle LazyGit";
        };
      }
      # Trouble
      {
        mode = [ "n" ];
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options = {
          desc = "Toggle Trouble";
        };
      }
    ]
    # Gitsigns
    # Git visual operations
    ++ [
      {
        mode = [ "n" ];
        key = "<leader>hs";
        action = helpers.mkRaw ''
          require("gitsigns").stage_hunk
        '';
        options = {
          desc = "Stage Hunk";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hr";
        action = helpers.mkRaw ''
          require("gitsigns").reset_hunk
        '';
        options = {
          desc = "Reset Hunk";
        };
      }
      {
        mode = [ "v" ];
        key = "<leader>hs";
        action = helpers.mkRaw ''
          function()
            require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end
        '';
        options = {
          desc = "Stage Hunk";
        };
      }
      {
        mode = [ "v" ];
        key = "<leader>hr";
        action = helpers.mkRaw ''
          function()
            require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end
        '';
        options = {
          desc = "Reset Hunk";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>bs";
        action = helpers.mkRaw ''
          require("gitsigns").stage_buffer
        '';
        options = {
          desc = "Stage Buffer";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hu";
        action = helpers.mkRaw ''
          require("gitsigns").undo_stage_hunk
        '';
        options = {
          desc = "Undo Stage Hunk";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>br";
        action = helpers.mkRaw ''
          require("gitsigns").reset_buffer
        '';
        options = {
          desc = "Reset Buffer";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hp";
        action = helpers.mkRaw ''
          require("gitsigns").preview_hunk
        '';
        options = {
          desc = "Preview Hunk";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hb";
        action = helpers.mkRaw ''
          function()
            require("gitsigns").blame_line({ full = true })
          end
        '';
        options = {
          desc = "Blame Line";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>tb";
        action = helpers.mkRaw ''
          require("gitsigns").toggle_current_line_blame
        '';
        options = {
          desc = "Toggle Current Line Blame";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hd";
        action = helpers.mkRaw ''
          require("gitsigns").diffthis
        '';
        options = {
          desc = "Diff Current Buffer";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>hD";
        action = helpers.mkRaw ''
          function()
            require("gitsigns").diffthis("~")
          end
        '';
        options = {
          desc = "Diff Root";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>td";
        action = helpers.mkRaw ''
          require("gitsigns").toggle_deleted
        '';
        options = {
          desc = "Toggle Deleted";
        };
      }
    ]
    # Flash.nvim
    # Enhanced navigation
    ++ [
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "s";
        action = helpers.mkRaw ''
          function()
            require("flash").jump()
          end
        '';
        options = {
          desc = "Flash";
        };
      }
      {
        mode = [
          "n"
          "x"
          "o"
        ];
        key = "S";
        action = helpers.mkRaw ''
          function()
              require("flash").treesitter()
          end
        '';
        options = {
          desc = "Flash Treesitter";
        };
      }
      {
        mode = [ "o" ];
        key = "r";
        action = helpers.mkRaw ''
          function()
              require("flash").remote()
          end
        '';
        options = {
          desc = "Remote Flash";
        };
      }
      {
        mode = [
          "x"
          "o"
        ];
        key = "R";
        action = helpers.mkRaw ''
          function()
              require("flash").treesitter_search()
          end
        '';
        options = {
          desc = "Treesitter Search";
        };
      }
      {
        mode = [ "c" ];
        key = "<c-s>";
        action = helpers.mkRaw ''
          function()
              require("flash").toggle()
          end
        '';
        options = {
          desc = "Toggle Flash Search";
        };
      }
    ]
    # Noice.nvim
    # Notification
    ++ [
      {
        mode = [ "n" ];
        key = "<leader>n";
        action = "<cmd>Noice dismiss<cr>";
        options = {
          desc = "Dismiss Noice";
        };
      }
    ];
}
