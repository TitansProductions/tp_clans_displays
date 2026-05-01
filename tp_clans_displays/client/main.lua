local NUIFocus = false

-----------------------------------------------------------
--[[ Local Functions ]]--
-----------------------------------------------------------

local ToggleUI = function(display)

    NUIFocus = display 

	SetNuiFocus(false,false)
    SendNUIMessage({ type = "enable", enable = display })
end

-----------------------------------------------------------
--[[ Public Events ]]--
-----------------------------------------------------------

RegisterNetEvent("tp_clans_displays:client:StartDisplay")
AddEventHandler("tp_clans_displays:client:StartDisplay", function(title, description, title_rgba, description_rgba, duration)
    Wait(2000) -- mandatory wait
    SendNUIMessage({ 
        action                 = 'sendAnnouncement',
        title                  = title,
        title_rgba             = title_rgba,
        title_description      = description,
        title_description_rgba = description_rgba,
    })

    ToggleUI(true)

    Wait(1000 * duration)
    SendNUIMessage({action = 'close'})
end)

RegisterNetEvent("tp_clans_displays:client:ForceStop")
AddEventHandler("tp_clans_displays:client:ForceStop", function()
    SendNUIMessage({action = 'close'})
end)


-----------------------------------------------------------
--[[ Public Functions ]]--
-----------------------------------------------------------

exports('StartDisplay', function(title, description, title_rgba, description_rgba) 

    SendNUIMessage({ 
        action                 = 'sendAnnouncement',
        title                  = title,
        title_rgba             = title_rgba,
        title_description      = description,
        title_description_rgba = description_rgba,
    })

    ToggleUI(true)
end)

exports('UpdateTitle', function(title) 
    SendNUIMessage({ action = 'updateTitle', title = title })
end)

exports('UpdateDescription', function(description) 
    SendNUIMessage({ action = 'updateDescription', title_description = description })
end)

exports('Stop', function() 
    SendNUIMessage({action = 'close'})
end)

-----------------------------------------------------------
--[[ NUI Callbacks  ]]--
-----------------------------------------------------------

RegisterNUICallback('close', function()
	ToggleUI(false)
end)
