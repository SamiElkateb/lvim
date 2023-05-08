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
    W = { function () telescope.extensions.git_worktree.create_git_worktree() end, "Create worktree" },
    w = { function () telescope.extensions.git_worktree.git_worktrees() end, "Switch Worktree" },
  },
}

whichkey.register(mappings, opts)
