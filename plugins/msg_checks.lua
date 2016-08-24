--[[
|------------------------------------------------- |--------- ______-----------------_______---|
|   ______   __   ______    _____     _____    __  |  _____  |  ____|  __     __    /  _____/  |
|  |__  __| |  | |__  __|  /     \   |     \  |  | | |__   | | |____  |  |   |  |  /  /____    |
|    |  |   |  |   |  |   /  /_\  \  |  |\  \ |  | |   /  /  |  ____| |  |   |  |  \____   /   |
|    |  |   |  |   |  |  /  _____  \ |  | \  \|  | |  /  /_  | |____  |  |___|  |   ___/  /    |
|    |__|   |__|   |__| /__/     \__\|__|  \_____| | |_____| |______|  \_______/  /______/     |
|--------------------------------------------------|-------------------------------------------|
| This Project Powered by : Pouya Poorrahman CopyRight 2016 Jove Version 3.1 Anti Spam Cli Bot |
|                             The Other Code Writer: Erfan Kiya                                |
|----------------------------------------------------------------------------------------------|
]]
local function pre_process(msg)
if is_chat_msg(msg) or is_super_group(msg) then
	if msg and not is_momod(msg) and not is_whitelisted(msg.from.id) then --if regular user
	local data = load_data(_config.moderation.data)
	local print_name = user_print_name(msg.from):gsub("‮", "") -- get rid of rtl in names
	local name_log = print_name:gsub("_", " ") -- name for log
	local to_chat = msg.to.type == 'chat'
	if data[tostring(msg.to.id)] and data[tostring(msg.to.id)]['settings'] then
		settings = data[tostring(msg.to.id)]['settings']
	else
		return
	end
	if settings.lock_arabic then
		lock_arabic = settings.lock_arabic
	else
		lock_arabic = '🔓'
	end
	if settings.lock_rtl then
		lock_rtl = settings.lock_rtl
	else
		lock_rtl = '🔓'
	end
	if settings.lock_tgservice then
		lock_tgservice = settings.lock_tgservice
	else
		lock_tgservice = '🔓'
	end
	if settings.lock_link then
		lock_link = settings.lock_link
	else
		lock_link = '🔓'
	end
	if settings.lock_member then
		lock_member = settings.lock_member
	else
		lock_member = '🔓'
	end
	if settings.lock_spam then
		lock_spam = settings.lock_spam
	else
		lock_spam = '🔓'
	end
	if settings.lock_sticker then
		lock_sticker = settings.lock_sticker
	else
		lock_sticker = '🔓'
	end
	if settings.lock_webpage then
		lock_webpage = settings.lock_webpage
	else
		lock_webpage = '🔓'
	end
	if settings.lock_badw then
		lock_badw = settings.lock_badw
	else
		lock_badw = '🔓'
	end
	if settings.lock_audio then
		lock_audio = settings.lock_audio
	else
		lock_audio = '🔓'
	end
	if settings.lock_tag then
		lock_tag = settings.lock_tag
	else
		lock_tag = '🔓'
	end
	if settings.lock_fwd then
		lock_fwd = settings.lock_fwd
	else
		lock_fwd = '🔓'
	end
	if settings.lock_emoji then
		lock_emoji = settings.lock_emoji
	else
		lock_emoji = '🔓'
	end
	if settings.lock_photo then
		lock_photo = settings.lock_photo
	else
		lock_photo = '🔓'
	end
	if settings.lock_gif then
		lock_gif = settings.lock_gif
	else
		lock_gif = '🔓'
	end
	if settings.lock_video then
		lock_video = settings.lock_video
	else
		lock_video = '🔓'
	end
	if settings.lock_contacts then
		lock_contacts = settings.lock_contacts
	else
		lock_contacts = '🔓'
	end
	if settings.lock_eng then
		lock_eng = settings.lock_eng
	else
		lock_eng = '🔓'
	end
	if settings.strict then
		strict = settings.strict
	else
		strict = '🔓'
	end
		if msg and not msg.service and is_muted(msg.to.id, 'All: yes') or is_muted_user(msg.to.id, msg.from.id) and not msg.service then
			delete_msg(msg.id, ok_cb, false)
			if to_chat then
			--	kick_user(msg.from.id, msg.to.id)
			end
		end
		if msg.text then -- msg.text checks
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			if lock_spam == "🔐" and string.len(msg.text) > 2049 or ctrl_chars > 40 or real_digits > 2000 then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					delete_msg(msg.id, ok_cb, false)
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
			local is_bot = msg.text:match("?[Ss][Tt][Aa][Rr][Tt]=")
			if is_link_msg and lock_link == "🔐" and not is_bot then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
		end
		if msg.service then 
			if lock_tgservice == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if to_chat then
					return
				end
			end
		end
			local is_squig_msg = msg.text:match("[\216-\219][\128-\191]")
			if is_squig_msg and lock_arabic == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_badw_msg = msg.text:match("[Kk][Ii][Rr]") or msg.text:match("[Kk][Oo][Ss]") or msg.text:match("[Kk][Oo][Ss][Dd][Ee]") or msg.text:match("[Kk][Oo][Oo][Nn][Ii]") or msg.text:match("[Jj][Ee][Nn][Dd][Ee]") or msg.text:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.text:match("[Kk][Oo][Oo][Nn]") or msg.text:match("کیر") or msg.text:match("کسکش") or msg.text:match("کونی") or msg.text:match("جنده") or msg.text:match("حشری")
			if is_badw_msg and lock_badw == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_tag_msg = msg.text:match("@")
			if is_tag_msg and lock_tag == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_fwd_msg = 'mate:'..msg.to.id
             if is_fwd_msg and lock_fwd == "🔐" and msg.fwd_from and not is_momod(msg)  then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_emoji_msg = msg.text:match("[😀😬😁😂😃😄😅☺️🙃🙂😊😉😇😆😋😌😍😘😗😙😚🤗😎🤓🤑😛😝😜😏😶😐😑😒🙄🤔😕😔😡😠😟😞😳🙁☹️😣😖😫😩😤😧😦😯😰😨😱😮😢😥😪😓😭😵😲💩💤😴🤕🤒😷🤐😈👿👹👺💀👻👽😽😼😻😹😸😺🤖🙀😿😾🙌🏻👏🏻👋🏻👍🏻👎🏻👊🏻✊🏻✌🏻👌🏻✋🏻👐🏻💪🏻🙏🏻☝🏻️👆🏻👇🏻👈🏻👉🏻🖕🏻🖐🏻🤘🏻🖖🏻✍🏻💅🏻👄👅👂🏻👃🏻👁👀👤👥👱🏻👩🏻👨🏻👧🏻👦🏻👶🏻🗣👴🏻👵🏻👲🏻🏃🏻🚶🏻💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👩‍👩‍👧‍👦👩‍👩‍👧👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👘👙👗👔👖👕👚💄💋👣👠👡👢👞🎒⛑👑🎓🎩👒👟👝👛👜💼👓🕶💍🌂🐶🐱🐭🐹🐰🐻🐼🐸🐽🐷🐮🦁🐯🐨🐙🐵🙈🙉🙊🐒🐔🐗🐺🐥🐣🐤🐦🐧🐴🦄🐝🐛🐌🐞🐜🕷🦂🦀🐍🐢🐠🐟🐅🐆🐊🐋🐬🐡🐃🐂🐄🐪🐫🐘🐐🐓🐁🐀🐖🐎🐑🐏🦃🕊🐕]")
			if is_emoji_msg and lock_emoji == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_eng_msg = msg.text:match("[ASDFGHJKLQWERTYUIOPZXCVBNMasdfghjklqwertyuiopzxcvbnm]")
			if is_eng_msg and lock_eng == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_webpage_msg = msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match(".[Ii][Rr]") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Oo][Rr][Gg]") or msg.text:match(".[Ii][Nn][Ff][Oo]") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Tt][Kk]")
			if is_webpage_msg and lock_webpage == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local print_name = msg.from.print_name
			local is_rtl = print_name:match("‮") or msg.text:match("‮")
			if is_rtl and lock_rtl == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, "Text: yes") and msg.text and not msg.media and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.media then -- msg.media checks
			if msg.media.title then
				local is_link_title = msg.media.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.media.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_title = msg.media.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_webpage_title = msg.media.title:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.title:match("[Hh][Tt][Tt][Pp]://") or msg.media.title:match(".[Ii][Rr]") or msg.media.title:match(".[Cc][Oo][Mm]") or msg.media.title:match(".[Oo][Rr][Gg]") or msg.media.title:match(".[Ii][Nn][Ff][Oo]") or msg.media.title:match("[Ww][Ww][Ww].") or msg.media.title:match(".[Tt][Kk]")
			if is_webpage_title and lock_webpage == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_badw_title = msg.media.title:match("[Kk][Ii][Rr]") or msg.media.title:match("[Kk][Oo][Ss]") or msg.media.title:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.title:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.title:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.title:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.title:match("[Kk][Oo][Oo][Nn]") or msg.media.title:match("کیر") or msg.media.title:match("کسکش") or msg.media.title:match("کونی") or msg.media.title:match("جنده") or msg.media.title:match("حشری")
			if is_badw_title and lock_badw == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_tag_title = msg.media.title:match("@")
			if is_tag_title and lock_tag == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_eng_title = msg.media.title:match("[ASDFGHJKLQWERTYUIOPZXCVBNMasdfghjklqwertyuiopzxcvbnm]")
			if is_eng_title and lock_eng == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			    local is_fwd_title = redis:get(hash) and msg.fwd_from
            if is_fwd_title and lock_fwd == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			    local is_emoji_title = msg.media.title:match("[😀😬😁😂😃😄😅☺️🙃🙂😊😉😇😆😋😌😍😘😗😙😚🤗😎🤓🤑😛😝😜😏😶😐😑😒🙄🤔😕😔😡😠😟😞😳🙁☹️😣😖😫😩😤😧😦😯😰😨😱😮😢😥😪😓😭😵😲💩💤😴🤕🤒😷🤐😈👿👹👺💀👻👽😽😼😻😹😸😺🤖🙀😿😾🙌🏻👏🏻👋🏻👍🏻👎🏻👊🏻✊🏻✌🏻👌🏻✋🏻👐🏻💪🏻🙏🏻☝🏻️👆🏻👇🏻👈🏻👉🏻🖕🏻🖐🏻🤘🏻🖖🏻✍🏻💅🏻👄👅👂🏻👃🏻👁👀👤👥👱🏻👩🏻👨🏻👧🏻👦🏻👶🏻🗣👴🏻👵🏻👲🏻🏃🏻🚶🏻💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👩‍👩‍👧‍👦👩‍👩‍👧👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👘👙👗👔👖👕👚💄💋👣👠👡👢👞🎒⛑👑🎓🎩👒👟👝👛👜💼👓🕶💍🌂🐶🐱🐭🐹🐰🐻🐼🐸🐽🐷🐮🦁🐯🐨🐙🐵🙈🙉🙊🐒🐔🐗🐺🐥🐣🐤🐦🐧🐴🦄🐝🐛🐌🐞🐜🕷🦂🦀🐍🐢🐠🐟🐅🐆🐊🐋🐬🐡🐃🐂🐄🐪🐫🐘🐐🐓🐁🐀🐖🐎🐑🐏🦃🕊🐕]")
			if is_emoji_title and lock_emoji == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
			if msg.media.description then
				local is_link_desc = msg.media.description:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.media.description:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_desc and lock_link == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_desc = msg.media.description:match("[\216-\219][\128-\191]")
				if is_squig_desc and lock_arabic == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_webpage_desc = msg.media.description:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.description:match("[Hh][Tt][Tt][Pp]://") or msg.media.description:match(".[Ii][Rr]") or msg.media.description:match(".[Cc][Oo][Mm]") or msg.media.description:match(".[Oo][Rr][Gg]") or msg.media.description:match(".[Ii][Nn][Ff][Oo]") or msg.media.description:match("[Ww][Ww][Ww].") or msg.media.description:match(".[Tt][Kk]")
			if is_webpage_desc and lock_webpage == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
					
				end
			end
			local is_badw_desc = msg.media.description:match("[Kk][Ii][Rr]") or msg.media.description:match("[Kk][Oo][Ss]") or msg.media.description:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.description:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.description:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.description:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.description:match("[Kk][Oo][Oo][Nn]") or msg.media.description:match("کیر") or msg.media.description:match("کسکش") or msg.media.description:match("کونی") or msg.media.description:match("جنده") or msg.media.description:match("حشری")
			if is_badw_desc and lock_badw == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_tag_desc = msg.media.description:match("@")
			if is_tag_desc and lock_tag == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_eng_desc = msg.media.description:match("[ASDFGHJKLQWERTYUIOPZXCVBNMasdfghjklqwertyuiopzxcvbnm]")
			if is_eng_desc and lock_eng == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_fwd_desc = redis:get(hash) and msg.fwd_from
            if is_fwd_desc and lock_fwd == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_emoji_desc = msg.media.description:match("[😀😬😁😂😃😄😅☺️🙃🙂😊😉😇😆😋😌😍😘😗😙😚🤗😎🤓🤑😛😝😜😏😶😐😑😒🙄🤔😕😔😡😠😟😞😳🙁☹️😣😖😫😩😤😧😦😯😰😨😱😮😢😥😪😓😭😵😲💩💤😴🤕🤒😷🤐😈👿👹👺💀👻👽😽😼😻😹😸😺🤖🙀😿😾🙌🏻👏🏻👋🏻👍🏻👎🏻👊🏻✊🏻✌🏻👌🏻✋🏻👐🏻💪🏻🙏🏻☝🏻️👆🏻👇🏻👈🏻👉🏻🖕🏻🖐🏻🤘🏻🖖🏻✍🏻💅🏻👄👅👂🏻👃🏻👁👀👤👥👱🏻👩🏻👨🏻👧🏻👦🏻👶🏻🗣👴🏻👵🏻👲🏻🏃🏻🚶🏻💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👩‍👩‍👧‍👦👩‍👩‍👧👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👘👙👗👔👖👕👚💄💋👣👠👡👢👞🎒⛑👑🎓🎩👒👟👝👛👜💼👓🕶💍🌂🐶🐱🐭🐹🐰🐻🐼🐸🐽🐷🐮🦁🐯🐨🐙🐵🙈🙉🙊🐒🐔🐗🐺🐥🐣🐤🐦🐧🐴🦄🐝🐛🐌🐞🐜🕷🦂🦀🐍🐢🐠🐟🐅🐆🐊🐋🐬🐡🐃🐂🐄🐪🐫🐘🐐🐓🐁🐀🐖🐎🐑🐏🦃🕊🐕]")
			if is_emoji_desc and lock_emoji == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
			if msg.media.caption then -- msg.media.caption checks
				local is_link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_caption and lock_link == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_caption = msg.media.caption:match("[\216-\219][\128-\191]")
					if is_squig_caption and lock_arabic == "🔐" then
						delete_msg(msg.id, ok_cb, false)
						if strict == "🔐" or to_chat then
							kick_user(msg.from.id, msg.to.id)
						end
					end
				if lock_sticker == "🔐" and msg.media.caption:match(".webp") then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_webpage_caption = msg.media.caption:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.media.caption:match("[Hh][Tt][Tt][Pp]://") or msg.media.caption:match(".[Ii][Rr]") or msg.media.caption:match(".[Cc][Oo][Mm]") or msg.media.caption:match(".[Oo][Rr][Gg]") or msg.media.caption:match(".[Ii][Nn][Ff][Oo]") or msg.media.caption:match("[Ww][Ww][Ww].") or msg.media.caption:match(".[Tt][Kk]")
			if is_webpage_caption and lock_webpage == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_badw_caption = msg.media.caption:match("[Kk][Ii][Rr]") or msg.media.caption:match("[Kk][Oo][Ss]") or msg.media.caption:match("[Kk][Oo][Ss][Dd][Ee]") or msg.media.caption:match("[Kk][Oo][Oo][Nn][Ii]") or msg.media.caption:match("[Jj][Ee][Nn][Dd][Ee]") or msg.media.caption:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.media.caption:match("[Kk][Oo][Oo][Nn]") or msg.media.caption:match("کیر") or msg.media.caption:match("کسکش") or msg.media.caption:match("کونی") or msg.text:match("جنده") or msg.media.caption:match("حشری")
			if is_badw_caption and lock_badw == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_tag_caption = msg.media.caption:match("@")
			if is_tag_caption and lock_tag == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_eng_caption = msg.media.caption:match("[ASDFGHJKLQWERTYUIOPZXCVBNMasdfghjklqwertyuiopzxcvbnm]")
			if is_eng_caption and lock_eng == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_fwd_caption = redis:get(hash) and msg.fwd_from
            if is_fwd_caption and lock_fwd == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_emoji_caption = msg.media.caption:match("[😀😬😁😂😃😄😅☺️🙃🙂😊😉😇😆😋😌😍😘😗😙😚🤗😎🤓🤑😛😝😜😏😶😐😑😒🙄🤔😕😔😡😠😟😞😳🙁☹️😣😖😫😩😤😧😦😯😰😨😱😮😢😥😪😓😭😵😲💩💤😴🤕🤒😷🤐😈👿👹👺💀👻👽😽😼😻😹😸😺🤖🙀😿😾🙌🏻👏🏻👋🏻👍🏻👎🏻👊🏻✊🏻✌🏻👌🏻✋🏻👐🏻💪🏻🙏🏻☝🏻️👆🏻👇🏻👈🏻👉🏻🖕🏻🖐🏻🤘🏻🖖🏻✍🏻💅🏻👄👅👂🏻👃🏻👁👀👤👥👱🏻👩🏻👨🏻👧🏻👦🏻👶🏻🗣👴🏻👵🏻👲🏻🏃🏻🚶🏻💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👩‍👩‍👧‍👦👩‍👩‍👧👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👘👙👗👔👖👕👚💄💋👣👠👡👢👞🎒⛑👑🎓🎩👒👟👝👛👜💼👓🕶💍🌂🐶🐱🐭🐹🐰🐻🐼🐸🐽🐷🐮🦁🐯🐨🐙🐵🙈🙉🙊🐒🐔🐗🐺🐥🐣🐤🐦🐧🐴🦄🐝🐛🐌🐞🐜🕷🦂🦀🐍🐢🐠🐟🐅🐆🐊🐋🐬🐡🐃🐂🐄🐪🐫🐘🐐🐓🐁🐀🐖🐎🐑🐏🦃🕊🐕]")
			if is_emoji_caption and lock_emoji == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
			if msg.media.type:match("contact") and lock_contacts == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_photo_caption =  msg.media.caption and msg.media.caption:match("photo")--".jpg",
			if is_muted(msg.to.id, 'Photo: yes') and msg.media.type:match("photo") or is_photo_caption and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_gif_caption =  msg.media.caption and msg.media.caption:match(".mp4")
			if is_muted(msg.to.id, 'Gifs: yes') and is_gif_caption and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					--	kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Audio: yes') and msg.media.type:match("audio") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_video_caption = msg.media.caption and msg.media.caption:lower(".mp4","video")
			if  is_muted(msg.to.id, 'Video: yes') and msg.media.type:match("video") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			if is_muted(msg.to.id, 'Documents: yes') and msg.media.type:match("document") and not msg.service then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
		end
		if msg.fwd_from then
			if msg.fwd_from.title then
				local is_link_title = msg.fwd_from.title:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or msg.fwd_from.title:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
				if is_link_title and lock_link == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_squig_title = msg.fwd_from.title:match("[\216-\219][\128-\191]")
				if is_squig_title and lock_arabic == "🔐" then
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local is_webpage_title = msg.fwd_from.title:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.fwd_from.title:match("[Hh][Tt][Tt][Pp]://") or msg.fwd_from.title:match(".[Ii][Rr]") or msg.fwd_from.title:match(".[Cc][Oo][Mm]") or msg.fwd_from.title:match(".[Oo][Rr][Gg]") or msg.fwd_from.title:match(".[Ii][Nn][Ff][Oo]") or msg.fwd_from.title:match("[Ww][Ww][Ww].") or msg.fwd_from.title:match(".[Tt][Kk]")
			if is_webpage_title and lock_webpage == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
			local is_badw_title = msg.fwd_from.title:match("[Kk][Ii][Rr]") or msg.fwd_from.title:match("[Kk][Oo][Ss]") or msg.fwd_from.title:match("[Kk][Oo][Ss][Dd][Ee]") or msg.fwd_from.title:match("[Kk][Oo][Oo][Nn][Ii]") or msg.fwd_from.title:match("[Jj][Ee][Nn][Dd][Ee]") or msg.fwd_from.title:match("[Jj][Ee][Nn][Dd][Ee][Hh]") or msg.fwd_from.title:match("[Kk][Oo][Oo][Nn]") or msg.fwd_from.title:match("کیر") or msg.fwd_from.title:match("کسکش") or msg.fwd_from.title:match("کونی") or msg.fwd_from.title:match("جنده") or msg.fwd_from.title:match("حشری")
			if is_badw_title and lock_badw == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_tag_title = msg.fwd_from.title:match("@")
			if is_tag_title and lock_tag == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_eng_title = msg.fwd_from.title:match("[ASDFGHJKLQWERTYUIOPZXCVBNMasdfghjklqwertyuiopzxcvbnm]")
			if is_eng_title and lock_eng == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_fwd_title = redis:get(hash) and msg.fwd_from
            if is_fwd_title and lock_fwd == "🔐" then
				delete_title(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end
				local is_emoji_title = msg.fwd_from.title:match("[😀😬😁😂😃😄😅☺️🙃🙂😊😉😇😆😋😌😍😘😗😙😚🤗😎🤓🤑😛😝😜😏😶😐😑😒🙄🤔😕😔😡😠😟😞😳🙁☹️😣😖😫😩😤😧😦😯😰😨😱😮😢😥😪😓😭😵😲💩💤😴🤕🤒😷🤐😈👿👹👺💀👻👽😽😼😻😹😸😺🤖🙀😿😾🙌🏻👏🏻👋🏻👍🏻👎🏻👊🏻✊🏻✌🏻👌🏻✋🏻👐🏻💪🏻🙏🏻☝🏻️👆🏻👇🏻👈🏻👉🏻🖕🏻🖐🏻🤘🏻🖖🏻✍🏻💅🏻👄👅👂🏻👃🏻👁👀👤👥👱🏻👩🏻👨🏻👧🏻👦🏻👶🏻🗣👴🏻👵🏻👲🏻🏃🏻🚶🏻💑👩‍❤️‍👩👨‍❤️‍👨💏👩‍❤️‍💋‍👩👨‍❤️‍💋‍👨👪👩‍👩‍👧‍👦👩‍👩‍👧👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👘👙👗👔👖👕👚💄💋👣👠👡👢👞🎒⛑👑🎓🎩👒👟👝👛👜💼👓🕶💍🌂🐶🐱🐭🐹🐰🐻🐼🐸🐽🐷🐮🦁🐯🐨🐙🐵🙈🙉🙊🐒🐔🐗🐺🐥🐣🐤🐦🐧🐴🦄🐝🐛🐌🐞🐜🕷🦂🦀🐍🐢🐠🐟🐅🐆🐊🐋🐬🐡🐃🐂🐄🐪🐫🐘🐐🐓🐁🐀🐖🐎🐑🐏🦃🕊🐕]")
			if is_emoji_msg and lock_emoji == "🔐" then
				delete_msg(msg.id, ok_cb, false)
				if strict == "🔐" or to_chat then
					kick_user(msg.from.id, msg.to.id)
				end
			end --sticker
			end
			if is_muted_user(msg.to.id, msg.fwd_from.peer_id) then
				delete_msg(msg.id, ok_cb, false)
			end
		end
		if msg.service then -- msg.service checks
		local action = msg.action.type
			if action == 'chat_add_user_link' then
				local user_id = msg.from.id
				local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
				if string.len(msg.from.print_name) > 70 or ctrl_chars > 40 and lock_group_spam == '🔐' then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] joined and Service Msg deleted (#spam name)")
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						savelog(msg.to.id, name_log.." ["..msg.from.id.."] joined and kicked (#spam name)")
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.from.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "🔐" then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] joined and kicked (#RTL char in name)")
					kick_user(user_id, msg.to.id)
				end
				if lock_member == '🔐' then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] joined and kicked (#lockmember)")
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
			if action == 'chat_add_user' and not is_momod2(msg.from.id, msg.to.id) then
				local user_id = msg.action.user.id
				if string.len(msg.action.user.print_name) > 70 and lock_group_spam == '🔐' then
					savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."]: Service Msg deleted (#spam name)")
					delete_msg(msg.id, ok_cb, false)
					if strict == "🔐" or to_chat then
						savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."]: added user kicked (#spam name) ")
						delete_msg(msg.id, ok_cb, false)
						kick_user(msg.from.id, msg.to.id)
					end
				end
				local print_name = msg.action.user.print_name
				local is_rtl_name = print_name:match("‮")
				if is_rtl_name and lock_rtl == "🔐" then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] added ["..user_id.."]: added user kicked (#RTL char in name)")
					kick_user(user_id, msg.to.id)
				end
				if msg.to.type == 'channel' and lock_member == '🔐' then
					savelog(msg.to.id, name_log.." User ["..msg.from.id.."] added ["..user_id.."]: added user kicked  (#lockmember)")
					kick_user(user_id, msg.to.id)
					delete_msg(msg.id, ok_cb, false)
				end
			end
		end
	end
end

	return msg
end

return {
	patterns = {},
	pre_process = pre_process
}
-- BY POUYA POORRAHMAN
