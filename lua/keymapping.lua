local modole = {}

function modole.bindkeys(mappings)
    -- bind mappings in given table
    for _, m in pairs(mappings) do
        vim.keymap.set(m[1], m[2], m[3])
    end

end

-- leader
vim.g.mapleader = ' '

local basic_mappings = {
    ---- normal mode
    -- wrap or not
    {'n', '<leader>w', ':set wrap<CR>'},
    {'n', '<leader>nw', ':set nowrap<CR>'},

    {'n', '<leader>h', '<c-w>h'},
    {'n', '<leader>j', '<c-w>j'},
    {'n', '<leader>k', '<c-w>k'},
    {'n', '<leader>l', '<c-w>l'},
    -- split window
    {'n', '<leader>sh', '<c-w>s'},
    {'n', '<leader>sv', '<c-w>v'},
    -- disable highlight
    {'n', '<leader>nl', ':nohl<CR>'},

    ---- visual mode
    {'v', '<', '<gv'},
    {'v', '>', '>gv'},
}

modole.bindkeys(basic_mappings)

return modole
