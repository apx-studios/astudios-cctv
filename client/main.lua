--------------------------------------
--<!>-- ASTUDIOS | DEVELOPMENT --<!>--
--------------------------------------
local QBCore = exports["qb-core"]:GetCoreObject()
local PlayerJob = nil -- Define global variable
local currentCameraIndex, createdCamera = 0, 0

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    local player = QBCore.Functions.GetPlayerData()
    PlayerJob = player.job.name -- Update PlayerJob to job name
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo.name -- Update PlayerJob to job name
end)

CreateThread(function()
    local allowedJobs = Config.Surveillance.AllowedJobs
    while true do -- Add loop to keep checking for job updates
        Wait(500)
        local hasAccess = false -- Reset hasAccess to false
        for i=1, #allowedJobs do
            if allowedJobs[i] == PlayerJob then -- Check PlayerJob instead of PlayerJob.name
                hasAccess = true
                break
            end
        end
        if hasAccess then
            if not Config.Surveillance.Target.CustomSpot then
                local target = Config.Surveillance.Target
                exports['qb-target']:AddBoxZone("CCTVMenu", target.points, target.width, target.length, {
                    name = "CCTVMenu",
                    heading = target.heading,
                    debugPoly = Config.Debug,
                    minZ = target.minZ,
                    maxZ = target.maxZ,
                }, {
                    options = {
                        {  
                            event = "astudios-cctv:client:cctvmenu",
                            label = Language.Targeting['cctvmenu'],
                            icon = Language.Targeting['cctvmenuicon'],
                        },
                    },
                    distance = target.distance,
                })
                break -- Exit the loop if access is granted
            end
        end
    end
end)

-- Camera Functions
function GetCurrentTime()
    local hours = GetClockHours()
    local minutes = GetClockMinutes()
    if hours < 10 then hours = tostring(0 .. GetClockHours()) end
    if minutes < 10 then minutes = tostring(0 .. GetClockMinutes()) end
    return tostring(hours .. ":" .. minutes)
end

function ChangeSecurityCamera(x, y, z, rotation)
    if createdCamera ~= 0 then DestroyCam(createdCamera, 0) createdCamera = 0 end
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, x, y, z)
    SetCamRot(cam, rotation.x, rotation.y, rotation.z, 2)
    RenderScriptCams(1, 0, 0, 1, 1)
    Wait(250)
    createdCamera = cam
end

function CloseSecurityCamera()
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    if hideradar then DisplayRadar(true) end
end

function InstructionButton(ControlButton) N_0xe83a3e3557a56640(ControlButton) end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function CreateInstuctionScaleform(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do Wait(0) end
    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    InstructionButton(GetControlInstructionalButton(1, 194, true))
    InstructionButtonMessage("Close Camera")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()
    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

-- Threads
function handleCameraRotation()
    local getCameraRot = GetCamRot(createdCamera, 2)
    -- ROTATE UP
    if IsControlPressed(0, 32) then if getCameraRot.x <= 0.0 then SetCamRot(createdCamera, getCameraRot.x + 0.7, 0.0, getCameraRot.z, 2) end end
    -- ROTATE DOWN
    if IsControlPressed(0, 8) then if getCameraRot.x >= -50.0 then SetCamRot(createdCamera, getCameraRot.x - 0.7, 0.0, getCameraRot.z, 2) end end
    -- ROTATE LEFT
    if IsControlPressed(0, 34) then SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2) end
    -- ROTATE RIGHT
    if IsControlPressed(0, 9) then SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2) end
end

CreateThread(function()
    while true do
        local sleep = 2000
        if createdCamera ~= 0 then
            sleep = 5
            local instructions = CreateInstuctionScaleform("instructional_buttons")
            DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
            SetTimecycleModifier("scanline_cam_cheap")
            SetTimecycleModifierStrength(1.0)
            if hideradar then DisplayRadar(false) end
            -- CLOSE CAMERAS
            if IsControlJustPressed(1, 177) then
                DoScreenFadeOut(250)
                while not IsScreenFadedOut() do Wait(0) end
                CloseSecurityCamera()
                SendNUIMessage({ type = "disablecam", })
                DoScreenFadeIn(250)
				local PlayerPed = PlayerPedId()
				FreezeEntityPosition(PlayerPed, false)
            end
            -- CAMERA ROTATION CONTROLS
            local cameraConfig = nil
            if Config.Surveillance.Cameras.Banks[currentCameraIndex].rotatable then
                cameraConfig = Config.Surveillance.Cameras.Banks[currentCameraIndex]
            elseif Config.Surveillance.Cameras.Stores[currentCameraIndex].rotatable then
                cameraConfig = Config.Surveillance.Cameras.Stores[currentCameraIndex]
            elseif Config.Surveillance.Cameras.Others[currentCameraIndex] ~= nil and Config.Surveillance.Cameras.Others[currentCameraIndex].rotatable then
                cameraConfig = Config.Surveillance.Cameras.Others[currentCameraIndex]
            end
            if cameraConfig ~= nil then handleCameraRotation() end
        end
        Wait(sleep)
    end
end)

-- Events
function HandleCameraEvent(cameraType, cameraId)
    local cameras = Config.Surveillance.Cameras[cameraType]
    if not cameras[cameraId] then
        if Config.NotificationType.client == "qbcore" then
            QBCore.Functions.Notify(Language.Error['no_camera'], "error")
        elseif Config.NotificationType.client == "astudios" then
            exports['astudios-notify']:notify("", Language.Error['no_camera'], 5000, 'error')
        elseif Config.NotificationType.client == "okok" then
            exports['okokNotify']:Alert("", Language.Error['no_camera'], 5000, 'error')
        end
        return
    end
    DoScreenFadeOut(250)
    while not IsScreenFadedOut() do Wait(0) end
    SendNUIMessage({ type = "enablecam", label = cameras[cameraId].label, id = cameraId, connected = true, time = GetCurrentTime(), })
    local firstCamx = cameras[cameraId].coords.x
    local firstCamy = cameras[cameraId].coords.y
    local firstCamz = cameras[cameraId].coords.z
    local firstCamr = cameras[cameraId].rotation
    SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
    ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)
    currentCameraIndex = cameraId
    DoScreenFadeIn(250)
	local PlayerPed = PlayerPedId()
	if cameraId == 0 then FreezeEntityPosition(PlayerPed, false) else FreezeEntityPosition(PlayerPed, true) end
end

RegisterNetEvent('astudios-cctv:client:bankcamera', function(cameraId)
    HandleCameraEvent("Banks", cameraId)
end)

RegisterNetEvent('astudios-cctv:client:storecamera', function(cameraId)
    HandleCameraEvent("Stores", cameraId)
end)

RegisterNetEvent('astudios-cctv:client:othercamera', function(cameraId)
    HandleCameraEvent("Others", cameraId)
end)
