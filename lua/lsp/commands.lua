local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
  return
end

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

vim.api.nvim_create_user_command(
  'BuildAndRun',
  function()
    local buf = vim.api.nvim_get_current_buf() 
    local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
    local filepath = vim.api.nvim_buf_get_name(0)
    local dirpath = filepath:match("(.*/)")
    local filename = filepath:gsub("(.*/)", ""):match("(.+)%..+")
    vim.api.nvim_command(':! tmux new-window -t 2 -n "Run" -d &>/dev/null')
    if filetype == "javascript" or filetype == "typescript"  or filetype == "javascriptreact" or filetype == "typescriptreact" then
     vim.api.nvim_command(':! tmux send-keys -t :2 "npm start" C-m')
    end
    if filetype == "plantuml" then
      vim.api.nvim_command(':! tmux send-keys -t :2 "cd ' .. dirpath .. ' && plantuml *.plantuml" C-m')
      vim.api.nvim_command(':! tmux send-keys -t :2 "open ' .. filename .. '.png" C-m')
    end
    if filetype == "tex" then
     vim.api.nvim_command(':! tmux send-keys -t :2 "cd ' ..
       dirpath .. ' && mkdir -p out && pdflatex -shell-escape -output-directory=out ' .. filename .. '.tex && biber --output-directory=out ' .. filename .. ' && pdflatex -shell-escape -output-directory=out ' .. filename .. '.tex" C-m')
     vim.api.nvim_command(':! tmux send-keys -t :2 "pgrep zathura || zathura ./out/' .. filename .. '.pdf &" C-m')
    end
    if filetype == "python" then
     vim.api.nvim_command(':! tmux send-keys -t :2 "cd ' .. dirpath .. ' && python3 '.. filepath .. '" C-m')
    end
    if filetype == "c" then
     vim.api.nvim_command(':! tmux send-keys -t :2 "cd ' .. dirpath .. ' && gcc ' .. filepath .. ' && ./a.out" C-m')
    end
    if filetype == "java" then
     vim.api.nvim_command(':! tmux send-keys -t :2 "mvn -q clean compile exec:java" C-m')
    end
  end,
  {}
)

vim.api.nvim_create_user_command(
  'Test',
  function()
    local buf = vim.api.nvim_get_current_buf() 
    local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
    vim.api.nvim_command(':! tmux new-window -t 3 -n "Test" -d &>/dev/null')
    if filetype == "javascript" then
     vim.api.nvim_command(':! tmux send-keys -t :3 "npm test" C-m')
    end
    if filetype == "java" then
     vim.api.nvim_command(':! tmux send-keys -t :3 "mvn -q test" C-m')
    end
  end,
  {}
)

local mappings = {
  l = {
    name = "LSP",
    b = { '<cmd>BuildAndRun<cr><cr>', "Build and Run" },
    t = { '<cmd>Test<cr><cr>', "Test" },
  },
}

whichkey.register(mappings, opts)
