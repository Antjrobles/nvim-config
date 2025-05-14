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
    -- Plugin 1: Tema de colores Ayu (carga siempre)
    {
      "Shatur/neovim-ayu",
      lazy = false,
      priority = 1000,
      config = function()
        require("ayu").setup({ mirage = false, overrides = { Normal = { bg = "none" } } })
        vim.cmd.colorscheme "ayu"
      end,
    },
       -- Plugin 2: Explorador de archivos
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
              dotfiles = true,
            },
            -- Restaurar mapeos predeterminados y añadir solo 'u'
            on_attach = function(bufnr)
              local api = require("nvim-tree.api")
              -- Cargar mapeos predeterminados
              api.config.mappings.default_on_attach(bufnr)
              -- Añadir solo el mapeo personalizado para 'u'
              vim.keymap.set("n", "u", api.tree.change_root_to_parent, { desc = "nvim-tree: Dir Up", buffer = bufnr, noremap = true, silent = true, nowait = true })
            end,
          })
          -- Ajustar resaltado para combinar con Ayu Dark
          vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000", fg = "#CBCCC6" }) -- Fondo negro puro, texto claro
          vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#334455" }) -- Línea seleccionada azul oscuro
          vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#73BFFA" }) -- Carpetas
          vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#A4B9EF" }) -- Carpetas abiertas
          vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#FF6A6A" }) -- Archivos modificados
        end,
      },
    -- Plugin 3: Barra de estado
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

    -- Plugin 4: Iconos
    {
      "nvim-tree/nvim-web-devicons",
      lazy = true,
    },
       -- Plugin 5: Resaltado de sintaxis
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
            },
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
          })
          -- Personalizar colores de resaltado para Ayu Dark
          -- Markdown (para atajos.md)
          vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#FF6A6A", bold = true }) -- Títulos # (rojo brillante)
          vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#FF8C8C", bold = true }) -- Títulos ## (rojo más suave)
          vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#A4B9EF" }) -- Viñetas (azul suave)
          vim.api.nvim_set_hl(0, "@markup.strong.markdown", { fg = "#FFD700", bold = true }) -- Texto en negrita (amarillo dorado)
          -- Lua (para archivos de configuración)
          vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#FF79C6" }) -- Palabras clave (rosa brillante)
          vim.api.nvim_set_hl(0, "@string.lua", { fg = "#BD93F9" }) -- Strings (púrpura suave)
          vim.api.nvim_set_hl(0, "@comment.lua", { fg = "#6272A4", italic = true }) -- Comentarios (gris azulado, cursiva)
          -- General
          vim.api.nvim_set_hl(0, "@constant", { fg = "#FFB86C" }) -- Constantes (naranja suave)
          vim.api.nvim_set_hl(0, "@function", { fg = "#8BE9FD" }) -- Funciones (cian brillante)
        end,
      },
    -- Plugin 6: nvim-Telescope
    {
      "nvim-telescope/telescope.nvim",
      tag = '0.1.5',
      dependencies = { 'nvim-lua/plenary.nvim' },
      cmd = "Telescope",
      keys = { { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" } },
      config = function()
        require('telescope').setup{}
      end
    },


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
        vim.keymap.set("n", "<leader>.", "<cmd>Markview splitOpen<cr>", { noremap = true, silent = false, desc = "Markview: Open Split Preview" })
        vim.keymap.set("n", "<leader>,,", "<cmd>Markview splitClose<cr>", { noremap = true, silent = false, desc = "Markview: Close Split Preview" })
      end,
    },

    -- Plugin 8: Integración con LSP (nvim-lspconfig)
    {
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local lspconfig = require("lspconfig")

        -- TypeScript/JavaScript LSP moderno
        lspconfig.tsserver = nil -- asegúrate de limpiarlo si ya existe
        lspconfig.ts_ls.setup({
          filetypes = {
            "javascript", "javascriptreact",
            "typescript", "typescriptreact", "tsx",
          },
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
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

     -- Autocompletion engine
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- LSP source for nvim-cmp
      "hrsh7th/cmp-nvim-lsp",

      -- Buffer completions
      "hrsh7th/cmp-buffer",

      -- Path completions
      "hrsh7th/cmp-path",

      -- Command-line completions
      "hrsh7th/cmp-cmdline",

      -- Snippet engine
      "L3MON4D3/LuaSnip",

      -- Snippet completions
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
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- Required for correct capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Override default LSP capabilities (include this in your lspconfig setup)
      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        cmd = { "typescript-language-server", "--stdio" },
        root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx" },
      })
    end,
  },


       -- Plugin 9: Integración con Git (gitsigns) - Configuración MÍNIMA
       {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" }, -- Eventos para cargar el plugin
        opts = { -- Usar 'opts' para pasar la configuración directamente al setup del plugin
        signs = {
          add          = { text = "➕" },   -- Línea añadida
          change       = { text = "📝" },   -- Línea modificada
          delete       = { text = "❌" },   -- Línea eliminada
          topdelete    = { text = "🗑️" },  -- Eliminada desde el inicio del archivo
          changedelete = { text = "✂️" },   -- Línea modificada y borrada
          untracked    = { text = "🔍" },   -- Línea no rastreada

        },
          signcolumn = true, -- Mostrar columna de signos
        },
      },

      -- -- Plugin 10: Guías de indentación
{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = function()
  -- Define los highlights antes de configurar el plugin
  vim.api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#444444" }) -- Color gris oscuro para las guías
  vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#FF5555" }) -- Color rojo para el bloque actual
  return {
    indent = {
      char = "│", -- Usa un carácter más estilizado
      highlight = "IndentBlanklineChar", -- Resalta las guías con un color
    },
    scope = {
      enabled = true, -- Habilita el resaltado del bloque actual
      show_start = true, -- Muestra una línea al inicio del bloque
      show_end = true, -- Muestra una línea al final del bloque
      highlight = "IndentBlanklineContextChar", -- Color diferente para el bloque actual
    },
    exclude = {
      filetypes = { "help", "NvimTree", "markdown" }, -- No mostrar en estos tipos de archivo
    },
  }
end },

    {
      'nvim-lua/plenary.nvim',
      lazy = true,
    },
  },
})
