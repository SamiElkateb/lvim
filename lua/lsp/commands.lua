local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
  return
end

local projectconfig_status, projectconfig = pcall(require, "helpers.project-config")
if not projectconfig_status then
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
  'RunDev',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local curr_config = projectconfig.get_config_for(filepath)
    if curr_config.dev == '' then return end
    local dirpath = filepath:match("(.*/)")
    local path = curr_config.cmd_from_root and curr_config.path or dirpath
    vim.api.nvim_command(':! tmux new-window -t 2 -n "Dev" -d &>/dev/null')
    vim.api.nvim_command(':! tmux send-keys -t :2 "cd ' .. path .. ' &&' .. curr_config.dev .. '" C-m')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'RunInstall',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local curr_config = projectconfig.get_config_for(filepath)
    if curr_config.install == '' then return end
    local dirpath = filepath:match("(.*/)")
    local path = curr_config.cmd_from_root and curr_config.path or dirpath
    vim.api.nvim_command(':! tmux new-window -t 8 -n "Install" -d &>/dev/null')
    vim.api.nvim_command(':! tmux send-keys -t :8 "cd ' .. path .. ' &&' .. curr_config.install .. '" C-m')
  end,
  {}
)

vim.api.nvim_create_user_command(
  'RunTest',
  function()
    local filepath = vim.api.nvim_buf_get_name(0)
    local curr_config = projectconfig.get_config_for(filepath)
    if curr_config.test == '' then return end
    local dirpath = filepath:match("(.*/)")
    local path = curr_config.cmd_from_root and curr_config.path or dirpath
    vim.api.nvim_command(':! tmux new-window -t 3 -n "Test" -d &>/dev/null')
    vim.api.nvim_command(':! tmux send-keys -t :3 "cd ' .. path .. ' &&' .. curr_config.test .. '" C-m')
  end,
  {}
)

local mappings = {
  l = {
    name = "LSP",
    b = { '<cmd>RunDev<cr><cr>', "Run dev" },
    B = { '<cmd>RunInstall<cr><cr>', "Install" },
    t = { '<cmd>RunTest<cr><cr>', "Test" },
  },
}

whichkey.register(mappings, opts)
