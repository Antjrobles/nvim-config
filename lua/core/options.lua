vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.relativenumber = false
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8 -- Mantiene el cursor alejado de los bordes
vim.opt.ignorecase = true -- Ignora mayúsculas/minúsculas al buscar
vim.opt.smartcase = true -- Ignora mayúsculas/minúsculas al buscar, pero si hay mayúsculas, las considera
vim.opt.incsearch = true -- Resalta coincidencias mientras se escribe
vim.opt.hlsearch = true -- Resalta todas las coincidencias de búsqueda
vim.opt.splitbelow = true -- Abre nuevas ventanas en la parte inferior



vim.filetype.add({ extension = { md = "markdown" } })

vim.opt.cursorline = true   -- Resalta la línea donde está el cursor
vim.opt.cursorcolumn = true -- Resalta la columna donde está el cursor

vim.opt.list = true          -- Activa la visualización de caracteres especiales
vim.opt.listchars = {
  tab = '▸ ',              -- Carácter para tabuladores (prueba '→ ', '» ')
  trail = '·',             -- Carácter para espacios al final de línea
  extends = '❯',           -- Carácter para líneas que continúan más allá del borde de la pantalla (si wrap está off)
  precedes = '❮',          -- Carácter para líneas que empiezan antes del borde (si wrap está off)
  nbsp = '␣',              -- Carácter para espacios no separables
  -- eol = '↵',            -- Descomenta si quieres ver un símbolo al final de cada línea
}
vim.opt.smoothscroll = true -- (Neovim 0.9+) Intenta hacer el scroll más suave.

-- >>> SECCIÓN DEL CURSOR CORREGIDA Y MEJORADA <<<
vim.opt.guicursor = table.concat({
  "n-v-c:block-Cursor-blinkwait300-blinkon200-blinkoff150",
  "i-ci:ver25-Cursor-blinkwait300-blinkon200-blinkoff150",
  "r-cr:hor20-Cursor-blinkwait300-blinkon200-blinkoff150",
}, ",")

-- 2. Establecer el color del cursor (amarillo)
-- Esta es la forma más robusta para asegurar que tu personalización se aplique DESPUÉS del tema.
local cursor_augroup = vim.api.nvim_create_augroup("MyCursorSettings", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*", -- Para cualquier colorscheme
  group = cursor_augroup,
  callback = function()
    -- Cursor principal (bloque)
    vim.api.nvim_set_hl(0, "Cursor", { fg = "black", bg = "yellow", bold = true })
  end,
  desc = "Apply custom cursor highlight after colorscheme loads"
})
-- >>> FIN DE LA SECCIÓN DEL CURSOR <<<

-- >>> FUENTE PARA NEOVIDE <<<
if vim.g.neovide then
  vim.opt.guifont = "Hack Nerd Font:h14" -- ← CAMBIA esto por la fuente exacta que tengas instalada
end

-- >>> FONDO TRANSPARENTE <<<
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })