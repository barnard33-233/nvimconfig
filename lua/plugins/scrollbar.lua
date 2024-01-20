-- scrollbar

local config = {
    'petertriho/nvim-scrollbar',
    dependencies = {
        "kevinhwang91/nvim-hlslens",
    },
    lazy = false,
    config = function ()
        require("scrollbar.handlers.search").setup({
            override_lens = function () end,
        })
        require("scrollbar").setup()
    end
}

return config
