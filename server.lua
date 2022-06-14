RegisterNetEvent('PoliceAlert', function()
local number = math.random(0,1)
    if number == 1 then
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                if Config.ESXNotify == true then
                    TriggerClientEvent('esx:showNotification', xPlayers[i], Locales[Config.Locale]['PoliceNotify'])
                end
                if Config.ESXNotify == false then
                    TriggerClientEvent("pNotify:SendNotification", xPlayers[i], {
                    text = Locales[Config.Locale]['PoliceNotify'],
                    type = "error",
                    timeout = 10000,
                    layout = "topCenter"
                    })
                end
            end
        end
    end
end)
