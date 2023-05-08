local mark_status, harpoon_mark = pcall(require, "harpoon.mark")
if not mark_status then
  return
end
local ui_status, harpoon_ui = pcall(require, "harpoon.ui")
if not ui_status then
  return
end

-- local whichkey_status_ok, whichkey = pcall(require, "which-key")
-- if not whichkey_status_ok then
--   return
-- end

-- local opts = {
--   mode = "n",
--   prefix = "<leader>",
--   buffer = nil,
--   silent = true,
--   noremap = true,
--   nowait = true,
-- }

-- local mappings = {
--   a = {
--     name = "Harpoon",
--     f = {  harpoon_mark.add_file, "Mark" },
--     a = {  harpoon_ui.toggle_quick_menu, "Toggle Menu" },
--     ["&"] = {  harpoon_ui.nav_file(1), "Mark 1" },
--     ["é"] = {  harpoon_ui.nav_file(2), "Mark 2" },
--     ["\""] = {  harpoon_ui.nav_file(3), "Mark 3" },
--     ["'"] = {  harpoon_ui.nav_file(4), "Mark 4" },
--   },
-- }



-- -- vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
-- -- vim.keymap.set("n", "<leader>aa", harpoon_ui.toggle_quick_menu)

-- whichkey.register(mappings, opts)

-- vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
-- vim.keymap.set("n", "<leader>aa", harpoon_ui.toggle_quick_menu)

-- -- vim.keymap.set("n", "<C-&>", function() harpoon_ui.nav_file(1) end)
-- -- vim.keymap.set("n", "<C-é>", function() harpoon_ui.nav_file(2) end)
-- -- vim.keymap.set("n", "<C-">", function() harpoon_ui.nav_file(3) end)
-- -- vim.keymap.set("n", "<C-'>", function() harpoon_ui.nav_file(4) end)
-- --
-- vim.keymap.set("n", "<leader>a&", function() harpoon_ui.nav_file(1) end)
-- vim.keymap.set("n", "<leader>aé", function() harpoon_ui.nav_file(2) end)
-- vim.keymap.set("n", "<leader>a\"", function() harpoon_ui.nav_file(3) end)
-- vim.keymap.set("n", "<leader>a'", function() harpoon_ui.nav_file(4) end)

local keymap = lvim.keys.normal_mode
keymap["<leader>a"] = harpoon_mark.add_file
keymap["<leader>aa"] = harpoon_ui.toggle_quick_menu
keymap["<leader>m"] = harpoon_ui.nav_file(1)
-- keymap["<leader>2"] = harpoon_ui.nav_file(2)
-- keymap["<leader>3"] = harpoon_ui.nav_file(3)
-- keymap["<leader>4'"] = harpoon_ui.nav_file(4)
