--------------------------------------
--<!>-- ASTUDIOS | DEVELOPMENT --<!>--
--------------------------------------
local QBCore = exports["qb-core"]:GetCoreObject()


CreateThread(function()
    local cctvmenu = {
        {
            header = Language.Menu['cctvmenu'],
            icon = Language.Menu['cctvmenuicon'], 
            isMenuHeader = true,
        },
        {
            header = Language.Menu['exit'],
            icon = Language.Menu['exiticon'], 
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = Language.Menu['cctvbank'],
            icon = Language.Menu['cctvbankicon'], 
            params = {
                event = 'astudios-cctv:client:cctvbank'
            }
        },
        {
            header = Language.Menu['cctvstores'],
            icon = Language.Menu['cctvstoresicon'], 
            params = {
                event = 'astudios-cctv:client:cctvstores'
            }
        },
        {
            header = Language.Menu['cctvother'],
            icon = Language.Menu['cctvothericon'], 
            params = {
                event = 'astudios-cctv:client:cctvother'
            }
        },
    }

    local cctvbank = {
        {
            header = Language.Menu['cctvbank'],
            icon = Language.Menu['cctvbankicon'], 
            isMenuHeader = true,
        },
        {
            header = Language.Menu['exit'],
            icon = Language.Menu['exiticon'], 
            params = {
                event = "astudios-cctv:client:cctvmenu",
            }
        },
    }
    
    -- Add cameras for banks to menu
    local bankcameras = Config.Surveillance.Cameras.Banks
    for i, bankcamera in pairs(bankcameras) do
        local camItem = {
            header = bankcamera.label,
            icon = Language.Menu['cctvmenuicon'],
            params = {
                isServer = true,
                event = 'astudios-cctv:server:bankcamera',
                args = {i} -- pass the argument as a table
            }
        }
        table.insert(cctvbank, camItem)
    end

    local cctvstores = {
        {
            header = Language.Menu['cctvstores'],
            icon = Language.Menu['cctvstoresicon'], 
            isMenuHeader = true,
        },
        {
            header = Language.Menu['exit'],
            icon = Language.Menu['exiticon'], 
            params = {
                event = "astudios-cctv:client:cctvmenu",
            }
        },
    }

    -- Add cameras for stores to menu
    local storecameras = Config.Surveillance.Cameras.Stores
    for i, storecamera in pairs(storecameras) do
        local camItem = {
            header = storecamera.label,
            icon = Language.Menu['cctvmenuicon'],
            params = {
                isServer = true,
                event = 'astudios-cctv:server:storecamera',
                args = {i}
            }
        }
        table.insert(cctvstores, camItem)
    end

    local cctvother = {
        {
            header = Language.Menu['cctvother'],
            icon = Language.Menu['cctvothericon'], 
            isMenuHeader = true,
        },
        {
            header = Language.Menu['exit'],
            icon = Language.Menu['exiticon'], 
            params = {
                event = "astudios-cctv:client:cctvmenu",
            }
        },
    }

    -- Add cameras for others to menu
    local othercameras = Config.Surveillance.Cameras.Others
    for i, othercamera in pairs(othercameras) do
        local camItem = {
            header = othercamera.label,
            icon = Language.Menu['cctvmenuicon'],
            params = {
                isServer = true,
                event = 'astudios-cctv:server:othercamera',
                args = {i}
            }
        }
        table.insert(cctvother, camItem)
    end

    local menus = {
        cctvmenu = cctvmenu,
        cctvbank = cctvbank,
        cctvstores = cctvstores,
        cctvother = cctvother,
    }
    
    for menuName, menu in pairs(menus) do
        RegisterNetEvent('astudios-cctv:client:' .. menuName, function()
            exports['qb-menu']:openMenu(menu)
        end)
    end
end)







