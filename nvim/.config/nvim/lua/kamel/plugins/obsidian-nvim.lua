return {
  "epwalsh/obsidian.nvim",
  version = "*", -- always use latest release
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "stevearc/dressing.nvim", -- optional: better input UI
  },
  opts = {
    dir = "~/my-vault",
    templates = {
      subdir = "templates",
      date_format = "%Y-%m-%d-%a",
      time_format = "%H:%M",
    },
    disable_frontmatter = true,
    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url }) -- Linux only
    end,

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d-%a",
      template = "templates/daily.md",
    },

    note_id_func = function(title)
      return title:gsub(" ", "-"):lower() -- simple slug-style IDs
    end,
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    local map = vim.keymap.set
    local mode = "n"

    -- Core commands
    map(mode, "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian" })
    map(mode, "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create new note" })
    map(mode, "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick switch note" })
    map(mode, "<leader>ol", "<cmd>ObsidianFollowLink<cr>", { desc = "Follow link under cursor" })
    map(mode, "<leader>ob", "<cmd>ObsidianBacklinksToggle<cr>", { desc = "Toggle backlinks" })
    map(mode, "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert template" })
    map(mode, "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Open today's daily note" })
    map(mode, "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Open yesterday's note" })
    map(mode, "<leader>of", "<cmd>ObsidianFollowExternalLink<cr>", { desc = "Open external link" })

    -- Preview markdown files
    map(mode, "<leader>op", "<cmd>ObsidianPreviewToggle<cr>", { desc = "Toggle live preview" })
  end,
}
