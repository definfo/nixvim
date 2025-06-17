{ pkgs, ... }:
{
  # extraConfigLua = builtins.readFile ./rime-ls.lua;
  extraConfigLua = ''
    -- Embed utils module directly
    local utils = {}

    local map = vim.keymap

    function utils.get_visible_bufs()
        local visible_bufs = {}
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if utils.is_visible_buffer(buf) then visible_bufs[#visible_bufs + 1] = buf end
        end
        return visible_bufs
    end

    function utils.get_lsp_capabilities(override)
        override = override or {}
        local default = {
            textDocument = {
                completion = {
                    completionItem = {
                        snippetSupport = false,
                    },
                },
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
        }
        default = vim.tbl_deep_extend('force', default, override)
        return require('blink.cmp').get_lsp_capabilities(default)
    end

    function utils.rime_ls_disabled(context)
        if not vim.g.rime_enabled then return true end
        local line = context.line
        local cursor_column = context.cursor[2]
        for _, pattern in ipairs(vim.g.disable_rime_ls_pattern or {}) do
            local start_pos = 1
            while true do
                local match_start, match_end = string.find(line, pattern, start_pos)
                if not match_start then break end
                if cursor_column >= match_start and cursor_column < match_end then return true end
                start_pos = match_end + 1
            end
        end
        return false
    end

    function utils.feedkeys(keys, mode)
        local termcodes = vim.api.nvim_replace_termcodes(keys, true, true, true)
        vim.api.nvim_feedkeys(termcodes, mode, false)
    end

    function utils.is_visible_buffer(buf)
        buf = buf or 0
        return vim.api.nvim_buf_is_valid(buf)
            and vim.api.nvim_get_option_value('buflisted', { buf = buf })
    end

    function utils.map_set(mode, lhs, rhs, opts)
        opts = vim.tbl_extend('force', { silent = true, remap = false }, opts or {})
        map.set(mode, lhs, rhs, opts)
    end

    function utils.map_del(mode, lhs, opts) 
        map.del(mode, lhs, opts) 
    end

    -- Make utils available as a module
    package.loaded['utils'] = utils

    vim.g.rime_enabled = false

    local function toggle_rime(client)
        client.request('workspace/executeCommand',
                       {command = 'rime-ls.toggle-rime'},
                       function(_, result, ctx, _)
            if ctx.client_id == client.id then 
                vim.g.rime_enabled = result 
                -- Optional: Add visual feedback
                vim.notify(result and "Rime enabled" or "Rime disabled", vim.log.levels.INFO)
            end
        end)
    end

    local function rime_on_attach(client, _)
        local mapped_punc = {
            [','] = '，',
            ['.'] = '。',
            [':'] = '：',
            ['?'] = '？',
            ['\\'] = '、'
        }
        local feedkeys = require('utils').feedkeys
        local map_set = require('utils').map_set
        local map_del = require('utils').map_del
        local utils = require('utils')
        
        -- Extract toggle logic into reusable function
        local function perform_toggle()
            -- We must check the status before the toggle
            if vim.g.rime_enabled then
                vim.g.rime_enabled = false
                for k, _ in pairs(mapped_punc) do
                    pcall(map_del, {'i'}, k .. '<space>')
                end
            else
                vim.g.rime_enabled = true
                for k, v in pairs(mapped_punc) do
                    map_set({'i'}, k .. '<space>', function()
                        if utils.rime_ls_disabled({
                            line = vim.api.nvim_get_current_line(),
                            cursor = vim.api.nvim_win_get_cursor(0)
                        }) then
                            feedkeys(k .. '<space>', 'n')
                        else
                            feedkeys(v, 'n')
                        end
                    end)
                end
            end
            toggle_rime(client)
        end
        
        -- Toggle rime with keybind
        -- This will toggle Chinese punctuations too
        map_set({'n', 'i'}, '<leader>tr', perform_toggle)
        
        -- Add command line interface
        vim.api.nvim_create_user_command('RimeToggle', perform_toggle, {
            desc = 'Toggle Rime input method'
        })
    end

    -- Start the rime-ls language server
    vim.lsp.start({
        name = 'rime_ls',
        cmd = { '${pkgs.rime-ls}/bin/rime_ls' },
        capabilities = require('utils').get_lsp_capabilities(),
        init_options = {
            enabled = vim.g.rime_enabled,
            shared_data_dir = '${pkgs.rime-ice}/share/rime-data',
            user_data_dir = vim.fn.expand('~/.local/share/rime-ls'),
            log_dir = vim.fn.expand('~/.local/share/rime-ls'),
            always_incomplete = true,
            long_filter_text = true,
        },
        on_attach = rime_on_attach,
        handlers = {
            ['$/progress'] = function(_, _, _) end,
        },
    })
  '';

  extraPackages = [
    pkgs.rime-ls
    pkgs.rime-ice
  ];
}
