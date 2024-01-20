-- plugin: nvim-tree

local config =  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {'nvim-tree/nvim-web-devicons'},
    keys = {
        {'<leader>t', ':NvimTreeToggle<cr>', desc = 'nvim-tree-toggle'},
    },
    config = function ()
        require('nvim-tree').setup({})
    end
}


return config
