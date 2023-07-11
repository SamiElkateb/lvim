local chatgpt_status, chatgpt = pcall(require, "chatgpt)")
if not chatgpt_status then
  return
end

chatgpt.setup({
  api_key_cmd = "ansible-vault view " .. vim.env.HOME .. "/.vault/openai",
  actions_paths = {},
  options = {

    actions_paths = {
      vim.env.HOME .. "/.config/lvim/options/chatgpt.json",
    },

  }
})
