require("colorizer").setup({
  filetypes = { "*" }, 
  buftypes = { "*" },
  options = {
    parsers = {
      css = true,
      names = { enable = true },
    },
  },
})
