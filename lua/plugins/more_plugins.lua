return {
  -- Plugin 24: vim-fugitive (Integración avanzada con Git)
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gcommit", "Gdiffsplit" },
    -- Cargar en repositorios Git para evitar problemas
    cond = function()
      return vim.fn.isdirectory(".git") == 1
    end,
    config = function()
      -- Mapeos simples como respaldo (similares a <leader>m
    end,
  },
}