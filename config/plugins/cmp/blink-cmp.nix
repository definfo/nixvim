_: {
  plugins = {
    blink-cmp = {
      enable = true;
      settings.appearance = {
        nerd_font_variant = "normal";
        use_nvim_cmp_as_default = true;
      };
      settings.completion = {
        accept = {
          auto_brackets = {
            enabled = true;
            semantic_token_resolution = {
              enabled = false;
            };
          };
        };
        documentation = {
          auto_show = true;
        };
      };
      settings.keymap = {
        preset = "super-tab";
      };
      settings.signature = {
        enabled = true;
      };
      settings.sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "dictionary"
          "ripgrep"
        ];
        providers = {
          buffer = {
            score_offset = -7;
          };
          lsp = {
            fallbacks = [ ];
          };
          dictionary = {
            module = "blink-cmp-dictionary";
            name = "Dict";
            score_offset = 5;
            min_keyword_length = 3;
            # Optional configurations
            opts = { };
          };
          ripgrep = {
            async = true;
            module = "blink-ripgrep";
            name = "Ripgrep";
            score_offset = 100;
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
        };
      };
    };
    blink-cmp-dictionary.enable = true;
    blink-ripgrep.enable = true;
  };
}
