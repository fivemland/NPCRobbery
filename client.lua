ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end) 

Citizen.CreateThread(function()
    RequestModel(GetHashKey(Config.Ped))
    while not HasModelLoaded(GetHashKey(Config.Ped)) do
        Wait(1)
    end
  local npc = CreatePed(4, 0x62CC28E2, Config.Coords, false, true)
  FreezeEntityPosition(npc, true)	
  SetEntityHeading(npc, 92.96)
  SetEntityInvincible(npc, true)
  SetBlockingOfNonTemporaryEvents(npc, true)
end)

RegisterNetEvent('NPCRobStart')
AddEventHandler('NPCRobStart', function()
    exports.pNotify:SendNotification({
      text = 'Egy pillanat és kijelölöm a térképen a túsz helyét!',
      type = "error",
      timeout = 5000,
      layout = "topCenter",
      })
      Citizen.Wait(10000)
      RequestModel(GetHashKey(Config.HostagePed))
      while not HasModelLoaded(GetHashKey(Config.HostagePed)) do
        Wait(1)
      end
    local npc = CreatePed(4, 0x62CC28E2, Config.CoordsToSpawn, false, true)
    BlipNPC = AddBlipForEntity(npc)
    SetBlipDisplay(BlipNPC, 4)
    SetBlipScale  (BlipNPC, 0.8)
    SetBlipColour (BlipNPC, 0)
    SetBlipAsShortRange(BlipNPC, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Túsz')
    EndTextCommandSetBlipName(BlipNPC)

    Coords = {
      Config.CoordsToWalk.a,
      Config.CoordsToWalk.b
    }

    function RandomCoords()
    return Coords[math.random(#Coords)]
    end
    TaskPedSlideToCoord(npc, RandomCoords(), 1000)
end)

AddEventHandler('rablas', function()
TriggerEvent('NPCRobStart')
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
          event = "rablas",
          icon = "Fas Fa-hands",
          label = "Túszok elrablása",
        }
      },
    distance = 3.5
})
    --Client->Server->polices
   
