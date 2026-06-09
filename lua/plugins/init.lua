return {
  { lazy = true, "nvim-lua/plenary.nvim" },

  { "nvim-tree/nvim-web-devicons", opts = {} },
  { "echasnovski/mini.statusline", opts = {} },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set("n", "<leader>gb", gs.blame_line, { buffer = bufnr, desc = "Blame line (full)" })
        vim.keymap.set("n", "<leader>gB", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle inline blame" })
      end,
    },
  },

  "ellisonleao/gruvbox.nvim",

  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {},
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate | TSInstallAll",
    opts = function()
      return require "plugins.configs.treesitter"
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = require "plugins.configs.bufferline",
  },

  -- we use blink plugin only when in insert mode
  -- so lets lazyload it at InsertEnter event
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",

      -- snippets engine
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },

      -- autopairs , autocompletes ()[] etc
      { "windwp/nvim-autopairs", opts = {} },
    },
    -- made opts a function cuz cmp config calls cmp module
    -- and we lazyloaded cmp so we dont want that file to be read on startup!
    opts = function()
      return require "plugins.configs.blink"
    end,
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = { "Mason", "MasonInstall" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = require "plugins.configs.conform",
  },

  {
    "nvimdev/indentmini.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- files finder etc
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    opts = require "plugins.configs.telescope",
  },

  -- which-key: show keybinding hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require "plugins.configs.whichkey"
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "quarto", "rmd" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },

  -- clangd extensions: inlay hints, enhanced hover, etc.
  {
    "p00f/clangd_extensions.nvim",
    ft = { "c", "cpp", "objc", "objcpp", "cuda" },
    config = function()
      require("clangd_extensions").setup {
        inlay_hints = {
          inline = true,
          only_current_line = false,
          show_parameter_hints = true,
          parameter_hints_prefix = "← ",
          other_hints_prefix = "» ",
        },
        ast = {
          role_icons = {
            type = "",
            declaration = "",
            expression = "",
            specifier = "",
            statement = "",
            ["template argument"] = "",
          },
        },
      }
    end,
  },

}
