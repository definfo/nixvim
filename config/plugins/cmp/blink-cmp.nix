{ pkgs, helpers, ... }:
let
  blink-cmp-latex = pkgs.vimUtils.buildVimPlugin {
    name = "blink-cmp-latex";
    src = pkgs.fetchFromGitHub {
      owner = "erooke";
      repo = "blink-cmp-latex";
      rev = "325fe0b3e652c87be880894cd1c14d886f1fec8e";
      hash = "sha256-mkgE+545rQL6dUdBOxSuDva7eGUQL8PU5Z7mKc7FMTQ=";
    };
  };
in
{
  plugins = {
    blink-cmp = {
      enable = true;
      settings.completion = {
        accept = {
          auto_brackets.enabled = true;
        };
        documentation = {
          auto_show = true;
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
          (helpers.mkRaw ''
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
          "snippets"
          "buffer"
          "ripgrep"
          "latex"
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
              prefix_min_len = 3;
              context_size = 5;
              max_filesize = "1M";
              project_root_marker = ".git";
              project_root_fallback = true;
              search_casing = "--ignore-case";
              additional_rg_options = { };
              fallback_to_regex_highlighting = true;
              ignore_paths = { };
              additional_paths = { };
              debug = false;
            };
          };
          latex = {
            name = "Latex";
            module = "blink-cmp-latex";
            opts = {
              insert_command = helpers.mkRaw ''
                function(ctx)
                    local ft = vim.api.nvim_get_option_value("filetype", {
                        scope = "local",
                        buf = ctx.bufnr,
                    })
                    if ft == "tex" then
                        return true
                    end
                    return false
                end
              '';
            };
          };
        };
      };
    };
    blink-compat.enable = true;
    blink-ripgrep.enable = true;
  };

  extraPlugins = [
    blink-cmp-latex
  ];
}
