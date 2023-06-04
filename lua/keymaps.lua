local keymap = lvim.keys.normal_mode
local insert_keymap = lvim.keys.insert_mode
local which_keymap = lvim.builtin.which_key.mappings

keymap["<C-s>"] = ":w<cr>"
insert_keymap["kj"] = "<Esc>"

-- Telescope --
keymap["<C-p>"] =
"<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>"

-- Dap --
-- which_keymap['d'] = {
--   name = 'Debug',
--   v = { ':DapSidebarToggle<cr>', "Sidebar Toggle" }
-- }
-- keymap["<leader>dv"] = ":DapSidebarToggle<cr>"

-- Buffer --
keymap["<S-l>"] = ":BufferLineCycleNext<CR>"
keymap["<S-h>"] = ":BufferLineCyclePrev<CR>"

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

local mappings = {
  s = {
    name = 'Search',
    P = { "<cmd>lua require'telescope'.extensions.projects.projects{}<CR>", "Projects" },
    n = { "<cmd>Telescope neoclip<CR>", "Clipboard" }
  },

  d = {
    name = 'Debug',
    T = { ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Condition" },
  },
}

whichkey.register(mappings, opts)
