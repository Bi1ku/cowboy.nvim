local utils = {}

utils.contains = function(arr, value)
	for _, v in ipairs(arr) do
		if v == value then
			return true
		end
	end
	return false
end

utils.sleep = function(n)
	local past = vim.loop.hrtime()
	while vim.loop.hrtime() - past < (n * 1e9) do
	end
end

return utils
