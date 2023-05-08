lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
-- lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

local api_status_ok, api = pcall(require, "nvim-tree.api")
if not api_status_ok then
  return
end

local lib_status_ok, lib = pcall(require, "nvim-tree.lib")
if not lib_status_ok then
  return
end

-- Adds the file under the cursor to the staging area
local git_add = function()
  local node = lib.get_node_at_cursor()
  local gs = node.git_status.file
  if gs == nil then
    gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
         or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
  end
  if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
    vim.cmd("silent !git add " .. node.absolute_path)
  elseif gs == "M " or gs == "A " then
    vim.cmd("silent !git restore --staged " .. node.absolute_path)
  end
  api.tree.reload()
end

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'ga', git_add, opts('git toggle'))
  vim.keymap.set('n', '-', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '|', api.node.open.vertical, opts('Open: Vertical Split'))
end

lvim.builtin.nvimtree.setup.on_attach = on_attach
