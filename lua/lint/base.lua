local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pylama", extra_args = { "-m=200" }, filetypes = { "python" } },
}

