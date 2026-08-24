-- Estas variables deben definirse antes de cargar cualquier plugin.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- nvim-tree sustituye al explorador netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("packloadall")

require("cesar.options")
require("cesar.appearance")
require("cesar.treesitter")
require("cesar.completion")
require("cesar.lsp")
require("cesar.navigation")
require("cesar.documents")

-- Si Noice produce mensajes extraños, comenta únicamente esta línea.
require("cesar.noice")

require("cesar.keymaps")
