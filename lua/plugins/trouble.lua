-- Trouble
require("trouble").setup {
  position = "bottom",          -- position: bottom, top, left, right
  height = 10,                  -- height for top/bottom
  width = 50,                   -- width for left/right
  icons = true,                 -- use devicons
  mode = "workspace_diagnostics", -- default mode
  fold_open = "",              -- icon for open folds
  fold_closed = "",            -- icon for closed folds
  group = true,                  -- group results by file
  padding = true,                -- extra line on top
  action_keys = {                -- key mappings
      close = "q",
      cancel = "<esc>",
      refresh = "r",
      jump = {"<cr>", "<tab>"},
      open_split = { "<c-x>" },
      open_vsplit = { "<c-v>" },
      open_tab = { "<c-t>" },
      jump_close = {"o"},
      toggle_mode = "m",
      toggle_preview = "P",
      hover = "K",
      preview = "p",
      close_folds = {"zM", "zm"},
      open_folds = {"zR", "zr"},
      toggle_fold = {"zA", "za"},
      previous = "k",
      next = "j"
  },
  indent_lines = true,           -- show indent guide
  auto_open = false,             -- open list automatically
  auto_close = false,            -- close list automatically
  auto_preview = true,           -- preview diagnostic location
  auto_fold = false,             -- fold files on creation
  auto_jump = {"lsp_definitions"}, -- jump if single result
  signs = {                      -- diagnostic icons
      error = "",
      warning = "",
      hint = "󰋗",
      information = "",
      other = ""
  },
  use_lsp_diagnostic_signs = false -- use LSP client signs
}
