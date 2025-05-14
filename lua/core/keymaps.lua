-- ~/.config/nvim/lua/core/keymaps.lua

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Cambiar modo a Normal con 'jk' o 'kj' en modo Insertar
map("i", "jk", "<ESC>", opts)
map("i", "kj", "<ESC>", opts)

-- Guardar archivo: <Leader>w (Espacio + w)
map("n", "<Leader>w", ":w<CR>", { desc = "Guardar archivo" })

-- Guardar y salir: <Leader>wq (Espacio + w + q)
map("n", "<Leader>wq", ":wq<CR>", { desc = "Guardar y Salir" })

-- Salir sin guardar: <Leader>q (Espacio + q)
map("n", "<Leader>q", ":q!<CR>", { desc = "Salir sin guardar" })

-- Cerrar el buffer (archivo) actual: <Leader>c (Espacio + c)
map("n", "<Leader>c", ":bdelete<CR>", { desc = "Cerrar buffer actual" })

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

