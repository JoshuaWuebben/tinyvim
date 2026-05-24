local wk = require "which-key"

wk.setup {
  delay = 500, -- ms before popup appears
  icons = {
    mappings = true,
  },
  win = {
    border = "rounded",
  },
}

-- Group labels for your existing keymaps
wk.add {
  -- Leader groups
  { "<leader>f", group = "Find (Telescope)" },
  { "<leader>ff", desc = "Find files" },
  { "<leader>fo", desc = "Recent files" },
  { "<leader>fw", desc = "Live grep" },
  { "<leader>fm", desc = "Format buffer" },

  { "<leader>g", group = "Git" },
  { "<leader>gt", desc = "Git status" },
  { "<leader>gb", desc = "Blame line (full)" },
  { "<leader>gB", desc = "Toggle inline blame" },

  { "<leader>/", desc = "Toggle comment" },

  -- LSP (space-prefixed)
  { "<space>", group = "LSP" },
  { "<space>D",  desc = "Type definition" },
  { "<space>rn", desc = "Rename symbol" },
  { "<space>w",  group = "Workspace" },
  { "<space>wa", desc = "Add workspace folder" },
  { "<space>wr", desc = "Remove workspace folder" },
  { "<space>wl", desc = "List workspace folders" },

  -- Buffer navigation
  { "<Tab>",   desc = "Next buffer" },
  { "<S-Tab>", desc = "Prev buffer" },
  { "<C-q>",   desc = "Close buffer" },

  -- File tree
  { "<C-n>", desc = "Toggle NvimTree" },
  { "<C-h>", desc = "Focus NvimTree" },
}
