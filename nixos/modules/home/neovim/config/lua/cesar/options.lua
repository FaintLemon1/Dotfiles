local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

opt.wrap = false
opt.scrolloff = 5
opt.sidescrolloff = 5
opt.splitbelow = true
opt.splitright = true

opt.undofile = true
opt.swapfile = false
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }
opt.termguicolors = true

-- Usar el portapapeles de Wayland/sistema.
opt.clipboard = "unnamedplus"

-- La corrección ortográfica y el ajuste de línea ayudan en prosa, pero son
-- molestos al programar. Por eso se habilitan solamente en estos tipos.
local prose_group = vim.api.nvim_create_augroup("cesar_prose", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = prose_group,
  pattern = { "tex", "plaintex", "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "es", "en" }
  end,
})
