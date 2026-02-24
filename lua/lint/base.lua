local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "pylama", extra_args = { "-m=200" }, filetypes = { "python" } },
  { command = "jsonlint", extra_args = { "-m=200" }, filetypes = { "json" } },
  -- ESLint for JavaScript/TypeScript
  { command = "eslint", 
    args = { "--stdin", "--stdin-filename", "$FILENAME", "--format", "json" },
    filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },
}



-- local null_ls_status_ok, null_ls = pcall(require, "null-ls")
-- if not null_ls_status_ok then
--   return
-- end

-- null_ls.setup({
--   sources = {
--     null_ls.builtins.diagnostics.eslint,    -- show ESLint errors/warnings
--     null_ls.builtins.code_actions.eslint,   -- enable ESLint code actions
--     null_ls.builtins.formatting.prettier,   -- optional: formatting
--   },
--   on_attach = on_attach,
-- })

