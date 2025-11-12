vim.lsp.config("nixd", {
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = 'import (builtins.getFlake ("git+file://" + builtins.toString ./.)).inputs.nixpkgs { }',
            },
            formatting = {
                command = { "nixfmt" },
            },
            options = {
                nixvim = {
                    expr = '(builtins.getFlake ("git+file://" + builtins.toString ./.)).inputs.nixvim.nixvimConfigurations.x86_64-linux.default.options',
                },
            },
        },
    },
})
