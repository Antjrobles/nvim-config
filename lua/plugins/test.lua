-- Plugin 7: Vista previa de Markdown con markview.nvim
{
  "OXY2DEV/markview.nvim",
  event = { "BufReadPre *.md", "BufNewFile *.md" },
  cmd = { "Markview" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("markview").setup({
      default_provider = "glow",
      providers = {
        glow = {
          style = "dark",
          border = "rounded",
        },
      },
    })
    -- Mapeo de tecla corregido
    vim.keymap.set("n", "<leader>.", "<cmd>Markview splitOpen<cr>", {
      noremap = true,
      silent = false,
      desc = "Markview: Open Split Preview",
    })
    vim.keymap.set("n", "<leader>,,", "<cmd>Markview splitClose<cr>", {
      noremap = true,
      silent = false,
      desc = "Markview: Close Split Preview",
    })
  end,
},