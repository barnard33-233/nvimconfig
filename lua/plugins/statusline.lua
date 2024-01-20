-- status line
local config = {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    name = 'lualine',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    opts = {
        theme = 'iceberg_light',
    }
}

return config
