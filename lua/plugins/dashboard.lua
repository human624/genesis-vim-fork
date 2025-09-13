local function default_header()
    return {
        '', '', '',
        ' ██████╗ ███████╗███╗   ██╗███████╗███████╗██╗███████╗',
        '██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔════╝██║██╔════╝',
        '██║  ███╗█████╗  ██╔██╗ ██║█████╗  ███████╗██║███████╗',
        '██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ╚════██║██║╚════██║',
        '╚██████╔╝███████╗██║ ╚████║███████╗███████║██║███████║',
        ' ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚══════╝╚═╝╚══════╝',
        '', '', ''
    }
end

require('dashboard').setup {
    theme = 'doom',
    config = {
        header = default_header(),
        center = {
            {
                icon = '󰈞 ',
                icon_hl = 'Title',
                desc = 'Find files',
                desc_hl = 'String',
                key = 'f',
                keymap = 'SPC f f',
                key_hl = 'Number',
                action = ':Telescope find_files'
            }, {
				icon = '󰱾 ',
                icon_hl = 'Title',
                desc = 'Open recently',
                desc_hl = 'String',
                key = 'r',
                keymap = 'SPC f r',
                key_hl = 'Number',
                action = ':Telescope oldfiles'
            }, {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find text',
                desc_hl = 'String',
                key = 'w',
                keymap = 'SPC f w',
                key_hl = 'Number',
                action = ':Telescope live_grep'
            }, {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Git Braches',
                desc_hl = 'String',
                key = 'b',
                keymap = 'SPC g b',
                key_hl = 'Number',
                action = ':Telescope git_branches'
            }

        }
    }
}

-- ========== clean dashboard UI: hide editor chrome on dashboard, restore after ==========
do
  local saved = {}

  local function save_once()
    if saved._saved then return end
    saved._saved = true
    saved.laststatus = vim.o.laststatus
    saved.showtabline = vim.o.showtabline
    saved.cmdheight = vim.o.cmdheight
    saved.winbar = vim.o.winbar
    saved.number = vim.wo.number
    saved.relativenumber = vim.wo.relativenumber
    saved.signcolumn = vim.wo.signcolumn
    saved.cursorline = vim.wo.cursorline
  end

  local function hide_ui()
    save_once()
    vim.o.laststatus = 0
    vim.o.showtabline = 0
    pcall(function() vim.o.cmdheight = 0 end)
    vim.o.winbar = ""
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
    vim.wo.cursorline = false
  end

  local function restore_ui()
    if not saved._saved then return end
    vim.o.laststatus = saved.laststatus or 2
    vim.o.showtabline = saved.showtabline or 2
    vim.o.cmdheight = saved.cmdheight or 1
    vim.o.winbar = saved.winbar or ""
    vim.wo.number = saved.number or false
    vim.wo.relativenumber = saved.relativenumber or false
    vim.wo.signcolumn = saved.signcolumn or "auto"
    vim.wo.cursorline = saved.cursorline or false
    saved = {}
  end

  vim.api.nvim_create_autocmd({ "User", "FileType" }, {
    pattern = { "AlphaReady", "alpha", "dashboard", "startify" },
    callback = function() vim.schedule(hide_ui) end,
  })

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 then
        vim.schedule(function()
          local ft = vim.bo.filetype
          if ft == "alpha" or ft == "dashboard" or ft == "startify" then
            hide_ui()
          end
        end)
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = function()
      local ft = vim.bo.filetype
      if ft ~= "alpha" and ft ~= "dashboard" and ft ~= "startify" then
        restore_ui()
      end
    end,
  })
end
-- =======================================================================================
