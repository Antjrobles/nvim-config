return {
  -- Plugin 24: vim-fugitive (Integración avanzada con Git)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gcommit", "Gdiffsplit" },
    -- Cargar en repositorios Git para evitar problemas
    cond = function()
      return vim.fn.isdirectory(".git") == 1
    end,
    config = function()
      -- Mapeos simples como respaldo (similares a <leader>m
    end,
  },
  -- Plugin 25: windwp/nvim-autopairs (Autocompletar paréntesis y corchetes)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Habilitar soporte para TypeScript
        disable_filetype = { "TelescopePrompt", "vim" },
        fast_wrap = {
          map = "<M-e>",
          chars = { "{", "[", "(", '"', "'" },
          pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
        },
        ts_node = {
          ["@function.outer"] = { "{", "}" },
          ["@class.outer"] = { "{", "}" },
          ["@conditional.outer"] = { "{", "}" },
          ["@loop.outer"] = { "{", "}" },
          ["@parameter.outer"] = { "{", "}" },
        },
      })
    end,
  },
  -- Plugin 26: windwp/nvim-ts-autotag (Autocompletar etiquetas HTML/XML)
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = { "html", "xml", "vue", "tsx", "jsx" },
      })
    end,
  },
  -- Plugin 27: numToStr/Comment.nvim (Comentarios)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}