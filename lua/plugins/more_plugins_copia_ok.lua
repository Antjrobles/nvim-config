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
    lazy = false,
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
    "nvim-lua/plenary.nvim",
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
    dependencies = { "romgrk/fzy-lua-native" },
    build = ":UpdateRemotePlugins",
    config = function()
      local status_ok, wilder = pcall(require, "wilder")
      if not status_ok then
        vim.notify("wilder.nvim no se cargó correctamente", vim.log.levels.ERROR)
        return
      end
      pcall(function()
        wilder.setup({ modes = { ":", "/", "?" } })
        wilder.set_option("pipeline", {
          wilder.branch(
            wilder.cmdline_pipeline({
              fuzzy = 1,
              fuzzy_filter = wilder.lua_fzy_filter(),
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

   -- Plugin: ravitemer/mcphub.nvim (Configuración mínima de documentación)
   -- Plugin: ravitemer/mcphub.nvim
   {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup({
            --- `mcp-hub` binary related options-------------------
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
            port = 37373, -- The port `mcp-hub` server listens to
            shutdown_delay = 60 * 10 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 10 minutes)
            use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")

            ---Chat-plugin related options-----------------
            auto_approve = true, -- Auto approve mcp tool calls
            auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            },

            --- Plugin specific options-------------------
            native_servers = {}, -- add your custom lua native servers here
            ui = {
                window = {
                    width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    relative = "editor",
                    zindex = 50,
                    border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
                },
                wo = { -- window-scoped options (vim.wo)
                    winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
                },
            },
            on_ready = function(hub)
                -- Called when hub is ready
            end,
            on_error = function(err)
                -- Called on errors
            end,
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub",
            },
        })
    end
},

  -- Plugin: yetone/avante.nvim
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
      lazy = false,
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
      "nvim-lua/plenary.nvim",
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
      dependencies = { "romgrk/fzy-lua-native" },
      build = ":UpdateRemotePlugins",
      config = function()
        local status_ok, wilder = pcall(require, "wilder")
        if not status_ok then
          vim.notify("wilder.nvim no se cargó correctamente", vim.log.levels.ERROR)
          return
        end
        pcall(function()
          wilder.setup({ modes = { ":", "/", "?" } })
          wilder.set_option("pipeline", {
            wilder.branch(
              wilder.cmdline_pipeline({
                fuzzy = 1,
                fuzzy_filter = wilder.lua_fzy_filter(),
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

  -- Plugin: ravitemer/mcphub.nvim (Configuración mínima de documentación)
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
      build = "sudo npm install -g mcp-hub@latest",
      config = function()
          require("mcphub").setup()
      end
  },
  -- Plugin: yetone/avante.nvim

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
  }
