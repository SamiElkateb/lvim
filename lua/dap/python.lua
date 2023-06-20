-- Ressources:
-- https://alpha2phi.medium.com/neovim-for-beginners-javascript-typescript-debugging-bd0fc8e16657

local dappython_status_ok, dappython = pcall(require, "dap-python")
if not dappython_status_ok then
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

dappython.setup(mason_path .. "packages/debugpy/venv/bin/python")

local projectconfig_status, projectconfig = pcall(require, "helpers.projectconfig")
if not projectconfig_status then
  return
end

local current_config = projectconfig.get_config_for_cwd()

table.insert(dap.configurations.python, {
  name = "Python: Remote Attach",
  type = "python",
  request = "attach",
  connect = {
    host = current_config.debugger_host,
    port = current_config.debugger_port
  },
  justMyCode = true,
  pythonArgs = { "-Xfrozen_modules=off" },
  pathMappings = {
    {
      localRoot = current_config.debugger_local_root,
      remoteRoot = current_config.debugger_remote_root
    }
  }
})

