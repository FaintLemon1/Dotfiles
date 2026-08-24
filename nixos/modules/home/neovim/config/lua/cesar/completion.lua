local cmp = require("cmp")
local luasnip = require("luasnip")

luasnip.config.setup({
  history = true,
  updateevents = "TextChanged,TextChangedI",
})

-- Carga Friendly Snippets y después nuestros snippets personales de LaTeX.
require("luasnip.loaders.from_vscode").lazy_load()
require("cesar.snippets")

require("nvim-autopairs").setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})

cmp.setup({
  preselect = cmp.PreselectMode.None,

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  -- Los mapeos se declaran individualmente para no depender de presets que
  -- nvim-cmp puede modificar entre versiones.
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ["<C-d>"] = cmp.mapping.scroll_docs(4),
    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },
    { name = "luasnip", priority = 750 },
    { name = "path", priority = 500 },
  }, {
    { name = "buffer", priority = 250, keyword_length = 3 },
  }),

  experimental = {
    ghost_text = false,
  },
})

-- En LaTeX, cmp-vimtex agrega comandos, referencias, etiquetas y citas.
local tex_sources = cmp.config.sources({
  { name = "vimtex", priority = 1200 },
  { name = "nvim_lsp", priority = 1000 },
  { name = "luasnip", priority = 750 },
  { name = "path", priority = 500 },
}, {
  { name = "buffer", priority = 250, keyword_length = 3 },
})

cmp.setup.filetype("tex", { sources = tex_sources })
cmp.setup.filetype("plaintex", { sources = tex_sources })

-- Después de aceptar una función desde cmp, autopairs puede insertar ().
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
