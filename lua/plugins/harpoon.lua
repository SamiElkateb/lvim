local whichkey_status_ok, whichkey = pcall(require, "which-key")
if not whichkey_status_ok then
  return
end

local mark_status, harpoon_mark = pcall(require, "harpoon.mark")
if not mark_status then
  return
end
local ui_status, harpoon_ui = pcall(require, "harpoon.ui")
if not ui_status then
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
  a = {
    name = "Harpoon",
    a = {  harpoon_mark.add_file, "Mark" },
    m = {  harpoon_ui.toggle_quick_menu, "Toggle Menu" },
    h = {  function() harpoon_ui.nav_file(1) end, "Mark 1" },
    j = {  function() harpoon_ui.nav_file(2) end, "Mark 2" },
    k = {  function() harpoon_ui.nav_file(3) end, "Mark 3" },
    l = {  function() harpoon_ui.nav_file(4) end, "Mark 4" },
  },
}
whichkey.register(mappings, opts)
