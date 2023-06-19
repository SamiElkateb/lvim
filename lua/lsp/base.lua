lvim.lsp.installer.setup.ensure_installed = {
  -- javascript
  "tsserver",
  "jsonls",
  "eslint",

  -- python
  "pyright",

  -- java
  "jdtls"
}
require('lsp.commands')

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
  return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
  -- keybind options
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- set keybinds
  keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- go to implementation
  keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
  keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions
  keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
  keymap.set("n", "<leader>lr", ":IncRename ", opts) -- smart rename

  keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references
  keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- got to declaration
  keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
  keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

  keymap.set("n", "<leader>lf", function ()
        vim.lsp.buf.format({
          filter = function(lsp_client)
            --  only use null-ls for formatting instead of lsp server
            return lsp_client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
  end)
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

-- configure godot
lspconfig["gdscript"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

