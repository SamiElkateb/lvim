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

-- In a table of configs searches for the one that has the closest path
-- if there config path is an array the final config is returned with 
-- a string containing the closest path
local function find_closest_parent(configs, path)
  local expanded_path = vim.fn.expand(path)
  local closest_parent = nil
  local index = nil
  for i, config in ipairs(configs) do
    local tmp = config.paths or config.path
    local config_paths = {}
    if type(tmp) == "string" then
      config_paths = { tmp }
    else
      config_paths = tmp
    end
    for _, config_path in ipairs(config_paths) do
      local expanded_config_path = vim.fn.expand(config_path)
      if string.find(expanded_path, expanded_config_path, 1, true) == 1 and (closest_parent == nil or #expanded_config_path > #closest_parent) then
        closest_parent = expanded_config_path
        index = i
      end
    end
  end
  if index ~= nil then
    local config = vim.deepcopy(configs[index])
    config.path = closest_parent
    return config
  end
end

function M.get_config_for(path)
  local closest_parent = find_closest_parent(M.projects, path) or M.defaults
  return vim.tbl_deep_extend("keep", closest_parent, M.defaults)
end

function M.get_config_for_cwd()
  return M.get_config_for(vim.fn.getcwd())
end

return M
