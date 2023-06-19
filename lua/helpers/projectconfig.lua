local M = {}
M.projects = {}
M.defaults = {}

local read_json_from_file = function(filepath)
  local file = io.open(filepath, "rb")
  if not file then
    vim.notify("Cannot read file: " .. filepath, vim.log.levels.ERROR)
    return nil
  end
  local json_string = file:read("*a")
  file:close()
  return vim.json.decode(json_string)
end

function M.setup(opts)
  M.projects = read_json_from_file(opts.project_config_path)
  M.defaults = opts.defaults
end

local function find_closest_parent(configs, path)
  local expanded_path = vim.fn.expand(path)
  local closest_parent = nil
  local index = nil
  for i, config in ipairs(configs) do
    local config_path = vim.fn.expand(config.path)
    if string.find(expanded_path, config_path, 1, true) == 1 and (closest_parent == nil or #config_path > #closest_parent) then
      closest_parent = config_path
      index = i
    end
  end
  if index ~= nil then
    return configs[index]
  end
end

function M.get_config_for(path)
  return find_closest_parent(M.projects, path) or M.defaults
end

function M.get_config_for_cwd()
  return find_closest_parent(M.projects, vim.fn.getcwd()) or M.defaults
end

return M
