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
