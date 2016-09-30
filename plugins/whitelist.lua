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
do

local function get_message_callback (extra , success, result)
	if result.service then
		local action = result.action.type
		if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then
			if result.action.user then 
				user_id = result.action.user.peer_id
			end
		end
	else
		user_id = result.from.peer_id
	end
	local receiver = extra.receiver
	local hash = "whitelist"
	local is_whitelisted = redis:sismember(hash, user_id)      
	if is_whitelisted then
		redis:srem(hash, user_id)
		send_large_msg(receiver, "User/Bot ["..user_id.."] removed from whitelist")
	else
		redis:sadd(hash, user_id)
		send_large_msg(receiver, "User/Bot ["..user_id.."] added to whitelist")
	end
	
end

local function whitelist_res (extra, success, result)
	local user_id = result.peer_id
	local receiver = extra.receiver
	local hash = "whitelist"
	local is_whitelisted = redis:sismember(hash, user_id)      
	if is_whitelisted then
		redis:srem(hash, user_id)
		send_large_msg(receiver, "User/Bot ["..user_id.."] removed from whitelist")
	else
		redis:sadd(hash, user_id)
		send_large_msg(receiver, "User/Bot ["..user_id.."] added to whitelist")
	end
end

local function run (msg, matches)
if matches[1] == "whitelist" and is_admin1(msg) then
    local hash = "whitelist"
    local user_id = ""
	if type(msg.reply_id) ~= "nil" then
		local receiver = get_receiver(msg)
		get_message(msg.reply_id, get_message_callback, {receiver = receiver})
    elseif string.match(matches[2], '^%d+$') then
		local user_id = matches[2]
		local is_whitelisted = redis:sismember(hash, user_id)      
		if is_whitelisted then
			redis:srem(hash, user_id)
			return "User/Bot ["..user_id.."] removed from whitelist"
		else
			redis:sadd(hash, user_id)
			return "User/Bot ["..user_id.."] added to whitelist"
		end
	elseif not string.match(matches[2], '^%d+$') then
		local receiver = get_receiver(msg)
		local username = matches[2]
		local username = string.gsub(matches[2], '@', '')
		resolve_username(username, whitelist_res, {receiver = receiver})
	end
end

	if matches[1] == "clean" and matches[2] == 'whitelist' and is_admin1(msg) then
		local hash =  'whitelist'
			redis:del(hash)
		return "Whitelist Cleaned"
	end
end

return {
    patterns = {
	  "^[#!/](whitelist)$",
      "^[#!/](whitelist) (.*)$",
	  "^[#!/](clean) (.*)$"
    },
    run = run
}
end
-- Jove 3.1
