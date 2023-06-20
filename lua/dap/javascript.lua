-- Ressources:
-- https://alpha2phi.medium.com/neovim-for-beginners-javascript-typescript-debugging-bd0fc8e16657

local dapvscode_status_ok, dapvscodejs = pcall(require, "dap-vscode-js")
if not dapvscode_status_ok then
  return
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local daputils_status_ok, daputils = pcall(require, "dap.utils")
if not daputils_status_ok then
  return
end


dapvscodejs.setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  debugger_path = lvim.lazy.opts.root .. "/vscode-js-debug/", -- Path to vscode-js-debug installation.
  -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
  -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
  -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
  -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

local projectconfig_status, projectconfig = pcall(require, "helpers.projectconfig")
if not projectconfig_status then
  return
end

local current_config = projectconfig.get_config_for_cwd()

for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
  dap.configurations[language] = {
    {
      type = "pwa-chrome",
      name = "Debug in Chrome",
      request = "launch",
      url = "http://" .. current_config.debugger_host .. ":" .. current_config.debugger_port,
      skipFiles = {
          "${workspaceFolder}/<node_internals>/**",
          "${workspaceFolder}/node_modules/**",
      }
    },
  }
end

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach Node Local",
      processId = function ()
        daputils.pick_process({ filter = "node" })
      end,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      type = "pwa-chrome",
      name = "Debug in Chrome",
      request = "launch",
      url = "http://" .. current_config.debugger_host .. ":" .. current_config.debugger_port,
      skipFiles = {
          "${workspaceFolder}/<node_internals>/**",
          "${workspaceFolder}/node_modules/**",
      };
    },
  }
end


