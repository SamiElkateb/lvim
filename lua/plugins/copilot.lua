local copilot_status, copilot = pcall(require, "copilot")
if not copilot_status then
  return
end

local copilot_suggestion_status, copilot_suggestion = pcall(require, "copilot.suggestion")
if not copilot_suggestion_status then
  return
end

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
  i = {
    name = "Copilot",
    h = {  function() copilot_suggestion.is_visible() end, "Is visible" },
    t = {  function() copilot_suggestion.toggle_auto_trigger() end, "Toggle" },
    j = {  function() copilot_suggestion.toggle_auto_trigger() end, "Next" },
    k = {  function() copilot_suggestion.toggle_auto_trigger() end, "Prev" },
  },
}
whichkey.register(mappings, opts)

-- require("copilot.suggestion").is_visible()
-- require("copilot.suggestion").accept(modifier)
-- require("copilot.suggestion").accept_word()
-- require("copilot.suggestion").accept_line()
-- require("copilot.suggestion").next()
-- require("copilot.suggestion").prev()
-- require("copilot.suggestion").dismiss()
-- require("copilot.suggestion").toggle_auto_trigger()

-- copilot_suggestion


vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#83a598" })
copilot.setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})
