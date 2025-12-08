{ lib, ... }:
{
  plugins.blink-cmp = {
    enable = true;
    settings.enabled = lib.nixvim.mkRaw ''
      function()
        return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
          and not vim.g.vscode
      end
    '';
    settings.completion = {
      accept = {
        auto_brackets.enabled = false;
      };
      documentation = {
        auto_show = true;
        auto_show_delay_ms = 500;
      };
    };
    settings.signature = {
      enabled = true;
    };
    settings.keymap = {
      "<C-space>" = [
        "show"
        "show_documentation"
        "hide_documentation"
      ];
      "<C-e>" = [
        "cancel"
        "fallback"
      ];
      "<Tab>" = [
        (lib.nixvim.mkRaw ''
          function(cmp)
              if cmp.snippet_active() then
                  return cmp.accept()
              else
                  return cmp.select_and_accept()
              end
          end
        '')
        "snippet_forward"
        "fallback"
      ];
      "<S-Tab>" = [
        "snippet_backward"
        "fallback"
      ];
      "<Up>" = [
        "select_prev"
        "fallback"
      ];
      "<Down>" = [
        "select_next"
        "fallback"
      ];
      "<C-p>" = [
        "select_prev"
        "fallback_to_mappings"
      ];
      "<C-n>" = [
        "select_next"
        "fallback_to_mappings"
      ];
      "<C-b>" = [
        "scroll_documentation_up"
        "fallback"
      ];
      "<C-f>" = [
        "scroll_documentation_down"
        "fallback"
      ];
      "<C-k>" = [
        "show_signature"
        "hide_signature"
        "fallback"
      ];
    };
    settings.sources = {
      default = [
        "lsp"
        "path"
        "snippets" # "luasnip"
        "buffer"
        "ripgrep"
        "latex-symbols"
      ];
      providers = {
        buffer = {
          score_offset = -7;
        };
        lsp = {
          fallbacks = [ ];
        };
        ripgrep = {
          async = true;
          module = "blink-ripgrep";
          name = "Ripgrep";
          opts = {
            prefix_min_len = 4;
            project_root_marker = ".git";
            fallback_to_regex_highlighting = true;
            backend = {
              use = "gitgrep-or-ripgrep";
              customize_icon_highlight = true;
              ripgrep = {
                context_size = 5;
                max_filesize = "1M";
                project_root_fallback = true;
                search_casing = "--smart-case";
              };
            };
            additional_rg_options = { };
            ignore_paths = { };
            additional_paths = { };
            debug = false;
          };
        };
        latex-symbols = {
          module = "blink-cmp-latex";
          name = "Latex";
          opts = {
            # set to true to insert the latex command instead of the symbol
            insert_command = false;
          };
        };
      }; # providers
    }; # settings.sources
  };
  plugins.blink-compat.enable = true;
  plugins.blink-ripgrep.enable = true;
  plugins.blink-cmp-latex.enable = true;
}
