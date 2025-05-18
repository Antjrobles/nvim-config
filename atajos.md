# Neovim Cheatsheet - Atajos Configurados (May 13, 2025)

## General

- Espacio + w: Guardar archivo
- Espacio + q: Cerrar archivo o Neovim

## ToggleTerm

- Espacio + tf: Abre terminal
- Control + \: Abre terminal
- Espacio + tv: Abre terminal vertical
- Espacio + th: Abre terminal horizontal
- Espacio + tt: Abre terminal en nueva ventana
- Espacio + g: Abre LazyGit

## Ventanas

- Espacio + v: Abre ventana nueva vertical

## Buffers

- :ls Muestra buffers abiertos
- Tab: Cambia entre buffers abiertos
- Tab + Shift: Cambia entre buffers abiertos en orden inverso

## nvim-tree (Explorador de archivos)

- Espacio + e: Abrir/cerrar explorador
- u: Sube un nivel de carpetas

## Copilot

- Ctrl + j: Aceptar sugerencia

## Codeium

- Ctrl + g: Aceptar sugerencia

## Avante

- Espacio + a + a: Abre Avante
- Espacio + a + e: Edit
- Espacio + a + r: Refresh
- Espacio + a + c: Clear
- Espacio + a + f: switch sidebar focus
- Para añadir un archivo al contexto:
  - Desde el chat @ y seleccionar file. Se abrirá un explorador de archivos y seleccionas el archivo que quieres añadir al contexto.

## Git

- Espacio + g + g: Abre GitHub
- Espacio + g + b: Abre GitHub en el navegador
- Espacio + g + s: Git status
- Espacio + g + a: Git add .
- Espacio + g + c: Git commit
- Espacio + g + p: Git push
- Espacio + g + p + u : Git pull
- Espacio + g + f: Git fetch
- Espacio + g + d: Git diff
- Espacio + g + l: Git log

## Comentarios. Linea actual y bloque

- En modo normal:

  - En la línea actual: gcc

- En modo visual(v):
  - Seleccionar bloque con las flechas arriba y abajo:
    - Bloque: gc
    - Para descomentar: gc pero situando el cursor encima del bloque y debajo de la línea que se quiere descomentar

## nvim-telescope (Búsqueda y navegación)

- Espacio + f + f: Buscar archivos
- Espacio + f + g: Buscar texto en archivos
- Espacio + f + b: Mostrar buffers abiertos
- Espacio + f + h: Buscar en ayuda de Neovim
- Espacio + f + c: Buscar comandos de Neovim
- Espacio + f + r: Mostrar archivos recientes
- Espacio + f + t: Buscar en árbol de sintaxis
- Espacio + f + /: Buscar en buffer actual
- Espacio + f + \*\*\* (Espacio + f + Shift + 8): Buscar palabra bajo el cursor
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

## Twilight

- :Twilight activa sobreado de porcion de codigo no seleccioando

## Notas

- `<leader>` está configurado como la tecla Espacio.
- Asegúrate de que `ts_ls` esté activo con `:LspInfo`.
