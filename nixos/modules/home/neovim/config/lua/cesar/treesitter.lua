-- nvim-treesitter cambió su API. En Neovim moderno el resaltado se inicia
-- mediante la API nativa; los parsers ya vienen compilados desde Nix.
local group = vim.api.nvim_create_augroup("cesar_treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(event)
    -- Algunos buffers especiales no tienen parser. pcall evita que eso
    -- interrumpa el arranque del editor.
    pcall(vim.treesitter.start, event.buf)
  end,
})
