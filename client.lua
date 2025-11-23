local QBCore = exports['qb-core']:GetCoreObject()

local screenshotActive = false
local playerData = QBCore.Functions.GetPlayerData()

RegisterNetEvent('GLDNRMZ-screenshot:client:takescreenshot')
AddEventHandler('GLDNRMZ-screenshot:client:takescreenshot', function()
    if not screenshotActive then
        screenshotActive = true
        exports['screenshot-basic']:requestScreenshotUpload(Config.Webhook, 'screenshot', {
            encoding = 'jpg',
            quality = 1.0
        }, function(data)
            screenshotActive = false
        end)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, key in ipairs(Config.Keys) do
            if IsControlJustReleased(0, key) then
                TriggerEvent('GLDNRMZ-screenshot:client:takescreenshot')
                break
            end
        end
    end
end)
