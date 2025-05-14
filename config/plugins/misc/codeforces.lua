opts = {
    use_term_toggle = true,

    cf_path = vim.fn.stdpath("data") .. "/codeforces",

    compiler = {
        cpp = { "g++", "@.cpp", "-o", "@" },
        py = {}
    },

    run = {
        cpp = { "@" },
        py = { "python3", "@.py" }
    },

    notify = function(title, message, type)
        local notify = require('notify')
        if message == nil then
            notify(title, type, {
                render = "minimal",
            })
        else
            notify(message, type, {
                title = title,
            })
        end
    end
}

require("codeforces-nvim").setup(opts)
