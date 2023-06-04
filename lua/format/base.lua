-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
-- INSTALL JAVA FORMATTER
-- MacOs : brew install google-java-format
formatters.setup {
  { command = "google_java_format", filetypes = { "java" } },
  { command = "prettier",           filetypes = { "javascript" } },

  { command = "black", filetypes = { "python" } },
  { command = "isort", filetypes = { "python" } },
}

formatters.setup {
  { command = "raco_fmt", filetypes = { "scheme", "racket" } },
}
