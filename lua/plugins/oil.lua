return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-mini/mini.icons" },
  lazy = false, -- importante para reemplazar netrw
  config = function()
    require("oil").setup({
      default_file_explorer = true,

      view_options = {
        show_hidden = true,
        show_path = "relative",
      },

      float = {
        padding = 2,
        max_width = 120,
        max_height = 30,

        border = "rounded",
      },

      keymaps = {
        ["q"] = "actions.close",
      },
    })
  end,
}
