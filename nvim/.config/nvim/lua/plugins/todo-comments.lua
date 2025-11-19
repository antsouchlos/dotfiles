return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufEnter",
  keys = {
      {"<leader>ft", ":TodoTelescope<CR>", desc = "TODOs"}
  },
  config = true
}
