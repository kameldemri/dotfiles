return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "thin", -- slant, thin, thick, full
    },
  },

diagnostics_indicator = function(count, level)
    local icon = level:match("error") and " " or " "
    return " " .. icon .. count
end
}
