local rhs_options = {}

function rhs_options:new()
	local instance = {
		cmd = "",
		options = {
			noremap = true,
			silent = true,
			expr = false,
			nowait = false,
		},
        func = nil,
		buffer = false,
	}
	setmetatable(instance, self)
	self.__index = self
	return instance
end

function rhs_options:map_cmd(cmd_string)
	self.cmd = cmd_string
	return self
end

function rhs_options:map_lua_function(func)
    self.func = func
    return self
end

function rhs_options:map_cr(cmd_string)
	self.cmd = (":%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:map_args(cmd_string)
	self.cmd = (":%s<Space>"):format(cmd_string)
	return self
end

function rhs_options:map_cu(cmd_string)
	-- <C-u> to eliminate the automatically inserted range in visual mode
	self.cmd = (":<C-u>%s<CR>"):format(cmd_string)
	return self
end

function rhs_options:with_silent()
	self.options.silent = true
	return self
end

function rhs_options:with_noremap()
	self.options.noremap = true
	return self
end

function rhs_options:with_expr()
	self.options.expr = true
	return self
end

function rhs_options:with_nowait()
	self.options.nowait = true
	return self
end

function rhs_options:with_buffer(num)
	self.buffer = num
	return self
end

function rhs_options:with_not_noremap()
    self.options.noremap = false
    return self
end

function rhs_options:with_not_silent()
    self.options.silent = false
    return self
end

local pbind = {}
local mode_set = "nvsxo!ilct"


local function modeParser(mode)
    local ret = {}
    if mode == nil or mode == "" then
        return ""
    else 
        for value in string.gmatch(mode, "([^,]+)") do
            if #value == 1 and string.find(mode_set, value) then
                ret[#ret+1] = value
            end
        end
    end
    if #ret == 1 then return ret[1] end
    return ret
end

function pbind.map_cr(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cr(cmd_string)
end

function pbind.map_cmd(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cmd(cmd_string)
end

function pbind.map_cu(cmd_string)
	local ro = rhs_options:new()
	return ro:map_cu(cmd_string)
end

function pbind.map_args(cmd_string)
	local ro = rhs_options:new()
	return ro:map_args(cmd_string)
end

function pbind.map_lua_function(func) 
    local ro = rhs_options:new()
    return ro:map_lua_function(func)
end

function pbind.nvim_load_mapping(mapping)
	for key, value in pairs(mapping) do
		local modeStr, keymap = key:match("([^|]*)|?(.*)")
        local mode = modeParser(modeStr)
		if type(value) == "table" then
			local rhs = value.cmd
			local options = value.options
			local buf = value.buffer
            local lua_function = value.func
			if buf then
                if (lua_function ~= nil) then
                    vim.keymap.set(mode, keymap, lua_function, options)
                else
                    vim.api.nvim_buf_set_keymap(buf, mode, keymap, rhs, options)
                end
			else
                if (lua_function ~= nil) then
                    vim.keymap.set(mode, keymap, lua_function, options)
                else 
                    vim.keymap.set(mode, keymap, rhs, options)
				    -- vim.api.nvim_set_keymap(mode, keymap, rhs, options)
                end
			end
		end
	end
end

return pbind
