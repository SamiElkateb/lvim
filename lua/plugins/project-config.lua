local projectconfig_status, projectconfig = pcall(require, "helpers.project-config")
if not projectconfig_status then
  return
end

projectconfig.setup({
  project_config_path = vim.env.HOME .. "/.config/lvim/config/projects.json",
  defaults = {
    path = "/tmp/",
    dev = "",
    install = "",
    test = "",
    cmd_from_root = false,
    worktree_switch_destination_cmd = "",
    debugger = {
      skip_files = {
        "${workspaceFolder}/<node_internals>/**"
      },
      host = "localhost",
      port = 3000,
      local_root = "${workspaceFolder}",
      remote_root = "."
    }
  }
})
