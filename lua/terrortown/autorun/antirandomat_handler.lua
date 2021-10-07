AntiRandomat = AntiRandomat or {}

local function AddServer(fil)
    if SERVER then include(fil) end
end

local function AddClient(fil)
	if SERVER then AddCSLuaFile(fil) end
	if CLIENT then include(fil) end
end

AddServer("anti_-_randomat/antirandomat_socket.lua")
AddClient("anti_-_randomat/cl_msg.lua")
AddClient("anti_-_randomat/cl_net_strgs.lua")

local files, _ = file.Find("anti_-_randomat/evil_events/*.lua", "LUA")

for _, fil in pairs(files) do
    AddServer("anti_-_randomat/evil_events/" .. fil)
end
