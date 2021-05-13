ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterUsableItem('krycka', function(source)
	TriggerClientEvent('r4lle_krycka:UseKrycka', source)
end)

--- server