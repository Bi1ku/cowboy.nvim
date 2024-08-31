local utils = require("cowboy.utils")

local cowboy = {}

local count = 0
local prev_key = ""
local options = {}

local handler = function(key)
	vim.keymap.set("n", key, function()
		count = count + 1

		if prev_key ~= key then
			count = 0
		end
		prev_key = key

		if count > options.thresh then
			vim.notify("Slow down, Cowboy!", vim.log.levels.WARN)
			vim.defer_fn(function()
				count = 0
				print("reset", count, options.thresh, count > options.thresh)
				return key
			end, options.delay)
		else
			return key
		end
	end, { expr = true, silent = true })
end

cowboy.setup = function(opts)
	options = opts
	for _, key in ipairs(opts.keys) do
		handler(key)
	end
end

--	local prev_key = ""
--	local count = 0
--	local cursor_pos
--
--	vim.on_key(function(key)
--		if prev_key ~= key then
--			count = 0
--		end
--		prev_key = key
--
--		if not utils.contains(opts.keys, key) then
--			return
--		end
--
--		count = count + 1
--
--		if opts.thresh < count then
--			count = 0
--			print(vim.inspect(vim.api.nvim_win_get_cursor(0)))
--			cursor_pos = vim.api.nvim_win_get_cursor(0)
--			print(vim.inspect(cursor_pos))
--		--vim.notify("Slow down, Cowboy!", vim.log.levels.WARN)
--		--			utils.sleep(0.5)
--		else
--			return key
--		end
--	end)

return cowboy

---------------
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
------------
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
------------
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
------------
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
---
--
--
