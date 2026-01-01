return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    local config = require("nvim-treesitter-textobjects")
    config.setup({
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
        -- You can choose the select mode (default is charwise 'v')
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * method: eg 'v' or 'o'
        -- and should return the mode ('v', 'V', or '<c-v>') or a table
        -- mapping query_strings to modes.
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V', -- linewise
          -- ['@class.outer'] = '<c-v>', -- blockwise
        },
        -- If you set this to `true` (default is `false`) then any textobject is
        -- extended to include p
        --
        -- receding or succeeding whitespace. Succeeding
        -- whitespace has priority in order to act similarly to eg the built-in
        -- `ap`.
        --
        -- Can also be a function which gets passed a table with the keys
        -- * query_string: eg '@function.inner'
        -- * selection_mode: eg 'v'
        -- and should return true of false
        include_surrounding_whitespace = false,
      },


    })
    -- keymaps
    -- You can use the capture groups defined in `textobjects.scm`

    local select = require("nvim-treesitter-textobjects.select")
    local swap   = require("nvim-treesitter-textobjects.swap")

    local select_maps = {
      ["af"] = { "@function.outer", "textobjects", "Select function (outer)" },
        ["if"] = { "@function.inner", "textobjects", "Select function (inner)" },
          ["ac"] = { "@class.outer",    "textobjects", "Select class (outer)" },
          ["ic"] = { "@class.inner",    "textobjects", "Select class (inner)" },
          ["as"] = { "@local.scope",    "locals",      "Select scope" },
          ["ao"] = { "@comment.outer",  "textobjects", "Select comment (outer)" },
        }


        for key, map in pairs(select_maps) do
          vim.keymap.set({ "x", "o" }, key, function()
            select.select_textobject(map[1], map[2])
          end, { desc = map[3] })
        end

        vim.keymap.set("n", "<leader>a",
        function() swap.swap_next("@parameter.inner") end,
        { desc = "Swap parameter with next" }
      )

      vim.keymap.set("n", "<leader>A",
      function() swap.swap_previous("@parameter.outer") end,
      { desc = "Swap parameter with previous" }
    )

  end,
} 
