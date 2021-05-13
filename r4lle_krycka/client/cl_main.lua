ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

LoadAnimDict = function(dict)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(5)
    end
end

local holdingstick = false
local walkstick = "r4lle_krycka"
local walk_net = nil

RegisterNetEvent('r4lle_krycka:UseKrycka')
AddEventHandler('r4lle_krycka:UseKrycka', function(prop_name)
	local ad1 = "missbigscore2aleadinout@bs_2a_2b_int"
	local ad1a = "lester_base_idle"
	local player = GetPlayerPed(-1)
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
	local umbspawned = CreateObject(GetHashKey(walkstick), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(umbspawned)


	if (DoesEntityExist(player) and not IsEntityDead(player)) then 
		loadAnimDict(ad1)
		RequestModel(GetHashKey(walkstick))
		if holdingstick then
			Wait(100)
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(NetToObj(walk_net), 1, 1)
			DeleteEntity(NetToObj(walk_net))
			walk_net = nil
			holdingstick = false
		else
			TaskPlayAnim(player, ad1, ad1a, 8.0, 1.0, -1, 49, 0, 0, 0, 0)
			Wait(500)
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)
			AttachEntityToEntity(umbspawned,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)
			Wait(120)
			walk_net = netid
			holdingstick = true
		end
	end
end)

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  RequestAnimDict(dict)
	  Wait(10)
	end
  end
