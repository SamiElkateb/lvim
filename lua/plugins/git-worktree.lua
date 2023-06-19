local gitworktree_status, gitworktree = pcall(require, "git-worktree")
if not gitworktree_status then
  return
end

gitworktree.setup()

local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
  return
end

local telescope_status_ok, telescope = pcall(require, "telescope")
if not telescope_status_ok then
  return
end

telescope.load_extension("git_worktree")

local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local mappings = {
  g = {
    name = "Git",
    W = { function() telescope.extensions.git_worktree.create_git_worktree() end, "Create worktree" },
    w = { function() telescope.extensions.git_worktree.git_worktrees() end, "Switch Worktree" },
  },
}

whichkey.register(mappings, opts)

local projectconfig_status, projectconfig = pcall(require, "helpers.projectconfig")
if not projectconfig_status then
  return
end


gitworktree.on_tree_change(function(op, metadata)
  if op == gitworktree.Operations.Switch then
    print("Switched from " .. metadata.prev_path .. " to " .. metadata.path)
    -- local prev_config = projectconfig.get_config_for(metadata.prev_path)
    local curr_config = projectconfig.get_config_for(metadata.path)
    local worktree_switch_destination_cmd = curr_config.worktree_switch_destination_cmd
    vim.api.nvim_command(':! cd ' .. metadata.path .. ' &&  ' .. worktree_switch_destination_cmd .. '<cr>')
  end
end)
