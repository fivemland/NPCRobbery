local follow = false

function loadModel(hash)
  hash = type(hash) == 'number' and hash or GetHashKey(hash)

  if not IsModelInCdimage(hash) then 
    return false
  end

  if HasModelLoaded(hash) then 
    return hash
  end

  RequestModel(hash)
  while (not HasModelLoaded(hash)) do
      Wait(0)
  end
  return hash
end

function ShowHelpNotification(text)
  SetTextComponentFormat("STRING")
  AddTextComponentString(text)
  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end
CreateThread(function()
  local hash = loadModel(Config.Ped)

  local npc = CreatePed(4, hash, Config.Coords, false, true)
  FreezeEntityPosition(npc, true)	
  SetEntityHeading(npc, 92.96)
  SetEntityInvincible(npc, true)
  SetBlockingOfNonTemporaryEvents(npc, true)
end)



RegisterNetEvent('NPCRobStart', function()
  if Config.ESXNotify == true then
    ESX.ShowNotification(Locales[Config.Locale]['RobNotify'])
  end
  if Config.ESXNotify == false then
  exports.pNotify:SendNotification({
    text = Locales[Config.Locale]['RobNotify'],
    type = "info",
    timeout = 5000,
    layout = "topCenter",
    })
  end
    Wait(10)

  local hash = loadModel(Config.HostagePed)

  local Rnpc = CreatePed(4, hash, Config.CoordsToSpawn, false, true)
  BlipNPC = AddBlipForEntity(Rnpc)
  SetBlockingOfNonTemporaryEvents(Rnpc, true)
  SetEntityInvincible(Rnpc, true)
  SetBlipDisplay(BlipNPC, 4)
  SetBlipScale  (BlipNPC, 0.8)
  SetBlipColour (BlipNPC, 0)
  SetBlipAsShortRange(BlipNPC, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Túsz')
  EndTextCommandSetBlipName(BlipNPC)

RegisterNetEvent('follow', function()
  follow = true
  FreezeEntityPosition(Rnpc, false)
  while follow do
  local player = PlayerId()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  TaskPedSlideToCoord(Rnpc, pedCo, 100)
  Wait(1)
  end
end)

RegisterNetEvent('stop', function()
follow = false
ClearPedTasksImmediately(Rnpc)
loadAnimDict('missminuteman_1ig_2')
TaskPlayAnim(Rnpc, 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)	
FreezeEntityPosition(Rnpc, true)
end)

RegisterNetEvent('getincar', function()
  FreezeEntityPosition(Rnpc, false)
  local player = PlayerId()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  local vehicle = GetVehiclePedIsIn(ped, true)

if IsPedInVehicle(ped, vehicle, false) then
  TaskEnterVehicle(Rnpc, vehicle, -1, 0, 2.0001, 1)
  ClearPedTasks(Rnpc)
end
if IsPedInVehicle(ped, vehicle, false) == false then
ClearPedTasksImmediately(Rnpc)
FreezeEntityPosition(Rnpc, false)
GetLastDrivenVehicle(vehcile)
TaskEnterVehicle(Rnpc, vehicle, -1, 0, 2.0001, 1)
end
end)

RegisterNetEvent('getoffcar', function()
  FreezeEntityPosition(Rnpc, false)
  local player = PlayerId()
  local ped = PlayerPedId()
  local pedCo = GetEntityCoords(ped)
  local vehicle = GetVehiclePedIsIn(ped, true)
  if not IsPedInVehicle(ped, vehicle) then
    

end)
  

 local rob = true
 local handsup = false
    while rob do
        local player = PlayerId()
        local ped = PlayerPedId()
        local pedCo = GetEntityCoords(ped)
        if IsPlayerFreeAimingAtEntity(player, Rnpc) then
            if not IsEntityPlayingAnim(Rnpc, 'missminuteman_1ig_2', 'handsup_enter', 1) then
                loadAnimDict('missminuteman_1ig_2')
                TaskPlayAnim(Rnpc, 'missminuteman_1ig_2', 'handsup_enter', 8.0, 8.0, -1, 50, 0, 0, 0, 0)
                TaskTurnPedToFaceEntity(Rnpc, ped, 1000)
                handsup = true

                if handsup == true then
                  exports.qtarget:AddTargetEntity(Rnpc, {
                    options = {
                      {
                        event = "follow",
                        icon = "fas fa-box-circle-check",
                        label = "Kövess!",
                        num = 1
                      }, 
                      {
                        event = "stop",
                        icon = "fas fa-box-circle-check",
                        label = "Állj!",
                        num = 2
                      }, 
                      {
                        event = "getincar",
                        icon = "fas fa-box-circle-check",
                        label = "Beszállás kocsiba!",
                        num = 3
                      }, 
                      {
                        event = "getoffcar",
                        icon = "fas fa-box-circle-check",
                        label = "Kiszállás kocsiból!",
                        num = 4
                      }, 

                    },
                    distance = 10
                  })
                end
                if handsup == false then 
                  exports.qtarget:RemoveTargetEntity(Rnpc, {
                    'Kövess!'
                  })
                end
            end
        end
        Wait(1)
    end

  local Coords = {
    Config.CoordsToWalk.a,
    Config.CoordsToWalk.b
  }

 TaskPedSlideToCoord(Rnpc, Coords[math.random(#Coords)], 1000)
  Wait(10)
  TriggerServerEvent('PoliceAlert')
end)

exports.qtarget:AddBoxZone("StartNPCRobbery", Config.ROBLocation.targetZone, 1, 1, {
  name="StartNPCRobbery",
  heading = Config.ROBLocation.targetHeading,
  debugPoly = false,
  minZ = Config.ROBLocation.minZ,
  maxZ = Config.ROBLocation.maxZ,
  }, {
    options = {
        {
          event = "NPCRobStart",
          icon = "Fas Fa-hands",
          label = "Túszok elrablása",
        }
      },
    distance = 3.5
})