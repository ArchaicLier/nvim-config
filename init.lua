--Менеджер пакетов i
lazypath = "/data/data/com.termux/files/home/.config/nvim/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", -- latest stable release
                lazypath,
                })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
        "neovim/nvim-lspconfig",
        -- lazy.nvim
'tamton-aquib/staline.nvim',
        "rafamadriz/neon",
        "nvim-tree/nvim-web-devicons",
        "nvim-tree/nvim-tree.lua",
        "aveplen/ruscmd.nvim",
        "petertriho/nvim-scrollbar",
        "ms-jpq/coq_nvim",
        "tamton-aquib/duck.nvim",
        {"akinsho/bufferline.nvim", version = '*', dependencies = "nvim-tree/nvim-web-devicons"},
        "seandewar/nvimesweeper",
        "ThePrimeagen/vim-be-good",
        {'akinsho/toggleterm.nvim', version = "*", config = true}
})
--Отображение номера текущей строки
vim.opt.number = true
vim.opt.relativenumber = true
-- Terminal

require("toggleterm").setup{}

--Цветовая схема
--vim.g.neon_style = "light"
vim.cmd.colorscheme('neon')
--Файловый менеджер
require("nvim-tree").setup()
nvimtreeapi = require("nvim-tree.api")
--Русская раскладка
require('ruscmd').setup{}
--Индикатор прокрутки
require("scrollbar").setup()
--LSP сервис
require'lspconfig'.pyright.setup(coq.lsp_ensure_capabilities({
        cmd = { "pyright-langserver",
                "--stdio",
                "--pythonversion 3.11",
                "--ignoreexternal"
        },
}))
require'lspconfig'.clangd.setup(coq.lsp_ensure_capabilities({}))
vim.opt.termguicolors = true

--Измененная страка буффера
require("bufferline").setup{}

--Строка состояния редактора
require("staline").setup {
        sections = {
                left = {
                        '▊', ' ', { 'Evil', ' ' }, ' ',         -- The mode and evil sign
                        'file_size', ' ',                        -- Filesize
                        { 'StalineFile', 'file_name' }, ' '       -- Filename in different highlight
                },
                mid = { ' ', 'lsp_name' },                      -- "lsp_name" is still a little buggy
                right = {
                        { 'StalineEnc', vim.bo.fileencoding:upper() }, '  ',  -- Example for custom section
                        { 'StalineEnc', 'cool_symbol' }, ' ',                 -- the cool_symbol for your OS
                        { 'StalineGit', 'branch' }, ' ', '▊'                  -- Branch Name in different highlight
                }
        },
        defaults = {
                bg = "#202328",
                branch_symbol = " "
        },
        mode_colors = {
                n = "#38b1f0",
                i = "#9ece6a",       -- etc mode
        }
}
vim.cmd [[hi Evil        guifg=#f36365 guibg=#202328]]       -- Higlight for Evil symbol
vim.cmd [[hi StalineEnc  guifg=#7d9955 guibg=#202328]]       -- Encoding Highlight
vim.cmd [[hi StalineGit  guifg=#8583b3 guibg=#202328]]       -- Branch Name Highlight
vim.cmd [[hi StalineFile guifg=#c37cda guibg=#202328]]       -- File name Highlight

--Горячая клавиша открытия файлового менеджера
vim.keymap.set('n', '<M-t>', "<cmd>NvimTreeToggle<cr>")
vim.keymap.set('n', '<S-Tab>', "<cmd>NvimTreeToggle<cr>")
vim.keymap.set('n', '<C-t>' , "<cmd>ToggleTerm<cr>")

vim.keymap.set('n', '<M-q>' , "<cmd>bp<cr>")
vim.keymap.set('n', '<M-w>' , "<cmd>bn<cr>")


--Горячие клавиши для заполнения консоли котикми
vim.keymap.set('n', 'cf', function() require("duck").cook() end, {})
vim.keymap.set('n', 'cv', function() require("duck").hatch("󰡨", 2.50) end, {})

local coq = require "coq"
vim.cmd("COQnow -s") --Запускает сервис автодополнений
