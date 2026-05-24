-- Diagnostic display config
vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
    severity = { min = vim.diagnostic.severity.HINT },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true, -- show "clangd" as the source
  },
}

-- Use LspAttach autocommand to only map the following keys
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "<space>e", function() vim.diagnostic.open_float() end, vim.tbl_extend("force", opts, { desc = "Show diagnostic" }))
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, vim.tbl_extend("force", opts, { desc = "Prev diagnostic" }))
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

    -- enable inlay hints
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

    -- swap between header and source file (clangd only)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "clangd" then
      local switch = function()
        local params = { uri = vim.uri_from_bufnr(0) }
        client:request("textDocument/switchSourceHeader", params, function(err, result)
          if err then
            vim.notify("switchSourceHeader: " .. err.message, vim.log.levels.ERROR)
            return
          end
          if result then
            vim.cmd("edit " .. vim.uri_to_fname(result))
          end
        end, 0)
      end
      local switch_opts = vim.tbl_extend("force", opts, { desc = "Switch header/source" })
      vim.keymap.set("n", "<A-o>", switch, switch_opts)
      vim.keymap.set("n", "ø", switch, switch_opts)
    end

    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
  end,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

vim.lsp.config("*", { capabilities = capabilities })

-- clangd-specific config: disable encoding offset conflict with blink.cmp
vim.lsp.config("clangd", {
  capabilities = vim.tbl_deep_extend("force", capabilities, {
    offsetEncoding = { "utf-16" },
  }),
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

local servers = { "html", "cssls", "lua_ls", "clangd" }

vim.lsp.enable(servers)
