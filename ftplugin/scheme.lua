-- require'lspconfig'.racket_langserver.setup{}
local opts = {}
require("lvim.lsp.manager").setup("racket_langserver", opts)
-- require'lspconfig'.racket_langserver.try_add()

vim.api.nvim_create_user_command(
  'RacketRun',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local command = 'racket ' .. filepath
    vim.api.nvim_command(':9TermExec cmd="cd ' .. dirpath .. ' && ' .. command .. '" <cr>')
  end,
  {}
)

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  j = {
    name = "Racket",
    b = { "<Cmd>RacketRun<CR>", "Run" },
  },
}

which_key.register(mappings, opts)
