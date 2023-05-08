-- local filepath = vim.api.nvim_buf_get_name(0):gsub(" ", "\\ ");


-- vim.api.nvim_command(':! echo ' ..filepath)
-- vim.api.nvim_command(':10TermExec open=0 cmd="zathura ' .. filepath .. '"')


vim.api.nvim_create_user_command(
  'PdfOpen',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local filename = filepath:sub(1, -5)
    vim.api.nvim_command(':! cd ' ..
      dirpath .. ' && zathura ' .. filename .. '.pdf &')
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
    name = "Pdf",
    o = { "<Cmd>PdfOpen<CR><CR>", "Open" },
  },
}

which_key.register(mappings, opts)

vim.api.nvim_command("PdfOpen")
