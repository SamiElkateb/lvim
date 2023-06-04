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

-- lua print(lvim.lazy.opts.root)
table.insert(dap.configurations.python, {
  name = "Python: Remote Attach",
  type = "python",
  request = "attach",
  connect = {
    host = "localhost",
    port = "5678"
  },
  justMyCode = true,
  pythonArgs = { "-Xfrozen_modules=off" },
  pathMappings = {
    {
      localRoot = "${workspaceFolder}",
      remoteRoot = "."
    }
  }
})
