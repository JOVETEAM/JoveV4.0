--[[
|------------------------------------------------- |--------- ______-----------------_______---|
|   ______   __   ______    _____     _____    __  |  _____  |  ____|  __     __    /  _____/  |
|  |__  __| |  | |__  __|  /     \   |     \  |  | | |__   | | |____  |  |   |  |  /  /____    |
|    |  |   |  |   |  |   /  /_\  \  |  |\  \ |  | |   /  /  |  ____| |  |   |  |  \____   /   |
|    |  |   |  |   |  |  /  _____  \ |  | \  \|  | |  /  /_  | |____  |  |___|  |   ___/  /    |
|    |__|   |__|   |__| /__/     \__\|__|  \_____| | |_____| |______|  \_______/  /______/     |
|--------------------------------------------------|-------------------------------------------|
| This Project Powered by : Pouya Poorrahman CopyRight 2016 Jove Version 4.0 Anti Spam Cli Bot |
|----------------------------------------------------------------------------------------------|
]]
local function get_variables_hash(msg)
  if msg.to.type == 'chat' or msg.to.type == 'channel' then
    return 'chat:'..msg.to.id..':variables'
  end
end 

local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return var_name..':\n'..value
    end
  end
end

local function run(msg, matches)
  if not is_momod(msg) then -- only for mods,owner and admins
    return 
  end
  if matches[2] then
    local name = user_print_name(msg.from)
    savelog(msg.to.id, name.." ["..msg.from.id.."] used /get ".. matches[2])-- save to logs
    return get_value(msg, matches[2])
  else
    return
  end
end

return {
  patterns = {
    "^([#!/]get) (.+)$",
        "^(get) (.+)$"
  },
  run = run
}
