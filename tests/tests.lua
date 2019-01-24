do
	local package = require "package"
	package.path = package.path .. ";../?.lua;../?/init.lua"
end

local r = require"require"
local ok, jit = pcall(require, "jit")
if ok then
	print( ("tested: [%s] %s %s/%s"):format( _VERSION or "", jit.version or "", jit.os or "", jit.arch or "") )
else
	print( ("tested: [%s]"):format(_VERSION) )
end

for _i0, try in ipairs{ {"_G", _G.require}, {"require.lua:require51", r.require51}, {"require.lua:require52", r.require52}} do
	local k, require = try[1], try[2]
	print("")
	print("with require from "..k)
	if not require then
		print("ERROR")
	else
	for _i,dir in ipairs{"mod", "modi", "modnil"} do
		for _i2, name in ipairs{"true", "false", "nil"} do
			local modname = dir.."."..name
			local ok, res = pcall(require, modname)
			print(modname, ok and type(res) or "ERROR", res)
		end
	end
	end
end

