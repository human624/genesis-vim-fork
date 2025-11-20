-- lualine_opt.lua

local lualine = require('lualine')

-- Условия для отображения
local conditions = {}
conditions.hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- Цвета
local colors = {
  normal  = '#83acff',
  insert  = '#c4e98e',
  visual  = '#c893eb',
  replace = '#f17279',
  command = '#ECBE7B',
  thm     = '#181825',
  magenta = '#7c6f64',
  green   = '#98be65',
}

-- Кэш LSP клиента
local lsp_client_name = "No Active LSP"
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local clients = vim.lsp.get_active_clients({bufnr = ev.buf})
    if next(clients) ~= nil then
      lsp_client_name = clients[1].name
    else
      lsp_client_name = "No Active LSP"
    end
  end,
})

-- Левая часть
local left = {
  { 'mode', color = function()
      local m = vim.fn.mode()
      local mode_color = colors.thm
      if m == 'n' then mode_color = colors.normal
      elseif m == 'i' then mode_color = colors.insert
      elseif m == 'v' or m == 'V' then mode_color = colors.visual
      elseif m == 'R' then mode_color = colors.replace
      elseif m == 'c' then mode_color = colors.command
      end
      return { fg = '#000000', bg = mode_color, gui = 'bold' }
    end
  },
  { 'filename', color = { fg = colors.magenta, bg = 'NONE' } },
  { 'location', color = { fg = colors.magenta, bg = 'NONE' } },
  { 'progress', color = { fg = colors.magenta, bg = 'NONE' } },
  {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
      color_error = { fg = colors.replace, bg = colors.thm },
      color_warn  = { fg = colors.command, bg = colors.thm },
      color_info  = { fg = colors.normal, bg = colors.thm },
    },
    color = { bg = colors.thm }
  },
}

-- Правая часть
local right = {
  {
    function() return lsp_client_name end,
    icon = "LSP:",
    color = { fg = '#5f87af', gui = 'bold', bg = 'NONE' },
  },
  { 'o:encoding', fmt = string.upper, cond = conditions.hide_in_width, color = { fg = colors.green, bg = colors.thm, gui = 'bold' } },
  { 'fileformat', fmt = string.upper, icons_enabled = false, color = { fg = colors.green, bg = colors.thm, gui = 'bold' } },
  { 'branch', icon = '', color = { fg = colors.visual, bg = colors.thm, gui = 'bold' } },
  { 'diff',
    symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
    diff_color = {
      added = { fg = colors.green, bg = colors.thm },
      modified = { fg = colors.command, bg = colors.thm },
      removed = { fg = colors.replace, bg = colors.thm },
    },
    cond = conditions.hide_in_width,
  },
}

-- Настройка Lualine
lualine.setup({
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = { 'dashboard', 'NvimTree', 'toggleterm' }, -- отключить там, где не нужен
  },
  sections = {
    lualine_a = left,
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = right,
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
})

