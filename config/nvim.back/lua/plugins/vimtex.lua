return {
  {
    "lervag/vimtex",
    lazy = false, -- Crucial: Do not lazy load VimTeX
    init = function()
      -- Use Zathura as the PDF viewer (or "sioyek", "mupdf", etc.)
      vim.g.vimtex_view_method = "zathura"

      -- Change compilation engine if needed (default uses latexmk)
      -- vim.g.vimtex_compiler_method = 'latexmk'
    end,
  },
}

