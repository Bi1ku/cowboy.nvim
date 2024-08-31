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

  vim.on_key(function(key)
    prev_key = key
  end)
end

return cowboy
