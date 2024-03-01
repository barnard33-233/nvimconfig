-- plugins about lsp cmp and snippet

local lsp_bindings = {
    {'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>'},
    {'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>'},
    {'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>'},
    {'n', 'gr', '<cmd>lua vim.lsp.buf.reference()<cr>'},
    {'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>'},
    {'n', 'go', '<cmd>lua vim.lsp.buf.open_float()<cr>'},
    {'n', 'gp', '<cmd>lua vim.lsp.buf.goto_prev()<cr>'},
    {'n', 'gn', '<cmd>lua vim.lsp.buf.goto_next()<cr>'},
}

local keymapping = require('keymapping')

-- setup of language servers
local lspconfig = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    lazy = false,
    config = function()
        local mason = require('mason')
        local masonlspconfig = require('mason-lspconfig')
        mason.setup()
        masonlspconfig.setup({
            ensure_installed = {
                "lua_ls", "clangd", "pyright",
                -- "rust_analyzer", "tsserver",
                "svlangserver",
            },
        })
        local lspconfig = require('lspconfig')
        lspconfig.clangd.setup({
            cmd = {"clangd", "--background-index", "--all-scopes-completion", "--completion-style=detailed"}
        })
        lspconfig.lua_ls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.rust_analyzer.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.svlangserver.setup({})
        keymapping.bindkeys(lsp_bindings)
    end
}

-- completion
local cmp = {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'onsails/lspkind-nvim',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            sources = cmp.config.sources({
                {name = 'nvim_lsp'},
                {name = 'buffer'},
                {name = 'path'},
                {name = 'vsnipt'},
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    with_text = true,
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    before = function (entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        return vim_item
                    end
                })
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-k>'] = cmp.mapping.select_prev_item(),
                ['<C-j>'] = cmp.mapping.select_next_item(),
                ['<tab>'] = cmp.mapping.confirm({
                    select = true,
                    behavior = cmp.ConfirmBehavior.Replace
                }),
            }),
        })
    end
}


return {lspconfig, cmp}
