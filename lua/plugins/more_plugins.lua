return {
  -- Plugin 24: vim-fugitive (Integración avanzada con Git)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gcommit", "Gdiffsplit" },
    cond = function()
      return vim.fn.isdirectory(".git") == 1
    end,
    config = function()
      -- Mapeos simples como respaldo
    end,
  },

  -- Plugin 25: windwp/nvim-autopairs (Autocompletar paréntesis y corchetes)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
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

  -- Plugin 28: stevearc/dressing.nvim (Mejorar menús e inputs)
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        enabled = true,
        title_pos = "center",
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin" },
        builtin = {
          border = "rounded",
          win_options = {
            winblend = 10,
          },
        },
        telescope = {
          theme = "cursor",
        },
      },
    },
  },

  -- Plugin 29: rcarriga/nvim-notify (Sistema de notificaciones)
  {
    "rcarriga/nvim-notify",
    lazy = false, -- SE CARGA SIEMPRE
    init = function()
      vim.notify = require("notify")
    end,
    opts = {
      stages = "fade_in_slide_out",
      timeout = 3000,
      background_colour = "#1e1e2e",
      render = "default",
    },
  },

  -- Plugin 30: folke/noice.nvim (Mejora la interfaz de mensajes y comandos)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        progress = {
          enabled = true,
        },
        signature = {
          enabled = true,
        },
        hover = {
          enabled = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      },
      views = {
        cmdline_popup = {
          border = {
            style = "rounded",
          },
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          win_options = {
            winblend = 10,
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
          },
          win_options = {
            winblend = 10,
          },
        },
      },
    },
  },

  -- Autocomando que muestra una notificación al guardar (funciona con notify)
  {
    "nvim-lua/plenary.nvim", -- Dependencia dummy para cargar este bloque
    lazy = false,
    config = function()
      vim.api.nvim_create_autocmd("BufWritePost", {
        callback = function()
          vim.notify("Archivo guardado con éxito 📦", vim.log.levels.INFO)
        end,
      })
    end,
  },
-- Plugin 31: gelguy/wilder.nvim (Mejorar la línea de comandos)
{
  "gelguy/wilder.nvim",
  -- Eliminar event = "VeryLazy" para forzar carga temprana
  dependencies = { "romgrk/fzy-lua-native" },
  build = ":UpdateRemotePlugins", -- Asegurar que los plugins remotos (Python) se generen
  config = function()
    local status_ok, wilder = pcall(require, "wilder")
    if not status_ok then
      vim.notify("wilder.nvim no se cargó correctamente", vim.log.levels.ERROR)
      return
    end

    -- Inicializar wilder con manejo de errores
    pcall(function()
      wilder.setup({ modes = { ":", "/", "?" } })
      wilder.set_option("pipeline", {
        wilder.branch(
          wilder.cmdline_pipeline({
            fuzzy = 1,
            fuzzy_filter = wilder.lua_fzy_filter(), -- Fallback si fzy-lua-native falla
          }),
          wilder.python_search_pipeline({
            file_pattern = ".py",
          })
        ),
      })
      wilder.set_option("renderer", wilder.popupmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
        highlights = {
          accent_focused = { fg = "#ff79c6" },
          accent_unfocused = { fg = "#bd93f9" },
        },
      }))
    end)
  end,
},
}
