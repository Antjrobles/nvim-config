-- Este archivo define la lista de plugins para lazy.nvim

-- Instalar lazy.nvim si no está presente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim y cargar plugins
require("lazy").setup({
  ui = { border = "rounded" },
  checker = { enabled = false },
  spec = {
    -- Plugin 1: neovim-ayu (Tema de colores personalizable)
    {
      "Shatur/neovim-ayu",
      lazy = false,
      priority = 1000,
      config = function()
        require("ayu").setup({
          mirage = false,
          overrides = { Normal = { bg = "none" } },
        })
        vim.cmd.colorscheme("ayu")
      end,
    },
    -- Plugin 2: nvim-tree.lua (Explorador de archivos tipo sidebar)
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeOpen" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 30,
            side = "left",
          },
          renderer = {
            group_empty = true,
            highlight_git = true,
            highlight_opened_files = "icon",
            highlight_modified = "icon",
            icons = {
              show = {
                folder_arrow = true,
              },
              glyphs = {
                default = "󰈙",
                symlink = "󰌽",
                folder = {
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
                },
                git = {
                  unstaged = "✗",
                  staged = "✓",
                  unmerged = "",
                  renamed = "➜",
                  untracked = "★",
                  deleted = "",
                  ignored = "◌",
                },
              },
            },
          },
          filters = {
            dotfiles = false,
          },
          -- Restaurar mapeos predeterminados y añadir solo 'u'
          on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            -- Cargar mapeos predeterminados
            api.config.mappings.default_on_attach(bufnr)
            -- Añadir solo el mapeo personalizado para 'u'
            vim.keymap.set("n", "u", api.tree.change_root_to_parent, {
              desc = "nvim-tree: Dir Up",
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            })
          end,
        })
        -- Ajustar resaltado para combinar con Ayu Dark
        vim.api.nvim_set_hl(
          0,
          "NvimTreeNormal",
          { bg = "#000000", fg = "#CBCCC6" }
        ) -- Fondo negro puro, texto claro
        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#334455" }) -- Línea seleccionada azul oscuro
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#73BFFA" }) -- Carpetas
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#A4B9EF" }) -- Carpetas abiertas
        vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#FF6A6A" }) -- Archivos modificados
      end,
    },
    -- Plugin 3: nvim-lualine (Barra de estado personalizable)
    {
      "nvim-lualine/lualine.nvim",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "ayu_dark", -- Cambiar a tema claro para que coincida con Ayu Light
            component_separators = { left = "│", right = "│" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "NvimTree" },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
        })
      end,
    },
    -- Plugin 4: nvim-web-devicons (Iconos para plugins y explorador de archivos)
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
    -- Plugin 5: nvim-treesitter (Resaltado de sintaxis avanzado y análisis de código)
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "BufReadPre",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "markdown",
            "markdown_inline",
            "lua",
            "vim",
            "vimdoc",
            -- AÑADIENDO PARSERS PARA LOS NUEVOS LENGUAJES
            "html",
            "css",
            "javascript", -- Ya estaba implícito por ts_ls, pero explícito es mejor
            "typescript", -- Ya estaba implícito por ts_ls
            "tsx", -- Ya estaba implícito por ts_ls
            "json",
            "yaml",
            "dockerfile",
            "bash",
            "go",
            "rust",
            "python", -- Ya lo tenías implícito por pyright
            "php",
            "c_sharp", -- Para C# (dotnet)
            "java",
            "kotlin",
            "swift",
            "sql",
          },
          highlight = { enable = true },
          indent = { enable = true },
          auto_install = true,
        })
        -- Personalizar colores de resaltado para Ayu Dark
        -- Markdown (para atajos.md)
        vim.api.nvim_set_hl(
          0,
          "@markup.heading.1.markdown",
          { fg = "#FF6A6A", bold = true }
        ) -- Títulos # (rojo brillante)
        vim.api.nvim_set_hl(
          0,
          "@markup.heading.2.markdown",
          { fg = "#FF8C8C", bold = true }
        ) -- Títulos ## (rojo más suave)
        vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#A4B9EF" }) -- Viñetas (azul suave)
        vim.api.nvim_set_hl(
          0,
          "@markup.strong.markdown",
          { fg = "#FFD700", bold = true }
        ) -- Texto en negrita (amarillo dorado)
        -- Lua (para archivos de configuración)
        vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#FF79C6" }) -- Palabras clave (rosa brillante)
        vim.api.nvim_set_hl(0, "@string.lua", { fg = "#BD93F9" }) -- Strings (púrpura suave)
        vim.api.nvim_set_hl(
          0,
          "@comment.lua",
          { fg = "#6272A4", italic = true }
        ) -- Comentarios (gris azulado, cursiva)
        -- General
        vim.api.nvim_set_hl(0, "@constant", { fg = "#FFB86C" }) -- Constantes (naranja suave)
        vim.api.nvim_set_hl(0, "@function", { fg = "#8BE9FD" }) -- Funciones (cian brillante)
      end,
    },
    -- Plugin 6: telescope.nvim (Buscador fuzzy para archivos y más)
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      },
      config = function()
        require("telescope").setup({})
      end,
    },
    -- Plugin 7: markview.nvim (Vista previa de Markdown)
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
    -- Plugin 8: nvim-lspconfig (Integración con servidores LSP)
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lspconfig = require("lspconfig")

        -- TypeScript/JavaScript LSP moderno
        lspconfig.tsserver = nil -- asegúrate de limpiarlo si ya existe
        lspconfig.ts_ls.setup({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "tsx",
          },
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = lspconfig.util.root_pattern(
            "package.json",
            "tsconfig.json",
            ".git"
          ),
          single_file_support = false,
        })

        -- Python
        lspconfig.pyright.setup({})

        -- Lua
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        })
      end,
    },
    -- Plugin 9: nvim-cmp (Motor de autocompletado)
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
          },
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
        })

        -- Required for correct capabilities
        local capabilities_original_cmp =
          require("cmp_nvim_lsp").default_capabilities() -- Renombrada para evitar conflicto

        -- Override default LSP capabilities (include this in your lspconfig setup)
        require("lspconfig").ts_ls.setup({ -- Esto podría estar reconfigurando ts_ls
          capabilities = capabilities_original_cmp,
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = require("lspconfig").util.root_pattern(
            "package.json",
            "tsconfig.json",
            ".git"
          ),
          filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "tsx",
          },
        })
      end,
    },
    -- Plugin 10: gitsigns.nvim (Indicadores de cambios Git en la columna de signos)
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" }, -- Eventos para cargar el plugin
      opts = { -- Usar 'opts' para pasar la configuración directamente al setup del plugin
        signs = {
          add = { text = "➕" }, -- Línea añadida
          change = { text = "📝" }, -- Línea modificada
          delete = { text = "❌" }, -- Línea eliminada
          topdelete = { text = "🗑️" }, -- Eliminada desde el inicio del archivo
          changedelete = { text = "✂️" }, -- Línea modificada y borrada
          untracked = { text = "🔍" }, -- Línea no rastreada
        },
        signcolumn = true, -- Mostrar columna de signos
      },
    },
    -- Plugin 11: plenary.nvim (Biblioteca de utilidades para otros plugins)
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    -- Plugin 12: mason.nvim (Gestor de instalación de herramientas y LSP)
    {
      "williamboman/mason.nvim",
      cmd = "Mason", -- Para carga diferida hasta que se llame a :Mason
      config = function()
        require("mason").setup({
          ui = {
            border = "rounded",
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })
      end,
    },
    -- Plugin 13: mason-lspconfig.nvim (Puente entre Mason y LSP para instalación automática)
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
      -- Cargar después de mason y lspconfig
      -- event = { "BufReadPre", "BufNewFile" }, -- Opcional, para cargar cuando se abre un archivo
      config = function()
        -- Es CRUCIAL que la variable 'capabilities_for_mason' sea la correcta para nvim-cmp.
        -- Idealmente, se define UNA SOLA VEZ de forma global o se pasa consistentemente.
        -- Aquí, la definimos de nuevo. Esto podría ser un punto a refinar.
        local capabilities_for_mason =
          require("cmp_nvim_lsp").default_capabilities()

        require("mason-lspconfig").setup({
          ensure_installed = {
            -- Tus LSPs existentes que quieres que Mason gestione (ts_ls y pyright ya están arriba)
            -- "lua_ls", -- lua_ls ya lo tienes arriba, no lo dupliques aquí a menos que quieras que Mason lo gestione

            -- NUEVOS LSPs que pediste:
            "html", -- Servidor: html (vscode-html-language-server)
            "cssls", -- Servidor: cssls (vscode-css-language-server)
            "jsonls", -- Servidor: jsonls (vscode-json-language-server)
            "yamlls", -- Servidor: yamlls (yaml-language-server)
            "dockerls", -- Servidor: dockerls (dockerfile-language-server-nodejs)
            "bashls", -- Servidor: bashls (bash-language-server)

            -- 10 más que considero útiles (elige los que necesites):
            "rust_analyzer", -- Rust
            "intelephense", -- PHP (necesita 'npm i -g intelephense' o licencia para todo) o phpactor
            "marksman", -- Markdown (alternativa/complemento a tu previewer)
            "tailwindcss", -- Tailwind CSS
            "eslint", -- Linter/formateador para JS/TS (puede configurarse como LSP)
            "sqlls", -- SQL Language Server
            "jdtls", -- Java (requiere configuración más compleja y JDK)
            -- "kotlin_language_server", -- Kotlin
            -- "sourcekit_lsp",         -- Swift (requiere Xcode en macOS)
          },
          handlers = {
            -- Configuración por defecto para cada servidor instalado por Mason
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = capabilities_for_mason, -- Usa las capabilities definidas aquí
              })
            end,

            -- Puedes añadir handlers personalizados si un servidor necesita configuración especial
            -- Ejemplo: si 'lua_ls' fuera gestionado por Mason y necesitara settings especiales:
            -- ["lua_ls"] = function()
            --   require("lspconfig").lua_ls.setup({
            --     capabilities = capabilities_for_mason,
            --     settings = { Lua = { diagnostics = { globals = {"vim"} } } }
            --   })
            -- end,
          },
        })
      end,
    },
    -- Plugin 14: minimap.vim (Muestra un minimapa del código al estilo VSCode)
    {
      "wfxr/minimap.vim",
      config = function()
        -- Configuraciones básicas del minimap
        vim.g.minimap_width = 10 -- Ancho del minimap
        vim.g.minimap_auto_start = 1 -- Iniciar automáticamente al abrir un archivo
        vim.g.minimap_auto_start_win_enter = 1 -- Mostrar al entrar en una ventana
        -- Keymap para alternar el minimap
        vim.keymap.set(
          "n",
          "<Leader>m",
          ":MinimapToggle<CR>",
          { noremap = true, silent = true, desc = "Toggle Minimap" }
        )
      end,
    },
    -- Plugin 15: copilot.vim (Asistente de autocompletado basado en IA de GitHub, comentado)
    -- {
    --   "github/copilot.vim",
    --   config = function()
    --     -- Configuración opcional
    --     vim.g.copilot_no_tab_map = true -- Desactiva el mapeo por defecto de Tab
    --     vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    --   end,
    -- },
    -- Plugin 16: codeium.vim (Asistente de autocompletado basado en IA)
    {
      "Exafunction/codeium.vim",
      config = function()
        -- Configuración opcional
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true })
        vim.keymap.set("i", "<C-;>", function()
          return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true })
        vim.keymap.set("i", "<C-,>", function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true })
      end,
    },
    -- Plugin 17: mini.nvim (Colección de mejoras visuales y utilidades)
    {
      "echasnovski/mini.nvim",
      version = false, -- Usa la última versión
      config = function()
        -- Módulo para resaltar indentación
        require("mini.indentscope").setup({
          symbol = "┊", -- Línea vertical para indentación
          options = { try_as_border = true },
        })
        -- Barra de estado ligera
        require("mini.statusline").setup({
          use_icons = true,
        })
        -- Mejora visual de las pestañas
        require("mini.tabline").setup()
      end,
    },
    -- Plugin 18: indent-blankline.nvim (Líneas visuales de indentación)
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      config = function()
        require("ibl").setup({
          indent = {
            char = "│", -- Símbolo de indentación
            highlight = "IblIndent",
          },
          scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            highlight = "IblScope",
          },
        })
      end,
    },
    -- Plugin 19: rainbow-delimiters.nvim (Resalta delimitadores con colores)
    {
      "HiPhish/rainbow-delimiters.nvim",
      config = function()
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
          strategy = {
            [""] = rainbow_delimiters.strategy["global"],
          },
          query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
          },
          highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        })
      end,
    },
    -- Plugin 20: twilight.nvim (Atenúa el código fuera del bloque actual)
    {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({
          dimming = {
            alpha = 0.80, -- Nivel de atenuación (0 a 1)
            inactive = true, -- Atenúa bloques inactivos
          },
          context = 10, -- Líneas visibles alrededor del cursor
          treesitter = true, -- Usa Treesitter para mejor precisión
        })
      end,
    },
    -- Plugin 21: bufferline.nvim (Barra de buffers visualmente mejorada)
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      event = "VeryLazy",
      config = function()
        require("bufferline").setup({
          options = {
            mode = "buffers",
            diagnostics = "nvim_lsp",
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true,
              },
            },
          },
        })

        -- Keymaps para moverte entre buffers
        vim.keymap.set(
          "n",
          "<Tab>",
          "<cmd>BufferLineCycleNext<CR>",
          { desc = "Siguiente buffer" }
        )
        vim.keymap.set(
          "n",
          "<S-Tab>",
          "<cmd>BufferLineCyclePrev<CR>",
          { desc = "Anterior buffer" }
        )
      end,
    },
    -- Plugin 22: conform.nvim (Formateo automático de archivos)
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" }, -- Para formatear automáticamente al guardar
      cmd = { "ConformInfo" }, -- Carga el plugin solo cuando se usa este comando
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" }, -- Usa stylua para formatear archivos Lua
            json = { "prettier" }, -- Usa prettier para formatear archivos JSON
            yaml = { "prettier" }, -- Usa prettier para formatear archivos YAML
            markdown = { "prettier" }, -- Usa prettier para formatear archivos Markdown
            html = { "prettier" }, -- Usa prettier para formatear archivos HTML
            css = { "prettier" }, -- Usa prettier para formatear archivos CSS
            tsx = { "prettier" }, -- Usa prettier para formatear archivos TSX
            javascript = { "prettier" }, -- Usa prettier para formatear archivos JavaScript
            typescript = { "prettier" }, -- Usa prettier para formatear archivos TypeScript
          },
          format_on_save = {
            timeout_ms = 500, -- Tiempo máximo para formatear
            lsp_fallback = true, -- Usa LSP como fallback si el formateador falla
          },
        })
      end,
    },
    -- Plugin 23: todo-comments.nvim (Resalta y gestiona comentarios TODO, FIX, etc.)
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("todo-comments").setup({
          signs = true, -- Mostrar signos en la columna de signos
          keywords = {
            FIX = { icon = "� --

System: * The response was cut off due to exceeding the maximum allowed length. I will continue from where it left off, ensuring the artifact is complete and accurate, addressing the `markview.nvim` syntax error, and including all plugins (especially `minimap.vim` and `copilot.vim`) with correct numbering and descriptive comments, without modifying the original configuration except for the necessary fixes.

<xaiArtifact artifact_id="e1217d02-9fdf-4b91-9050-2f5112cd8919" artifact_version_id="f06e399c-f196-44dd-95f4-baae177aff6f" title="init.lua" contentType="text/x-lua">
-- Este archivo define la lista de plugins para lazy.nvim

-- Instalar lazy.nvim si no está presente
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configurar lazy.nvim y cargar plugins
require("lazy").setup({
  ui = { border = "rounded" },
  checker = { enabled = false },
  spec = {
    -- Plugin 1: neovim-ayu (Tema de colores personalizable)
    {
      "Shatur/neovim-ayu",
      lazy = false,
      priority = 1000,
      config = function()
        require("ayu").setup({
          mirage = false,
          overrides = { Normal = { bg = "none" } },
        })
        vim.cmd.colorscheme("ayu")
      end,
    },
    -- Plugin 2: nvim-tree.lua (Explorador de archivos tipo sidebar)
    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeOpen" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("nvim-tree").setup({
          view = {
            width = 30,
            side = "left",
          },
          renderer = {
            group_empty = true,
            highlight_git = true,
            highlight_opened_files = "icon",
            highlight_modified = "icon",
            icons = {
              show = {
                folder_arrow = true,
              },
              glyphs = {
                default = "󰈙",
                symlink = "󰌽",
                folder = {
                  default = "",
                  open = "",
                  empty = "",
                  empty_open = "",
                  symlink = "",
                },
                git = {
                  unstaged = "✗",
                  staged = "✓",
                  unmerged = "",
                  renamed = "➜",
                  untracked = "★",
                  deleted = "",
                  ignored = "◌",
                },
              },
            },
          },
          filters = {
            dotfiles = false,
          },
          -- Restaurar mapeos predeterminados y añadir solo 'u'
          on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            -- Cargar mapeos predeterminados
            api.config.mappings.default_on_attach(bufnr)
            -- Añadir solo el mapeo personalizado para 'u'
            vim.keymap.set("n", "u", api.tree.change_root_to_parent, {
              desc = "nvim-tree: Dir Up",
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            })
          end,
        })
        -- Ajustar resaltado para combinar con Ayu Dark
        vim.api.nvim_set_hl(
          0,
          "NvimTreeNormal",
          { bg = "#000000", fg = "#CBCCC6" }
        ) -- Fondo negro puro, texto claro
        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#334455" }) -- Línea seleccionada azul oscuro
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#73BFFA" }) -- Carpetas
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#A4B9EF" }) -- Carpetas abiertas
        vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#FF6A6A" }) -- Archivos modificados
      end,
    },
    -- Plugin 3: nvim-lualine (Barra de estado personalizable)
    {
      "nvim-lualine/lualine.nvim",
      event = { "BufReadPost", "BufNewFile" },
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = {
            theme = "ayu_dark", -- Cambiar a tema claro para que coincida con Ayu Light
            component_separators = { left = "│", right = "│" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "NvimTree" },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch", "diff", "diagnostics" },
            lualine_c = { "filename" },
            lualine_x = { "encoding", "fileformat", "filetype" },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
        })
      end,
    },
    -- Plugin 4: nvim-web-devicons (Iconos para plugins y explorador de archivos)
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
    -- Plugin 5: nvim-treesitter (Resaltado de sintaxis avanzado y análisis de código)
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      event = "BufReadPre",
      config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "markdown",
            "markdown_inline",
            "lua",
            "vim",
            "vimdoc",
            -- AÑADIENDO PARSERS PARA LOS NUEVOS LENGUAJES
            "html",
            "css",
            "javascript", -- Ya estaba implícito por ts_ls, pero explícito es mejor
            "typescript", -- Ya estaba implícito por ts_ls
            "tsx", -- Ya estaba implícito por ts_ls
            "json",
            "yaml",
            "dockerfile",
            "bash",
            "go",
            "rust",
            "python", -- Ya lo tenías implícito por pyright
            "php",
            "c_sharp", -- Para C# (dotnet)
            "java",
            "kotlin",
            "swift",
            "sql",
          },
          highlight = { enable = true },
          indent = { enable = true },
          auto_install = true,
        })
        -- Personalizar colores de resaltado para Ayu Dark
        -- Markdown (para atajos.md)
        vim.api.nvim_set_hl(
          0,
          "@markup.heading.1.markdown",
          { fg = "#FF6A6A", bold = true }
        ) -- Títulos # (rojo brillante)
        vim.api.nvim_set_hl(
          0,
          "@markup.heading.2.markdown",
          { fg = "#FF8C8C", bold = true }
        ) -- Títulos ## (rojo más suave)
        vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#A4B9EF" }) -- Viñetas (azul suave)
        vim.api.nvim_set_hl(
          0,
          "@markup.strong.markdown",
          { fg = "#FFD700", bold = true }
        ) -- Texto en negrita (amarillo dorado)
        -- Lua (para archivos de configuración)
        vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#FF79C6" }) -- Palabras clave (rosa brillante)
        vim.api.nvim_set_hl(0, "@string.lua", { fg = "#BD93F9" }) -- Strings (púrpura suave)
        vim.api.nvim_set_hl(
          0,
          "@comment.lua",
          { fg = "#6272A4", italic = true }
        ) -- Comentarios (gris azulado, cursiva)
        -- General
        vim.api.nvim_set_hl(0, "@constant", { fg = "#FFB86C" }) -- Constantes (naranja suave)
        vim.api.nvim_set_hl(0, "@function", { fg = "#8BE9FD" }) -- Funciones (cian brillante)
      end,
    },
    -- Plugin 6: telescope.nvim (Buscador fuzzy para archivos y más)
    {
      "nvim-telescope/telescope.nvim",
      tag = "0.1.5",
      dependencies = { "nvim-lua/plenary.nvim" },
      cmd = "Telescope",
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      },
      config = function()
        require("telescope").setup({})
      end,
    },
    -- Plugin 7: markview.nvim (Vista previa de Markdown)
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
    -- Plugin 8: nvim-lspconfig (Integración con servidores LSP)
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lspconfig = require("lspconfig")

        -- TypeScript/JavaScript LSP moderno
        lspconfig.tsserver = nil -- asegúrate de limpiarlo si ya existe
        lspconfig.ts_ls.setup({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "tsx",
          },
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = lspconfig.util.root_pattern(
            "package.json",
            "tsconfig.json",
            ".git"
          ),
          single_file_support = false,
        })

        -- Python
        lspconfig.pyright.setup({})

        -- Lua
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        })
      end,
    },
    -- Plugin 9: nvim-cmp (Motor de autocompletado)
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
          },
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
        })

        -- Required for correct capabilities
        local capabilities_original_cmp =
          require("cmp_nvim_lsp").default_capabilities() -- Renombrada para evitar conflicto

        -- Override default LSP capabilities (include this in your lspconfig setup)
        require("lspconfig").ts_ls.setup({ -- Esto podría estar reconfigurando ts_ls
          capabilities = capabilities_original_cmp,
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = require("lspconfig").util.root_pattern(
            "package.json",
            "tsconfig.json",
            ".git"
          ),
          filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "tsx",
          },
        })
      end,
    },
    -- Plugin 10: gitsigns.nvim (Indicadores de cambios Git en la columna de signos)
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" }, -- Eventos para cargar el plugin
      opts = { -- Usar 'opts' para pasar la configuración directamente al setup del plugin
        signs = {
          add = { text = "➕" }, -- Línea añadida
          change = { text = "📝" }, -- Línea modificada
          delete = { text = "❌" }, -- Línea eliminada
          topdelete = { text = "🗑️" }, -- Eliminada desde el inicio del archivo
          changedelete = { text = "✂️" }, -- Línea modificada y borrada
          untracked = { text = "🔍" }, -- Línea no rastreada
        },
        signcolumn = true, -- Mostrar columna de signos
      },
    },
    -- Plugin 11: plenary.nvim (Biblioteca de utilidades para otros plugins)
    {
      "nvim-lua/plenary.nvim",
      lazy = true,
    },
    -- Plugin 12: mason.nvim (Gestor de instalación de herramientas y LSP)
    {
      "williamboman/mason.nvim",
      cmd = "Mason", -- Para carga diferida hasta que se llame a :Mason
      config = function()
        require("mason").setup({
          ui = {
            border = "rounded",
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        })
      end,
    },
    -- Plugin 13: mason-lspconfig.nvim (Puente entre Mason y LSP para instalación automática)
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
      -- Cargar después de mason y lspconfig
      -- event = { "BufReadPre", "BufNewFile" }, -- Opcional, para cargar cuando se abre un archivo
      config = function()
        -- Es CRUCIAL que la variable 'capabilities_for_mason' sea la correcta para nvim-cmp.
        -- Idealmente, se define UNA SOLA VEZ de forma global o se pasa consistentemente.
        -- Aquí, la definimos de nuevo. Esto podría ser un punto a refinar.
        local capabilities_for_mason =
          require("cmp_nvim_lsp").default_capabilities()

        require("mason-lspconfig").setup({
          ensure_installed = {
            -- Tus LSPs existentes que quieres que Mason gestione (ts_ls y pyright ya están arriba)
            -- "lua_ls", -- lua_ls ya lo tienes arriba, no lo dupliques aquí a menos que quieras que Mason lo gestione

            -- NUEVOS LSPs que pediste:
            "html", -- Servidor: html (vscode-html-language-server)
            "cssls", -- Servidor: cssls (vscode-css-language-server)
            "jsonls", -- Servidor: jsonls (vscode-json-language-server)
            "yamlls", -- Servidor: yamlls (yaml-language-server)
            "dockerls", -- Servidor: dockerls (dockerfile-language-server-nodejs)
            "bashls", -- Servidor: bashls (bash-language-server)

            -- 10 más que considero útiles (elige los que necesites):
            "rust_analyzer", -- Rust
            "intelephense", -- PHP (necesita 'npm i -g intelephense' o licencia para todo) o phpactor
            "marksman", -- Markdown (alternativa/complemento a tu previewer)
            "tailwindcss", -- Tailwind CSS
            "eslint", -- Linter/formateador para JS/TS (puede configurarse como LSP)
            "sqlls", -- SQL Language Server
            "jdtls", -- Java (requiere configuración más compleja y JDK)
            -- "kotlin_language_server", -- Kotlin
            -- "sourcekit_lsp",         -- Swift (requiere Xcode en macOS)
          },
          handlers = {
            -- Configuración por defecto para cada servidor instalado por Mason
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = capabilities_for_mason, -- Usa las capabilities definidas aquí
              })
            end,

            -- Puedes añadir handlers personalizados si un servidor necesita configuración especial
            -- Ejemplo: si 'lua_ls' fuera gestionado por Mason y necesitara settings especiales:
            -- ["lua_ls"] = function()
            --   require("lspconfig").lua_ls.setup({
            --     capabilities = capabilities_for_mason,
            --     settings = { Lua = { diagnostics = { globals = {"vim"} } } }
            --   })
            -- end,
          },
        })
      end,
    },
    -- Plugin 14: minimap.vim (Muestra un minimapa del código al estilo VSCode)
    {
      "wfxr/minimap.vim",
      config = function()
        -- Configuraciones básicas del minimap
        vim.g.minimap_width = 10 -- Ancho del minimap
        vim.g.minimap_auto_start = 1 -- Iniciar automáticamente al abrir un archivo
        vim.g.minimap_auto_start_win_enter = 1 -- Mostrar al entrar en una ventana
        -- Keymap para alternar el minimap
        vim.keymap.set(
          "n",
          "<Leader>m",
          ":MinimapToggle<CR>",
          { noremap = true, silent = true, desc = "Toggle Minimap" }
        )
      end,
    },
    -- Plugin 15: copilot.vim (Asistente de autocompletado basado en IA de GitHub, comentado)
    -- {
    --   "github/copilot.vim",
    --   config = function()
    --     -- Configuración opcional
    --     vim.g.copilot_no_tab_map = true -- Desactiva el mapeo por defecto de Tab
    --     vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    --   end,
    -- },
    -- Plugin 16: codeium.vim (Asistente de autocompletado basado en IA)
    {
      "Exafunction/codeium.vim",
      config = function()
        -- Configuración opcional
        vim.keymap.set("i", "<C-g>", function()
          return vim.fn["codeium#Accept"]()
        end, { expr = true })
        vim.keymap.set("i", "<C-;>", function()
          return vim.fn["codeium#CycleCompletions"](1)
        end, { expr = true })
        vim.keymap.set("i", "<C-,>", function()
          return vim.fn["codeium#CycleCompletions"](-1)
        end, { expr = true })
      end,
    },
    -- Plugin 17: mini.nvim (Colección de mejoras visuales y utilidades)
    {
      "echasnovski/mini.nvim",
      version = false, -- Usa la última versión
      config = function()
        -- Módulo para resaltar indentación
        require("mini.indentscope").setup({
          symbol = "┊", -- Línea vertical para indentación
          options = { try_as_border = true },
        })
        -- Barra de estado ligera
        require("mini.statusline").setup({
          use_icons = true,
        })
        -- Mejora visual de las pestañas
        require("mini.tabline").setup()
      end,
    },
    -- Plugin 18: indent-blankline.nvim (Líneas visuales de indentación)
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      config = function()
        require("ibl").setup({
          indent = {
            char = "│", -- Símbolo de indentación
            highlight = "IblIndent",
          },
          scope = {
            enabled = true,
            show_start = true,
            show_end = true,
            highlight = "IblScope",
          },
        })
      end,
    },
    -- Plugin 19: rainbow-delimiters.nvim (Resalta delimitadores con colores)
    {
      "HiPhish/rainbow-delimiters.nvim",
      config = function()
        local rainbow_delimiters = require("rainbow-delimiters")
        require("rainbow-delimiters.setup").setup({
          strategy = {
            [""] = rainbow_delimiters.strategy["global"],
          },
          query = {
            [""] = "rainbow-delimiters",
            lua = "rainbow-blocks",
          },
          highlight = {
            "RainbowDelimiterRed",
            "RainbowDelimiterYellow",
            "RainbowDelimiterBlue",
            "RainbowDelimiterOrange",
            "RainbowDelimiterGreen",
            "RainbowDelimiterViolet",
            "RainbowDelimiterCyan",
          },
        })
      end,
    },
    -- Plugin 20: twilight.nvim (Atenúa el código fuera del bloque actual)
    {
      "folke/twilight.nvim",
      config = function()
        require("twilight").setup({
          dimming = {
            alpha = 0.80, -- Nivel de atenuación (0 a 1)
            inactive = true, -- Atenúa bloques inactivos
          },
          context = 10, -- Líneas visibles alrededor del cursor
          treesitter = true, -- Usa Treesitter para mejor precisión
        })
      end,
    },
    -- Plugin 21: bufferline.nvim (Barra de buffers visualmente mejorada)
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      event = "VeryLazy",
      config = function()
        require("bufferline").setup({
          options = {
            mode = "buffers",
            diagnostics = "nvim_lsp",
            offsets = {
              {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                separator = true,
              },
            },
          },
        })

        -- Keymaps para moverte entre buffers
        vim.keymap.set(
          "n",
          "<Tab>",
          "<cmd>BufferLineCycleNext<CR>",
          { desc = "Siguiente buffer" }
        )
        vim.keymap.set(
          "n",
          "<S-Tab>",
          "<cmd>BufferLineCyclePrev<CR>",
          { desc = "Anterior buffer" }
        )
      end,
    },
    -- Plugin 22: conform.nvim (Formateo automático de archivos)
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" }, -- Para formatear automáticamente al guardar
      cmd = { "ConformInfo" }, -- Carga el plugin solo cuando se usa este comando
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" }, -- Usa stylua para formatear archivos Lua
            json = { "prettier" }, -- Usa prettier para formatear archivos JSON
            yaml = { "prettier" }, -- Usa prettier para formatear archivos YAML
            markdown = { "prettier" }, -- Usa prettier para formatear archivos Markdown
            html = { "prettier" }, -- Usa prettier para formatear archivos HTML
            css = { "prettier" }, -- Usa prettier para formatear archivos CSS
            tsx = { "prettier" }, -- Usa prettier para formatear archivos TSX
            javascript = { "prettier" }, -- Usa prettier para formatear archivos JavaScript
            typescript = { "prettier" }, -- Usa prettier para formatear archivos TypeScript
          },
          format_on_save = {
            timeout_ms = 500, -- Tiempo máximo para formatear
            lsp_fallback = true, -- Usa LSP como fallback si el formateador falla
          },
        })
      end,
    },
    -- Plugin 23: todo-comments.nvim (Resalta y gestiona comentarios TODO, FIX, etc.)
    {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
        require("todo-comments").setup({
          signs = true, -- Mostrar signos en la columna de signos
          keywords = {
            FIX = { icon = " ", color = "error" }, -- Errores
            TODO = { icon = " ", color = "info" }, -- Tareas pendientes
            HACK = { icon = " ", color = "warning" }, -- Hacks
            WARN = { icon = " ", color = "warning" }, -- Advertencias
            PERF = { icon = " ", color = "hint" }, -- Mejoras de rendimiento
            NOTE = { icon = " ", color = "hint" }, -- Notas
          },
        })
      end,
    },
  }, -- Fin de la tabla spec
}) -- Fin de lazy.setup