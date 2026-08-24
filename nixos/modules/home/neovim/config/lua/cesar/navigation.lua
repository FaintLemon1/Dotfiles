local telescope = require("telescope")
local telescope_actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "smart" },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
    mappings = {
      i = {
        ["<Esc>"] = telescope_actions.close,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
  },
})

require("nvim-tree").setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 34,
    side = "left",
  },
  renderer = {
    group_empty = true,
    highlight_git = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
})

local which_key = require("which-key")

which_key.setup({
  preset = "modern",
  delay = 300,
})

which_key.add({
  { "<leader>f", group = "buscar" },
  { "<leader>l", group = "LSP" },
  { "<leader>m", group = "Markdown" },
  { "<leader>t", group = "LaTeX" },
  { "<leader>c", group = "CSV/colores" },
})
