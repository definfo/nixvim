local nvim_lsp = require("lspconfig")
nvim_lsp.nixd.setup({
    cmd = { "nixd" },
    settings = {
        nixd = {
            nixpkgs = {
                expr = "import <nixpkgs> { }",
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
