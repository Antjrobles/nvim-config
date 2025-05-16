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
    -- Incluir plugins adicionales desde extra.lua
    { import = "plugins.more_plugins" },

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
          on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            api.config.mappings.default_on_attach(bufnr)
            vim.keymap.set("n", "u", api.tree.change_root_to_parent, {
              desc = "nvim-tree: Dir Up",
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true,
            })
          end,
        })
        vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "#000000", fg = "#CBCCC6" })
        vim.api.nvim_set_hl(0, "NvimTreeCursorLine", { bg = "#334455" })
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#73BFFA" })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = "#A4B9EF" })
        vim.api.nvim_set_hl(0, "NvimTreeFileDirty", { fg = "#FF6A6A" })
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
            theme = "ayu_dark",
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
            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "json",
            "yaml",
            "dockerfile",
            "bash",
            "go",
            "rust",
            "python",
            "php",
            "c_sharp",
            "java",
            "kotlin",
            "swift",
            "sql",
          },
          highlight = { enable = true },
          indent = { enable = true },
          auto_install = true,
        })
        vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#FF6A6A", bold = true })
        vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#FF8C8C", bold = true })
        vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#A4B9EF" })
        vim.api.nvim_set_hl(0, "@markup.strong.markdown", { fg = "#FFD700", bold = true })
        vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#FF79C6" })
        vim.api.nvim_set_hl(0, "@string.lua", { fg = "#BD93F9" })
        vim.api.nvim_set_hl(0, "@comment.lua", { fg = "#6272A4", italic = true })
        vim.api.nvim_set_hl(0, "@constant", { fg = "#FFB86C" })
        vim.api.nvim_set_hl(0, "@function", { fg = "#8BE9FD" })
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
        lspconfig.tsserver = nil
        lspconfig.ts_ls.setup({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "tsx",
          },
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
          single_file_support = false,
        })
        lspconfig.pyright.setup({})
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
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
            { name = "path" },
          }),
        })
        local capabilities_original_cmp = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig").ts_ls.setup({
          capabilities = capabilities_original_cmp,
          cmd = { "typescript-language-server", "--stdio" },
          root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json", ".git"),
          filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx" },
        })
      end,
    },
    -- Plugin 10: gitsigns.nvim (Indicadores de cambios Git en la columna de signos)
    {
      "lewis6991/gitsigns.nvim",
      event = { "BufReadPost", "BufNewFile" },
      opts = {
        signs = {
          add = { text = "➕" },
          change = { text = "📝" },
          delete = { text = "❌" },
          topdelete = { text = "🗑️" },
          changedelete = { text = "✂️" },
          untracked = { text = "🔍" },
        },
        signcolumn = true,
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
      cmd = "Mason",
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
      config = function()
        local capabilities_for_mason = require("cmp_nvim_lsp").default_capabilities()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "html",
            "cssls",
            "jsonls",
            "yamlls",
            "dockerls",
            "bashls",
            "rust_analyzer",
            "intelephense",
            "marksman",
            "tailwindcss",
            "eslint",
            "sqlls",
            "jdtls",
          },
          handlers = {
            function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = capabilities_for_mason,
              })
            end,
          },
        })
      end,
    },
    -- Plugin 14: minimap.vim (Muestra un minimapa del código al estilo VSCode)
    {
      "wfxr/minimap.vim",
      config = function()
        vim.g.minimap_width = 10
        vim.g.minimap_auto_start = 1
        vim.g.minimap_auto_start_win_enter = 1
        vim.keymap.set("n", "<Leader>m", ":MinimapToggle<CR>", { noremap = true, silent = true, desc = "Toggle Minimap" })
      end,
    },
    -- Plugin 15: copilot.vim (Asistente de autocompletado basado en IA de GitHub, comentado)
    -- {
    --   "github/copilot.vim",
    --   config = function()
    --     vim.g.copilot_no_tab_map = true
    --     vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    --   end,
    -- },
    -- Plugin 16: codeium.vim (Asistente de autocompletado basado en IA)
    {
      "Exafunction/codeium.vim",
      config = function()
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
      version = false,
      config = function()
        require("mini.indentscope").setup({
          symbol = "┊",
          options = { try_as_border = true },
        })
        require("mini.statusline").setup({
          use_icons = true,
        })
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
            char = "│",
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
            alpha = 0.80,
            inactive = true,
          },
          context = 10,
          treesitter = true,
        })
      end,
    },
    -- Plugin 21: bufferline.nvim (Barra de buffers visualmente mejorada)
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
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
        vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Siguiente buffer" })
        vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Anterior buffer" })
      end,
    },
    -- Plugin 22: conform.nvim (Formateo automático de archivos)
    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      config = function()
        require("conform").setup({
          formatters_by_ft = {
            lua = { "stylua" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            tsx = { "prettier" },
            javascript = { "prettier" },
            typescript = { "prettier" },
          },
          format_on_save = {
            timeout_ms = 500,
            lsp_fallback = true,
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
          signs = true,
          keywords = {
            FIX = { icon = " ", color = "error" },
            TODO = { icon = " ", color = "info" },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning" },
            PERF = { icon = " ", color = "hint" },
            NOTE = { icon = " ", color = "hint" },
          },
        })
      end,
    },
  },
})