local projectconfig_status, projectconfig = pcall(require, "helpers.projectconfig")
if not projectconfig_status then
  return
end

projectconfig.setup({
  project_config_path = vim.env.HOME .. "/.config/lvim/config/projects.json",
  defaults = {}
})
