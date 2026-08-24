local notify = require("notify")

notify.setup({
  stages = "fade_in_slide_out",
  timeout = 2500,
  background_colour = "#000000",
})

vim.notify = notify

-- Configuración deliberadamente conservadora. No se reemplaza el renderizado
-- de documentación de LSP/cmp para reducir interacciones con render-markdown.
require("noice").setup({
  lsp = {
    progress = {
      enabled = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})
