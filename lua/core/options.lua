vim.opt.autoindent = true          -- Habilita la indentación automática
vim.opt.autoread = true            -- Recarga archivos modificados externamente
vim.opt.backspace = "indent,eol,start" -- Permite retroceso en indentaciones, fin de línea y inicio
vim.opt.backup = false             -- Deshabilita archivos de respaldo
vim.opt.breakindent = true         -- Indenta líneas envueltas visualmente
vim.opt.colorcolumn = "120"        -- Marca la columna 80 para límite visual
vim.opt.clipboard = "unnamedplus"  -- Usa el portapapeles del sistema
vim.opt.cmdheight = 1              -- Altura de la línea de comandos
vim.opt.completeopt = "menu,menuone,noselect" -- Opciones de autocompletado
vim.opt.conceallevel = 0           -- Muestra todo el texto sin ocultar (útil para markdown)
vim.opt.cursorcolumn = true        -- Resalta la columna donde está el cursor
vim.opt.cursorline = true          -- Resalta la línea donde está el cursor
vim.opt.encoding = "utf-8"         -- Usa codificación UTF-8
vim.opt.expandtab = true           -- Convierte tabs en espacios
vim.filetype.add({ extension = { md = "markdown" } })  -- Añade soporte para archivos .md como markdown
vim.opt.fillchars = "eob: "        -- Carácter para líneas vacías al final del buffer
vim.opt.formatoptions = "croql"    -- Opciones de formato (c: comentarios, r: retorno auto, etc.)
vim.opt.hidden = true              -- Permite cambiar de buffer sin guardar
vim.opt.hlsearch = true            -- Resalta todas las coincidencias de búsqueda
vim.opt.ignorecase = true          -- Ignora mayúsculas/minúsculas al buscar
vim.opt.incsearch = true           -- Búsqueda incremental mientras escribes y resalta coincidencias
vim.opt.linebreak = true           -- Evita dividir palabras al envolver líneas
vim.opt.list = true                -- Activa la visualización de caracteres especiales
vim.opt.mouse = "a"                -- Habilita el mouse en todas las modalidades
vim.opt.number = true              -- Muestra números de línea
vim.opt.numberwidth = 4            -- Ancho de la columna de números de línea
vim.opt.pumheight = 10             -- Altura máxima del menú de autocompletado
vim.opt.relativenumber = false      -- Muestra números relativos (false para números absolutos)
vim.opt.ruler = true               -- Muestra la posición del cursor en la línea y columna
vim.opt.scrolloff = 8              -- Mantiene el cursor alejado de los bordes
vim.opt.shiftwidth = 2             -- Número de espacios para la indentación
vim.opt.showcmd = true             -- Muestra comandos parciales en la esquina inferior
vim.opt.showtabline = 2            -- Siempre muestra la barra de pestañas
vim.opt.sidescrolloff = 8          -- Mantiene el cursor alejado de los bordes
vim.opt.signcolumn = "yes"         -- Siempre muestra la columna de signos (para todo-comments.nvim)
vim.opt.spell = false              -- Deshabilita corrección ortográfica
vim.opt.splitright = true          -- Abre splits a la derecha
vim.opt.smartcase = true           -- Ignora mayúsculas/minúsculas al buscar, pero si hay mayúsculas, las considera
vim.opt.smartindent = true         -- Indentación inteligente para lenguajes
vim.opt.smoothscroll = true        -- (Neovim 0.9+) Intenta hacer el scroll más suave.
vim.opt.softtabstop = 2            -- Número de espacios que representa un tab en edición
vim.opt.swapfile = false           -- Deshabilita archivos de intercambio
vim.o.timeout = true
vim.o.timeoutlen = 1000 -- Aumentar a 1 segundo (ajusta si necesitas más)
vim.opt.tabstop = 4                -- Número de espacios que representa un tab al mostrar
vim.opt.termguicolors = true       -- Habilita colores de 24 bits (para temas modernos)
vim.opt.undofile = true            -- Habilita archivo de deshacer persistente
vim.opt.wildmenu = true            -- Habilita menú de autocompletado en la línea de comandos
vim.opt.wrap = false               -- Deshabilita el ajuste automático de líneas
vim.opt.wrapscan = true           -- Permite buscar desde el final al inicio del archivo



-- Habilitar líneas guía de indentación
vim.opt.listchars = {
  tab = '▸ ',              -- Carácter para tabuladores (prueba '→ ', '» ')
  trail = '·',             -- Carácter para espacios al final de línea
  extends = '❯',           -- Carácter para líneas que continúan más allá del borde de la pantalla (si wrap está off)
  precedes = '❮',          -- Carácter para líneas que empiezan antes del borde (si wrap está off)
  nbsp = '␣',              -- Carácter para espacios no separables
  -- eol = '↵',            -- Descomenta si quieres ver un símbolo al final de cada línea
}

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
  vim.opt.guifont = "JetBrainsMono Nerd Font:h14" -- ← CAMBIA esto por la fuente exacta que tengas instalada
end

-- >>> FONDO TRANSPARENTE <<<
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })



