return {
  "hat0uma/csvview.nvim",
  ft = { "csv", "tsv" },
  cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  opts = {
    parser = { comments = { "#", "//" } },
    view = {
      display_mode = "border", -- o "highlight"
    },
  },
  keys = {
    { "<leader>cv", "<cmd>CsvViewToggle<cr>", desc = "Toggle CSV View" },
  },
}
