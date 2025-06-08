return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "|",
      section_separators = { "", "" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = {
        {
          function()
            return "" -- Tux (Linux) icon
          end,
          color = { fg = "#FBCB21" }, -- Optional: set icon color
        },
        "mode"
      },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" }
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {}
    },
    extensions = {},
  },
}
