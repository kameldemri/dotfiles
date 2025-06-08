return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    -- Import required modules
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap -- for conciseness

    -- Set up keymaps on LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Keybindings
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)          -- Show references
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)                    -- Go to declaration
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)        -- Show definitions
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)     -- Show implementations
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)   -- Show type definitions
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)     -- Code actions
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)                  -- Rename symbol
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- Show file diagnostics
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)            -- Show line diagnostic float
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)                    -- Previous diagnostic
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)                    -- Next diagnostic
        keymap.set("n", "K", vim.lsp.buf.hover, opts)                           -- Hover docs
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)                   -- Restart LSP
      end,
    })

    -- Setup capabilities for autocompletion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Get list of installed servers from Mason
    local available_servers = mason_lspconfig.get_installed_servers()

    -- Setup each server with custom options
    for _, server_name in ipairs(available_servers) do
      local opts = {
        capabilities = capabilities,
      }

      -- Custom configs per server
      if server_name == "svelte" then
        opts.on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = { "*.js", "*.ts" },
            callback = function(ctx)
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.buf })
            end,
          })
        end

      elseif server_name == "graphql" then
        opts.filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" }

      elseif server_name == "emmet_ls" then
        opts.filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" }

      elseif server_name == "lua_ls" then
        opts.settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            completion = { callSnippet = "Replace" },
          },
        }
      end

      -- Start the LSP server with custom opts
      lspconfig[server_name].setup(opts)
    end
  end,
}
