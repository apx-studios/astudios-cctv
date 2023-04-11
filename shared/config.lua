--------------------------------------
--<!>-- ASTUDIOS | DEVELOPMENT --<!>--
--------------------------------------
Config = {}

Config.Debug = false -- True / False for Debug System

-- Notifications
Config.NotificationType = { -- 'qbcore' / 'astudios' / 'okok' Choose your notification script.
    server = 'qbcore',
    client = 'qbcore' 
}

-- Surveillance
Config.Surveillance = {
    Target = {
        CustomSpot = true, -- If true, you are not using the information below.
        points = vector3(437.19, -995.38, 30.69), -- Target location
        heading = 270.0, -- Target heading
        minZ = 30.0, -- Target min Z
        maxZ = 31.0, -- Target max Z
        length = 1.4, -- Target length
        width = 2.55, -- Target width
        distance = 2.0, -- Target distance
    },
    AllowedJobs = {'police'}, -- Job Name: 'police' by default - You can add more jobs here, if you want to (e.g. 'police', 'bcso', 'sasp')
    Cameras = {
        Banks = {
            [1] = {
                label = "Pacific Bank CAM#1", 
                coords = vector3(257.45, 210.07, 109.08), 
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up 
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 28.05, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                rotatable = false -- If true the camera can be rotated by using "WASD"
            },
            -- [x] = { -- Add more by using this
            --     label = "Camera Name, 
            --     coords = vector3(0.0, 0.0, 0.0), 
            --     rotation = {
            --         x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up
            --         y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
            --         z = 0.0, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
            --     }, 
            --     rotatable = false -- If true the camera can be rotated by using "WASD"
            -- },
        },
        Stores = {
            [1] = {
                label = "Limited Ltd Grove St. CAM#1", -- The name of the camera - This will be shown on the list of cameras.
                coords = vector3(-53.1433, -1746.714, 31.546),  -- The coords of the camera - You might have to adjust the z value to get the camera in the right position (height)
                rotation = {
                    x = -35.0, -- This is the tilt of the camera (-) = down and (+) = up
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = -168.9182, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                rotatable = false -- If true the camera can be rotated by using "WASD"
            },
            -- [x] = { -- Add more by using this
            --     label = "Camera Name, -- The name of the camera - This will be shown on the list of cameras.
            --     coords = vector3(0.0, 0.0, 0.0),  -- The coords of the camera - You might have to adjust the z value to get the camera in the right position (height)
            --     rotation = {
            --         x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up
            --         y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
            --         z = 0.0, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
            --     }, 
            --     rotatable = false -- If true the camera can be rotated by using "WASD"
            -- },
        },
        Others = {
            [1] = {
                label = "Premium Deluxe Motorsport CAM#1", -- The name of the camera - This will be shown on the list of cameras.
                coords = vector3(-60.01, -1099.78, 30.26), -- The coords of the camera - You might have to adjust the z value to get the camera in the right position (height).
                rotation = {
                    x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up
                    y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
                    z = 193.3, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
                }, 
                rotatable = false -- If true the camera can be rotated by using "WASD"
            },
            -- [x] = { -- Add more by using this
            --     label = "Camera Name, -- The name of the camera - This will be shown on the list of cameras.
            --     coords = vector3(0.0, 0.0, 0.0),  -- The coords of the camera - You might have to adjust the z value to get the camera in the right position (height)
            --     rotation = {
            --         x = -25.0, -- This is the tilt of the camera (-) = down and (+) = up
            --         y = 0.0, -- This is pitch left or right - We recommend not touching it, unless you know what you are doing. 
            --         z = 0.0, -- This is the direction the camera is facing. Would also be the last number in vector4(x, y, z, w)
            --     }, 
            --     rotatable = false -- If true the camera can be rotated by using "WASD"
            -- },
        }
    }
}
