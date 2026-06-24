local lualine = require('lualine')

-- Display conditions
local conditions = {}
conditions.hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- Colors
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

-- LSP client cache
local function get_lsp_client()
  local msg = 'No Active LSP'
  local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if next(clients) == nil then
    return msg
  end
  for _, client in ipairs(clients) do
    local filetypes = client.config.filetypes
    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
      return client.name
    end
  end
  return msg
end

-- Left section
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
      color_error = { fg = colors.replace, bg = 'NONE' },
      color_warn  = { fg = colors.command, bg = 'NONE' },
      color_info  = { fg = colors.normal, bg = 'NONE' },
    },
    color = { bg = 'NONE' }
  },
}

-- Right section
local right = {
  {
    get_lsp_client,
    icon = "LSP:",
    color = { fg = '#5f87af', gui = 'bold', bg = 'NONE' },
  },
  { 'o:encoding', fmt = string.upper, cond = conditions.hide_in_width, color = { fg = colors.green, bg = 'NONE', gui = 'bold' } },
  { 'fileformat', fmt = string.upper, icons_enabled = false, color = { fg = colors.green, bg = 'NONE', gui = 'bold' } },
  { 'branch', icon = '', color = { fg = colors.visual, bg = 'NONE', gui = 'bold' } },
  { 'diff',
    symbols = { added = ' ', modified = ' ', removed = ' ' },
    diff_color = {
      added = { fg = colors.green, bg = 'NONE' },
      modified = { fg = colors.command, bg = 'NONE' },
      removed = { fg = colors.replace, bg = 'NONE' },
    },
    cond = conditions.hide_in_width,
  },
}

-- Lualine setup
lualine.setup({
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
    disabled_filetypes = { 'dashboard', 'NvimTree', 'toggleterm' }, -- Disable where not needed
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
