-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Cambiar modo a Normal con 'jk' o 'kj' en modo Insertar
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

-- GUARDAR Y SALIR
map("n", "<Leader>w", ":w<CR>", { desc = "Guardar archivo" }) -- Guardar archivo (Espacio + w)
map("n", "<Leader>wq", ":wq<CR>", { desc = "Guardar y Salir" })  -- Guardar y Salir (Espacio + w + q)
map("n", "<Leader>q", ":q!<CR>", { desc = "Salir sin guardar" }) -- Salir sin guardar

-- BUFFERS
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
map("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "Cerrar buffer actual" })

-- AVANTE


-- Navegación entre ventanas divididas (splits)
map("n", "<C-h>", "<C-w>h", { desc = "Mover a ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Mover a ventana de abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Mover a ventana de arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Mover a ventana derecha" })

-- Mover líneas seleccionadas arriba/abajo en modo Visual
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Mover línea(s) abajo" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Mover línea(s) arriba" })

-- Abrir/cerrar explorador de archivos: <Leader>e (Espacio + e)
map("n", "<Leader>e", ":NvimTreeToggle<CR>", { desc = "Abrir/cerrar explorador de archivos" })

-- Abrir ventana a la derecha
map("n", "<Leader>v", ":vsplit<CR>", {desc = "Abrir/cerrar ventana vertical a la derecha"})


-- Como hacer los comentarios con TODO-Comments:
-- TODO: Cambiar el color de los comentarios TODO
-- HACK: Cambiar el color de los comentarios HACK
-- FIX: Cambiar el color de los comentarios FIX
-- WARN: Cambiar el color de los comentarios WARN

-- Git
map("n", "<Leader>gg", ":Git<CR>", { desc = "Abrir Git" }) -- Abre la interfaz de Git
map("n", "<Leader>gs", ":Git status<CR>", { desc = "Hacer commit" }) -- Hacer status
map("n", "<Leader>ga", ":Git add .<CR>", { desc = "Hacer diff" }) -- Hacer add
map("n", "<Leader>gc", ":Git commit<CR>", { desc = "Hacer commit" }) -- Hacer commit
map("n", "<Leader>gp", ":Git push<CR>", { desc = "Hacer push" }) -- Hacer push
map("n", "<Leader>gpu", ":Git pull<CR>", { desc = "Hacer pull" }) -- Hacer pull
map("n", "<Leader>gf", ":Git fetch<CR>", { desc = "Hacer diff" }) -- Hacer fetch
map("n", "<Leader>gd", ":Git diff<CR>", { desc = "Hacer diff" }) -- Hacer diff
map("n", "<Leader>gl", ":Git log<CR>", { desc = "Hacer log" }) -- Hacer log

-- Copiar y pegar al portapapeles del sistema
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to system clipboard", noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard", noremap = true, silent = true })
vim.keymap.set("n", "<leader>t", ":echo 'Keymaps cargados!'<CR>", { desc = "Test Keymap", noremap = true, silent = true })


-- MCP-HUB
map("n", "<Leader>mc", ":MCPHub<CR>", { desc = "Abrir MCP-HUB" }) -- Abre la interfaz de MCP-HUB
