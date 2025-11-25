return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufEnter",
  keys = {
      {"<leader>ft", ":TodoFzfLua<CR>", desc = "TODOs"}
  },
  config = true
}
