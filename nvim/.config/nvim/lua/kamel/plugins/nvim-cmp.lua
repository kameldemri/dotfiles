return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- buffer word completion
    "hrsh7th/cmp-path",   -- file path suggestions
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" }, -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- cmp + luasnip integration
    "rafamadriz/friendly-snippets", -- extra snippets
    "onsails/lspkind.nvim", -- icons for completion menu
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        -- Tab key navigation
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp"},
        { name = "buffer" }, -- current buffer words
        { name = "path" },   -- file system paths
        { name = "luasnip" },-- snippets
      }),
      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol_text",
          maxwidth = 50,
          ellipsis_char = "...",
          before = function(entry, vim_item)
            return vim_item
          end,
        }),
      },
      experimental = {
        ghost_text = true, -- preview suggestion as gray text
      },
    })

    -- Cmdline completion
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }
      }, {
        { name = "cmdline" }
      })
    })
  end,
}
