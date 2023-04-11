--------------------------------------
--<!>-- ASTUDIOS | DEVELOPMENT --<!>--
--------------------------------------
print("^2[astudios-cctv] ::^0 Started")
print("^2[astudios-cctv] ::^0 Developed by ASTUDIOS | DEVELOPMENT")
local QBCore = exports["qb-core"]:GetCoreObject()

-- Define function for registering events
local function registerCameraEvent(eventName, clientEventName)
    RegisterNetEvent(eventName, function(args)
        local cam = tonumber(args[1])
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        TriggerClientEvent(clientEventName, src, cam)
    end)
end

-- Register events for different camera types
registerCameraEvent('astudios-cctv:server:bankcamera', 'astudios-cctv:client:bankcamera')
registerCameraEvent('astudios-cctv:server:storecamera', 'astudios-cctv:client:storecamera')
registerCameraEvent('astudios-cctv:server:othercamera', 'astudios-cctv:client:othercamera')
