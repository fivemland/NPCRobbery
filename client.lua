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

CreateThread(function()
  local hash = loadModel(Config.Ped)

  local npc = CreatePed(4, hash, Config.Coords, false, true)
  FreezeEntityPosition(npc, true)	
  SetEntityHeading(npc, 92.96)
  SetEntityInvincible(npc, true)
  SetBlockingOfNonTemporaryEvents(npc, true)
end)

RegisterNetEvent('NPCRobStart')
AddEventHandler('NPCRobStart', function()
  exports.pNotify:SendNotification({
    text = 'Egy pillanat és kijelölöm a térképen a túsz helyét!',
<<<<<<< HEAD
    type = "info",
    timeout = 5000,
    layout = "topCenter",
    })
  Wait(1)
=======
    type = "error",
    timeout = 5000,
    layout = "topCenter",
    })
  Wait(10000)
>>>>>>> 4125272fbd2c0b3d4ce6d1b5878d0b47c4e77df8

  local hash = loadModel(Config.HostagePed)

  local npc = CreatePed(4, hash, Config.CoordsToSpawn, false, true)
  BlipNPC = AddBlipForEntity(npc)
  SetBlipDisplay(BlipNPC, 4)
  SetBlipScale  (BlipNPC, 0.8)
  SetBlipColour (BlipNPC, 0)
  SetBlipAsShortRange(BlipNPC, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Túsz')
  EndTextCommandSetBlipName(BlipNPC)
<<<<<<< HEAD

  local Coords = {
    Config.CoordsToWalk.a,
    Config.CoordsToWalk.b
  }

  TaskPedSlideToCoord(npc, Coords[math.random(#Coords)], 1000)
  Wait(1)
TriggerServerEvent('PoliceAlert')
end)

AddEventHandler('robbery', function()
  TriggerEvent('NPCRobStart')
end)

=======

  local Coords = {
    Config.CoordsToWalk.a,
    Config.CoordsToWalk.b
  }

  TaskPedSlideToCoord(npc, Coords[math.random(#Coords)], 1000)
end)

AddEventHandler('rablas', function()
  TriggerEvent('NPCRobStart')
end)

>>>>>>> 4125272fbd2c0b3d4ce6d1b5878d0b47c4e77df8
exports.qtarget:AddBoxZone("StartNPCRobbery", Config.ROBLocation.targetZone, 1, 1, {
  name="StartNPCRobbery",
  heading = Config.ROBLocation.targetHeading,
  debugPoly = false,
  minZ = Config.ROBLocation.minZ,
  maxZ = Config.ROBLocation.maxZ,
  }, {
    options = {
        {
          event = "robbery",
          icon = "Fas Fa-hands",
          label = "Túszok elrablása",
        }
      },
    distance = 3.5
})
<<<<<<< HEAD
--Client->Server->polices
   
=======

>>>>>>> 4125272fbd2c0b3d4ce6d1b5878d0b47c4e77df8
