local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Quitar resaltado de búsqueda" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>write<CR>", { desc = "Guardar archivo" })

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Explorador de archivos" })

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Buscar archivos" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Buscar texto" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buscar buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Buscar ayuda" })

map("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", { desc = "Markdown: alternar render" })
map("n", "<leader>cv", "<cmd>CsvViewToggle<CR>", { desc = "CSV: alternar vista" })
map("n", "<leader>cc", "<cmd>ColorizerToggle<CR>", { desc = "Colores: alternar vista" })

map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnóstico siguiente" })

map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnóstico anterior" })

map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "LSP: diagnóstico actual" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "LSP: lista de diagnósticos" })
