return {
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = { prompt_position = "top" },
    },
    mappings = {
      i = {
        ["<C-h>"] = function()
          require("telescope.builtin").search_history()
        end,
        ["<C-p>"] = function(...) require("telescope.actions").cycle_history_prev(...) end,
        ["<C-n>"] = function(...) require("telescope.actions").cycle_history_next(...) end,
      },
    },
  },
}
