local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  "texlab",
  "marksman",
  "nil_ls",
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "pyright",
  "cssls",
  "html",
  "jsonls",
  "bashls",
  "yamlls",
}

-- nvim-lspconfig aporta las definiciones; Neovim 0.12 las configura y activa
-- mediante vim.lsp.config/vim.lsp.enable, no require("lspconfig").
for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    capabilities = capabilities,
  })
end

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = { enable = false },
    },
  },
})

vim.lsp.config("nil_ls", {
  capabilities = capabilities,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

vim.lsp.config("texlab", {
  capabilities = capabilities,
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
          "%f",
        },
        onSave = false,
        forwardSearchAfter = false,
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = false,
      },
      diagnosticsDelay = 300,
      completion = {
        matcher = "fuzzy-ignore-case",
      },
    },
  },
})

for _, server in ipairs(servers) do
  vim.lsp.enable(server)
end

vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  signs = true,
  virtual_text = {
    spacing = 2,
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
})

local lsp_group = vim.api.nvim_create_augroup("cesar_lsp", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    local function map(lhs, rhs, description)
      vim.keymap.set("n", lhs, rhs, {
        buffer = event.buf,
        silent = true,
        desc = "LSP: " .. description,
      })
    end

    map("gd", vim.lsp.buf.definition, "ir a definición")
    map("gD", vim.lsp.buf.declaration, "ir a declaración")
    map("gr", vim.lsp.buf.references, "buscar referencias")
    map("K", vim.lsp.buf.hover, "mostrar documentación")
    map("<leader>rn", vim.lsp.buf.rename, "renombrar símbolo")
    map("<leader>ca", vim.lsp.buf.code_action, "acción de código")
    map("<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, "formatear archivo")
  end,
})
