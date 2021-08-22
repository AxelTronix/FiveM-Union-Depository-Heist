ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('Union:CanRob', function(src,cb)
    local cops = 0
    local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

        if cops >= Config.MinCop then
            cb(true)
        else
            cb(false)
        end
end)


ESX.RegisterServerCallback('Union:HasItem', function(src,cb)
	local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getInventoryItem('electronickit').count >= 1 then
        xPlayer.removeInventoryItem('electronickit', 1)
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('Union:HasItem:blowtorch', function(src,cb)
	local xPlayer = ESX.GetPlayerFromId(src)

    if xPlayer.getInventoryItem('blowtorch').count >= 1 then
        xPlayer.removeInventoryItem('blowtorch', 1)
        cb(true)
    else
        cb(false)
    end
end)


RegisterServerEvent("Looted:Union")
AddEventHandler("Looted:Union",function(dist)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local item = {}

     item = Config.Prize[math.random(1,#Config.Prize)]

    if dist > 0.8 then
        Logged(GetPlayerName(src),"Possible Cheater")
        DropPlayer(src,"")
    else

        xPlayer.addInventoryItem(item.item, item.Amount)
        Logged(GetPlayerName(src),"Player has recieved Item "..item.item.." x"..item.Amount.." From Union Depository")
        end
end)



function Logged(player,message)
    Wait(200)
        local embed = {
            {
                ["color"] = 25087,
                ["title"] = "Union Depositary",
                ["description"] = "",
                ["fields"] = {
                    {
                        ["name"] = "Player",
                        ["value"] = player,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Message",
                        ["value"] = message,
                        ["inline"] = true
                    },
                    {
                        ["name"] = "Time",
                        ["value"] = os.date("%c"),
                        ["inline"] = true
                    },
                    
                },
                ["footer"] = {
                    ["text"] = "©️ All rights reserved by Tronix",
                },
            }
        }
        PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = "Discord Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
end



RegisterServerEvent("tronix:cop")
AddEventHandler("tronix:cop",function(x,y,z)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("esx:showNotification", xPlayer.source, "(Union Depository Robbery) ONGOING!")
            TriggerClientEvent('Tronix:copblip', -1, x,y,z)
	     return
		end
	end
end)