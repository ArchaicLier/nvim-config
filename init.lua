--Менеджер пакетов i 
lazypath = "/data/data/com.termux/files/home/lazy/lazy.nvim"
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
	"rafamadriz/neon",
	"nvim-tree/nvim-web-devicons",
	"nvim-tree/nvim-tree.lua",
	"aveplen/ruscmd.nvim",
	"petertriho/nvim-scrollbar",
	"ms-jpq/coq_nvim",
	"tamton-aquib/duck.nvim",
	{"akinsho/bufferline.nvim", version = '*', dependencies = "nvim-tree/nvim-web-devicons"},
	"beauwilliams/statusline.lua",
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
--Русская раскладка
require('ruscmd').setup{}
--Индикатор прокрутки
require("scrollbar").setup()
--LSP сервис
require'lspconfig'.pyright.setup(coq.lsp_ensure_capabilities({
	cmd = { "pyright-langserver",
		"--stdio",
		"--pythonversion 3.10",
		"--ignoreexternal"
	},
}))
require'lspconfig'.clangd.setup(coq.lsp_ensure_capabilities({}))
vim.opt.termguicolors = true

--Измененная страка буффера
require("bufferline").setup{}

--Строка состояния редактора
local statusline = require('statusline')
statusline.tabline = false
statusline.termguicolors = true

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

