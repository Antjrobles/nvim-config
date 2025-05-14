# Neovim Cheatsheet - Atajos Configurados (May 13, 2025)

## General

- Espacio + w: Guardar archivo
- Espacio + q: Cerrar archivo o Neovim

## nvim-tree (Explorador de archivos)

- Espacio + e: Abrir/cerrar explorador
- u: Sube un nivel de carpetas
 
## nvim-telescope (Búsqueda y navegación)

- Espacio + f + f: Buscar archivos
- Espacio + f + g: Buscar texto en archivos
- Espacio + f + b: Mostrar buffers abiertos
- Espacio + f + h: Buscar en ayuda de Neovim
- Espacio + f + c: Buscar comandos de Neovim
- Espacio + f + r: Mostrar archivos recientes
- Espacio + f + t: Buscar en árbol de sintaxis
- Espacio + f + /: Buscar en buffer actual
- Espacio + f + *** (Espacio + f + Shift + 8): Buscar palabra bajo el cursor
- Espacio + f + :: Historial de comandos
- Espacio + f + ?: Historial de búsqueda
- Espacio + f + Espacio: Reanudar última búsqueda
- Espacio + f + Tab: Mostrar buffers abiertos
- Espacio + f + Enter: Buscar archivos

## nvim-lspconfig (LSP - TypeScript)

- g + d: Ir a definición
- K: Mostrar información (hover)
- (Automático): Formato al guardar con Espacio + w

## nvim-cmp (Autocompletado)

- Control + l: Abrir menú de autocompletado
- Flecha Abajo: Seleccionar siguiente opción
- Flecha Arriba: Seleccionar opción anterior
- Enter: Confirmar selección
- Control + e: Cerrar menú
- Tab: Expandir snippets o siguiente opción
- Shift + Tab: Retroceder en snippets o opción anterior

## Markdown Preview

- Espacio + .: Abre preview del MD a la derecha
- Espaci + ,,: Cierra preview del MD

## MiniMap

- Espacio + m: Abre o cierra el MiniMap


## Notas

- `<leader>` está configurado como la tecla Espacio.
- Asegúrate de que `ts_ls` esté activo con `:LspInfo`.
