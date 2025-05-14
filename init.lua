-- ~/.config/nvim/init.lua


vim.g.mapleader = " " -- <--- NUEVA LÍNEA: Establece Espacio como tecla Líder

require("core.options")
require("core.keymaps")
require("plugins") -- Cargar plugins desde lua/plugins/init.lua
