RegisterNetEvent('PoliceAlert', function()
    local number = math.random(0, 1)
        if number == 1 then
            print('0')
            local source  = source
            local xPlayer  = ESX.GetPlayerFromId(source)
            if xPlayer.job.name == 'police' then
                TriggerClientEvent("pNotify:SendNotification", -1, {
                  text = "RABLÁS FOLYAMATBAN",
                  type = "error",
                  timeout = 10000,
                  layout = "topCenter"
                })
            end
        end
    end)

