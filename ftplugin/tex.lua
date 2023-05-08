-- pdfcslatex -shell-escape test.tex


vim.api.nvim_create_user_command(
  'LaTexBuildAndRun',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local filename = filepath:gsub("(.*/)", ""):gsub(".tex$", "");
    -- vim.api.nvim_command(':! cd ' ..
    --   dirpath .. ' && pdfcslatex -shell-escape ' .. filename .. '.tex && rm -rf _minted-' .. filename .. ' && rm ' .. filename .. '.aux && rm ' .. filename ..'.log && zathura ' .. filename .. '.pdf &')
    -- pdflatex -shell-escape --file-line-error --synctex=1 rendu.tex
    vim.api.nvim_command(':! cd ' ..
      dirpath .. ' && pdflatex -shell-escape ' .. filename .. '.tex && zathura ' .. filename .. '.pdf &')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'LaTexBibBuildAndRun',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local filename = filepath:gsub("(.*/)", ""):gsub(".tex$", "");
    vim.api.nvim_command(':! cd ' ..
      dirpath .. ' && pdflatex -shell-escape ' .. filename .. '.tex && bibtex ' .. filename .. ' && pdflatex -shell-escape ' .. filename .. '.tex && zathura ' .. filename .. '.pdf &')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'LaTexBibLatexBuildAndRun',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local filename = filepath:gsub("(.*/)", ""):gsub(".tex$", "");
    vim.api.nvim_command(':! cd ' ..
      dirpath .. ' && pdflatex -shell-escape ' .. filename .. '.tex && biber ' .. filename .. ' && pdflatex -shell-escape ' .. filename .. '.tex && zathura ' .. filename .. '.pdf &')
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
    name = "LaTex",
    b = { "<Cmd>LaTexBibLatexBuildAndRun<CR><CR>", "Build with Bib and Open" },
    a = { "<Cmd>LaTexBibBuildAndRun<CR><CR>", "Build with Bib and Open" },
    l = { "<Cmd>LaTexBuildAndRun<CR><CR>", "Build and Open" },
  },
}

which_key.register(mappings, opts)
