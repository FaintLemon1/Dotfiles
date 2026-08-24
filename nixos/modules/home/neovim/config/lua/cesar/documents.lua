-- VimTeX ya se carga por tipo de archivo; no debe cargarse de forma diferida
-- mediante otro gestor de plugins.
vim.g.tex_flavor = "latex"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_view_forward_search_on_start = 0

require("render-markdown").setup({
  file_types = { "markdown" },
  render_modes = { "n", "c" },
  completions = {
    lsp = { enabled = true },
  },
  heading = {
    sign = false,
  },
  code = {
    sign = false,
    width = "block",
    right_pad = 1,
  },
})

require("csvview").setup({
  parser = {
    comments = { "#", "//" },
  },
  view = {
    display_mode = "border",
  },
})

-- Activa automáticamente la vista tabular al abrir CSV o TSV.
local csv_group = vim.api.nvim_create_augroup("cesar_csv", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = csv_group,
  pattern = { "csv", "tsv" },
  callback = function()
    vim.cmd("CsvViewEnable")
  end,
})

-- Vista de colores CSS moderna. En Neovim 0.12 el plugin evita que la vista
-- de colores incorporada al LSP duplique los resaltados.
require("colorizer").setup({
  filetypes = {
    css = { parsers = { css = true } },
    scss = { parsers = { css = true } },
    sass = { parsers = { css = true } },
    html = { parsers = { css = true } },
    javascript = { parsers = { css = true } },
    javascriptreact = { parsers = { css = true } },
    typescript = { parsers = { css = true } },
    typescriptreact = { parsers = { css = true } },
    tex = {
      parsers = {
        hex = { default = true },
        xcolor = { enable = true },
      },
    },
  },
  options = {
    display = {
      mode = "virtualtext",
      virtualtext = {
        char = "■",
        position = "after",
      },
      disable_document_color = true,
    },
  },
})

-- Atajos propios de LaTeX, disponibles únicamente dentro de un .tex.
local tex_group = vim.api.nvim_create_augroup("cesar_vimtex_keys", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = tex_group,
  pattern = { "tex", "plaintex" },
  callback = function(event)
    -- VimTeX conceal: muestra comandos matemáticos como símbolos Unicode.
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"

    local virtual_preview = false

    local function map(lhs, command, description)
      vim.keymap.set("n", lhs, command, {
        buffer = event.buf,
        silent = true,
        desc = "LaTeX: " .. description,
      })
    end

    map("<leader>tc", "<cmd>VimtexCompile<CR>", "compilar continuamente")
    map("<leader>tv", "<cmd>VimtexView<CR>", "abrir o sincronizar PDF")
    map("<leader>ts", "<cmd>VimtexStop<CR>", "detener compilación")
    map("<leader>te", "<cmd>VimtexErrors<CR>", "mostrar errores")
    map("<leader>ti", "<cmd>VimtexInfo<CR>", "mostrar información")

    map("<leader>tp", function()
      require("nabla").popup({
        border = "rounded",
      })
    end, "previsualizar fórmula")

    map("<leader>tr", function()
      virtual_preview = not virtual_preview

      if virtual_preview then
        require("nabla").enable_virt({
          autogen = true,
          silent = true,
        })
      else
        require("nabla").disable_virt()
      end
    end, "alternar renderizado matemático")
  end,
})
