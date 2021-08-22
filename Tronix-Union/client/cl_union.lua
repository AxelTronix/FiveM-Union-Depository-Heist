
local UnionOpen = false
local sleepthread = 5000
local canRob = nil
local Elevator = false
local hackedelev = false
local hasitem = nil
local hackonesuccess = false
local hacktwosuccess = false
local closetime = 0 
local hackedone = false
local hackedtwo = false
local hasblowtorch = nil

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


----------------------------------------
------ B L I P -------------------------
-----------------------------------------
Citizen.CreateThread(function()
	local UnionBlip = AddBlipForCoord(4.5300488471985, -661.48175048828, 33.450492858887)
	SetBlipAsFriendly(UnionBlip, true)
    SetBlipSprite(UnionBlip, 444)
    SetBlipColour(UnionBlip, 1)
    SetBlipScale(UnionBlip, 0.6)
    SetBlipAsShortRange(UnionBlip,true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(tostring("Union Depository"))
    EndTextCommandSetBlipName(UnionBlip)
end)


----------------------------------------
------ B L I P E N D  -------------------------
-----------------------------------------

function DrawText3DTest(x,y,z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end



Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(sleepthread)
            local player = GetEntityCoords(PlayerPedId())
		    local ElevDistance = GetDistanceBetweenCoords(player.x,player.y,player.z, 11.564235687256, -664.27630615234, 33.448780059814, true)

			if ElevDistance < 15 and not hackedelev then
			    sleepthread = 50
		        if ElevDistance < 5 and not hackedelev then
			        sleepthread = 3
				    if not hackedelev then
			            DrawMarker(27,11.564235687256, -664.27630615234, 33.448780059814-0.9,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
				        DrawText3DTest(11.564235687256, -664.27630615234, 33.448780059814,"~b~[G]~w~ to Hack")

				    if IsControlJustPressed(0,58) then
					    ESX.TriggerServerCallback('Union:HasItem', function(cb) 
						    hasitem = cb
					    end, args)

					    ESX.TriggerServerCallback('Union:CanRob', function(cb) 
						    canRob = cb
					    end, args)
					    local p = exports["taskbar"]:taskBar(2000,"Connecting Laptop")
				        if p == 100 then

					    if canRob == true then

						    if hasitem == true then
								TriggerServerEvent("tronix:cop",11.564235687256, -664.27630615234, 33.448780059814)
							    print("hasitem")
					            TriggerEvent("mhacking:show")
					            TriggerEvent("mhacking:start", 5,45,Elevatorcallback)
						    else
							    exports['mythic_notify']:SendAlert('error', 'Im missing something?!')
						    end
					    else 
						    exports['mythic_notify']:SendAlert('error', 'Not Enough Cops!')
					    end
				        end
				    end
	                end
                end
			end
    end
end) 




function Elevatorcallback(success,timeremaining)
	if success then
		TriggerEvent('mhacking:hide')
		Elevator = true
		Eslavotr()
		hackedelev = true
	else
		exports['mythic_notify']:SendAlert('error', 'You Dumb? Go get another Electronic Kit')
		TriggerEvent('mhacking:hide')
	end
end


function Eslavotr()
    Citizen.CreateThread(function()
	    while Elevator do
			Citizen.Wait(5)
			local player = GetEntityCoords(PlayerPedId())
			local useelevdist = GetDistanceBetweenCoords(player.x,player.y,player.z, 10.401641845703, -671.09283447266, 33.44958114634, true)
			local secondelevdist  = GetDistanceBetweenCoords(player.x,player.y,player.z, -0.058524839580059, -705.50958251953, 16.131254196167, true)

			if useelevdist < 10 then
			DrawMarker(27,10.401641845703, -671.09283447266, 33.44958114634 -0.9,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
			DrawText3DTest(10.401641845703, -671.09283447266, 33.44958114634 ,"~b~[G]~w~ to use")
			end

			if secondelevdist < 10 then
				DrawMarker(27,-0.058524839580059, -705.50958251953, 16.131254196167 -0.9,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
				DrawText3DTest(-0.058524839580059, -705.50958251953, 16.131254196167 ,"~b~[G]~w~ to use")
				end

			if IsControlJustPressed(0,58) and useelevdist < 2 then
				SetEntityCoords(PlayerPedId(), -0.058524839580059, -705.50958251953, 16.131254196167)
				SetEntityHeading(PlayerPedId(), 337.29156494141)
			end

			if IsControlJustPressed(0,58) and secondelevdist < 2 then
				SetEntityCoords(PlayerPedId(), 10.401641845703, -671.09283447266, 33.44958114634)
				SetEntityHeading(PlayerPedId(), 160.0)
			end
        end
    end)
end
	

local hackwait = 2000
Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(hackwait)

		if Elevator then
			hackwait = 5

			local player = GetEntityCoords(PlayerPedId())
			local HackOne = GetDistanceBetweenCoords(player.x,player.y,player.z, 1.2931152582169, -697.89251708984, 16.131048202515, true)
			local HackTwo  = GetDistanceBetweenCoords(player.x,player.y,player.z, 9.428394317627, -707.52301025391, 16.131048202516, true)

			if HackOne < 2 and not hackedone then
				DrawMarker(30,1.2931152582169, -697.89251708984, 16.131048202515,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
				DrawText3DTest(1.2931152582169, -697.89251708984, 16.131048202515 ,"~g~[G]~w~ to hack")
				

				if IsControlJustPressed(0,58) then
					ESX.TriggerServerCallback('Union:HasItem', function(cb) 
						hasitem = cb
					end, args)

					local p = exports["taskbar"]:taskBar(2000,"Connecting Laptop")
				        if p == 100 then

					    if hasitem == true then
							hackedone = true
							SpawnNPC()
							TriggerEvent("mhacking:show")
							TriggerEvent("mhacking:start", 3,15,Hackone)
					    else
					    	exports['mythic_notify']:SendAlert('error', 'Im missing something?!')
					    end
				    end
			    end
			end


			if HackTwo < 2 and not hackedtwo then
				DrawMarker(30,9.428394317627, -707.52301025391, 16.131048202516,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
				DrawText3DTest(9.428394317627, -707.52301025391, 16.131048202516 ,"~g~[G]~w~ to hack")

				if IsControlJustPressed(0,58) then
					ESX.TriggerServerCallback('Union:HasItem', function(cb) 
						hasitem = cb
					end, args)

					local p = exports["taskbar"]:taskBar(2000,"Connecting Laptop")
				        if p == 100 then

							if hasitem == true then 
								hackedtwo = true
								TriggerEvent("mhacking:show")
								TriggerEvent("mhacking:start", 3,15,Hacktwo)
							else
								exports['mythic_notify']:SendAlert('error', 'Im missing something?!')
							end
						end
			    end
			end
		end
	end
end)



function Hackone(success,timeremaining)
   if success then
	hackonesuccess = true
	TriggerEvent('mhacking:hide')
	TriggerEvent("Open:Union:Vault", "Union")
   else 
	exports['mythic_notify']:SendAlert('error', 'You Dumb? Go get another Electronic Kit')
	TriggerEvent('mhacking:hide')
   end
end

function Hacktwo(success,timeremaining)
	if success then
		hacktwosuccess = true
	 TriggerEvent('mhacking:hide')
	 TriggerEvent("Open:Union:Vault", "Union")
	else 
		exports['mythic_notify']:SendAlert('error', 'You Dumb? Go get another Electronic Kit')
	 TriggerEvent('mhacking:hide')
	end
 end



RegisterNetEvent("Open:Union:Vault")
AddEventHandler("Open:Union:Vault", function(DoorType)
	if DoorType == "Union" then
		if hackonesuccess and hacktwosuccess then
            local door = GetClosestObjectOfType(-1.727947, -686.5417, 16.68913,25.0,-1932297301, 0,0,0)
	        local currentHeading = GetEntityHeading(door)

	        SetEntityHeading(door, 250)

	        FreezeEntityPosition(door,true)

	        currentHeading = GetEntityHeading(door)
			UnionOpen = true
			closetime = Config.Time 
			Countdown()
		end
	end
end)


RegisterNetEvent("Close:Union:Vault")
AddEventHandler("Close:Union:Vault", function(DoorType)

	if DoorType == "Union" then
       local door = GetClosestObjectOfType(-1.727947, -686.5417, 16.68913,25.0,-1932297301, 0,0,0)
	   local currentHeading = GetEntityHeading(door)

	   SetEntityHeading(door, 159.70484924316)

	   FreezeEntityPosition(door,true)

	   currentHeading = GetEntityHeading(door)
	end
end)
		


RegisterNetEvent("Close:Union:Doors")
AddEventHandler("Close:Union:Doors", function(DoorType,object,coord,objaw,open)
	if DoorType == "small" then
		if open == "false" then
        local door = GetClosestObjectOfType(coord.x,coord.y,coord.z,25.0, object, 0,0,0)
	    local currentHeading = GetEntityHeading(door)

	    SetEntityHeading(door, objaw)

	    FreezeEntityPosition(door,true)

	    currentHeading = GetEntityHeading(door)
		end
	end
end)

RegisterNetEvent("Open:Union:door")
AddEventHandler("Open:Union:door", function(DoorType,coord,object)
	if DoorType == "small" then
		    
            local door = GetClosestObjectOfType(coord.x,coord.y,coord.z,25.0,object, 0,0,0)
	        local currentHeading = GetEntityHeading(door)

	        SetEntityHeading(door, 0)

	        FreezeEntityPosition(door,false)

	        currentHeading = GetEntityHeading(door)
		end
end)

local doors = {}


Citizen.CreateThread(function()
	if Config.Closed == true then
	   TriggerEvent("Close:Union:Vault", "Union")
	end

	-- print("running")
	for k,v in pairs(Config.Doors) do
        --   print("Id = "..k.. " - "  ..json.encode(v))
		  doors = Config.Doors
		  TriggerEvent("Close:Union:Doors","small",v.obj,v.objcoord,v.objyaw,v.Opened)
	end
end) 






local blowtorchwait = 5000
Citizen.CreateThread(function()
    while true do 
		Citizen.Wait(blowtorchwait)
		if UnionOpen then
			blowtorchwait = 2
			local player = GetEntityCoords(PlayerPedId())

			for l,o in pairs(doors) do
			    local distblow = GetDistanceBetweenCoords(player.x,player.y,player.z, o.objcoord, true)

				if distblow < 2 and o.Opened == "false" then

			    DrawMarker(30,o.objcoord.x, o.objcoord.y, o.objcoord.z,0,0,0,0,0,0,0.6,0.6,0.5001,0,179,255,200,0,0,0,1)
			    DrawText3DTest(o.objcoord.x, o.objcoord.y, o.objcoord.z ,"~r~[G]~w~ Blowtorch")

				if IsControlJustPressed(0,58) then

					ESX.TriggerServerCallback('Union:HasItem:blowtorch', function(cb) 
						hasblowtorch = cb
					end, args)


					local p = exports["taskbar"]:taskBar(2000,"Blowtorching")
					if p == 100 then
					TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, true) --WORLD_HUMAN_SEAT_WALL_TABLET
					if hasblowtorch then
						ClearPedTasksImmediately(PlayerPedId())
						
					        TriggerEvent("Open:Union:door","small",o.objcoord,o.obj)
							o.Opened = "true"
							Config.Doors[l].Opened = "true"
						else
							exports['mythic_notify']:SendAlert('error', 'Im missing something?!')
						end
					end
			end
		end
	end

	for p,s in pairs(Config.LootPoints) do
		if s.Looted == "false" then
		    DrawMarker(1,s.coords.x,s.coords.y,s.coords.z - 0.9,0,0,0,0,0,0,0.8,0.8,0.8,   81, 10, 249, 250,0,0,0,1)

            local distSEARCH = GetDistanceBetweenCoords(player.x,player.y,player.z, s.coords, true)

			if distSEARCH < 0.8 then
			    ESX.ShowHelpNotification("[E] to search")

				if IsControlJustPressed(0,38) then

					RequestAnimDict("mini@repair")
				    while not HasAnimDictLoaded("mini@repair") do
					Citizen.Wait(0)
				    end
		             TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_ped", 8.0, -8.0, -1, 1, 0, false, false, false)
					
					local p = exports["taskbar"]:taskBar(10000,"Searching")
					if p == 100 then

                    ClearPedTasks(PlayerPedId())
					s.Looted = "true"

					TriggerServerEvent("Looted:Union",distSEARCH)
					end
				end
			end

	    end
    end


end
end
end)




function Countdown()
	while UnionOpen do
		Citizen.Wait(1000)
		closetime = closetime - 1
		if closetime <= 20 then
			ESX.ShowHelpNotification("Vault Is Closing")
		end

		if closetime <= 0 then
			for k,v in pairs(Config.Doors) do
				v.Opened = "false"
				  TriggerEvent("Union:Doors","small",v.obj,v.objcoord,v.objyaw,v.Opened)
			end

			TriggerEvent("Close:Union:Vault", "Union")
			UnionOpen = false
			hackonesuccess = true
	        hacktwosuccess = true
			break
		end
	end
end




















































































































function SpawnNPC()
	if Config.SpawnGuards then
		local ped = PlayerPedId()

		local guard = GetHashKey("s_m_m_security_01")
	
		RequestModel(guard)
	
	
	
		while not HasModelLoaded(guard) do
	
			Citizen.Wait(0)
	
		end
	
		local guardstrong = GetHashKey("csb_mweather")
	
		RequestModel(guardstrong)
	
	
	
		while not HasModelLoaded(guardstrong) do
	
			Citizen.Wait(0)
	
		end
	
	
		Citizen.Wait(500)
	
		local GuardOne = CreatePed(0, guard, 5.91712895629272, -709.24987792969, 16.16102722168,true)
		
		SetEntityInvincible(GuardOne, false)
	
		SetEntityAsMissionEntity(GuardOne)
	
		SetPedDropsWeaponsWhenDead(GuardOne,false)
	
	
		SetPedAsCop(GuardOne,true)
	
		SetCanAttackFriendly(GuardOne,false,true)
	
		GiveWeaponToPed(GuardOne, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardOne, ped, 0, 16)
	
	
	
		local GuardTwo = CreatePed(0, guard, 5.91712895629272, -709.24987792969, 16.16102722168,true)
	
		SetEntityInvincible(GuardTwo, false)
	
		SetEntityAsMissionEntity(GuardTwo)
	
		SetPedDropsWeaponsWhenDead(GuardTwo,false)
	
	
		SetPedAsCop(GuardTwo,true)
	
		SetCanAttackFriendly(GuardTwo,false,true)
	
		GiveWeaponToPed(GuardTwo, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardTwo, ped, 0, 16)
	
	
	
		local GuardThree = CreatePed(0, guard, 5.91712895629272, -709.24987792969, 16.16102722168,true)
	
		SetEntityInvincible(GuardThree, false)
	
		SetEntityAsMissionEntity(GuardThree)
	
		SetPedDropsWeaponsWhenDead(GuardThree,false)
	
	
		SetPedAsCop(GuardThree,true)
	
		SetCanAttackFriendly(GuardThree,false,true)
	
		GiveWeaponToPed(GuardThree, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardThree, ped, 0, 16)
	
	
	
		local GuardFour = CreatePed(0, guardstrong, 5.91712895629272, -709.24987792969, 16.16102722168,true)
	
		SetEntityInvincible(GuardFour, false)
	
		SetEntityAsMissionEntity(GuardFour)
	
		SetPedDropsWeaponsWhenDead(GuardFour,false)
	
	
		SetPedAsCop(GuardFour,true)
	
		SetCanAttackFriendly(GuardFour,false,true)
	
		GiveWeaponToPed(GuardFour, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardFour, ped, 0, 16)
	

		-- Second --

		local GuardFive = CreatePed(0, guard, 9.8964557647705, -700.65899658203, 16.13102722168,true)
		
		SetEntityInvincible(GuardFive, false)
	
		SetEntityAsMissionEntity(GuardFive)
	
		SetPedDropsWeaponsWhenDead(GuardFive,false)
	
	
		SetPedAsCop(GuardFive,true)
	
		SetCanAttackFriendly(GuardFive,false,true)
	
		GiveWeaponToPed(GuardFive, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardFive, ped, 0, 16)
	
	
	
		local GuardSix = CreatePed(0, guard, 9.8964557647705, -700.65899658203, 16.13102722168,true)
	
		SetEntityInvincible(GuardSix, false)
	
		SetEntityAsMissionEntity(GuardSix)
	
		SetPedDropsWeaponsWhenDead(GuardSix,false)
	
	
		SetPedAsCop(GuardSix,true)
	
		SetCanAttackFriendly(GuardSix,false,true)
	
		GiveWeaponToPed(GuardSix, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardSix, ped, 0, 16)
	
	
	
		local GuardSeven = CreatePed(0, guard,9.8964557647705, -700.65899658203, 16.13102722168,true)
	
		SetEntityInvincible(GuardSeven, false)
	
		SetEntityAsMissionEntity(GuardSeven)
	
		SetPedDropsWeaponsWhenDead(GuardSeven,false)
	
	
		SetPedAsCop(GuardSeven,true)
	
		SetCanAttackFriendly(GuardSeven,false,true)
	
		GiveWeaponToPed(GuardSeven, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardSeven, ped, 0, 16)
	
	
	
		local GuardEight = CreatePed(0, guardstrong, 9.8964557647705, -700.65899658203, 16.13102722168,true)
	
		SetEntityInvincible(GuardEight, false)
	
		SetEntityAsMissionEntity(GuardEight)
	
		SetPedDropsWeaponsWhenDead(GuardEight,false)
	
		SetPedAsCop(GuardEight,true)
	
		SetCanAttackFriendly(GuardEight,false,true)
	
		GiveWeaponToPed(GuardEight, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardEight, ped, 0, 16)




		--- third ---

		local GuardNine = CreatePed(0, guard, -0.33279722929001, -694.49792480469, 16.130815505981 ,true)
		
		SetEntityInvincible(GuardNine, false)
	
		SetEntityAsMissionEntity(GuardNine)
	
		SetPedDropsWeaponsWhenDead(GuardNine,false)
	
	
		SetPedAsCop(GuardNine,true)
	
		SetCanAttackFriendly(GuardNine,false,true)
	
		GiveWeaponToPed(GuardNine, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardNine, ped, 0, 16)
	
	
	
		local GuardTen = CreatePed(0, guard,-0.33279722929001, -694.49792480469, 16.130815505981 ,true)
	
		SetEntityInvincible(GuardTen, false)
	
		SetEntityAsMissionEntity(GuardTen)
	
		SetPedDropsWeaponsWhenDead(GuardTen,false)
	
	
		SetPedAsCop(GuardTen,true)
	
		SetCanAttackFriendly(GuardTen,false,true)
	
		GiveWeaponToPed(GuardTen, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardTen, ped, 0, 16)
	
	
	
		local GuardEleven = CreatePed(0, guard,-0.33279722929001, -694.49792480469, 16.130815505981 ,true)
	
		SetEntityInvincible(GuardEleven, false)
	
		SetEntityAsMissionEntity(GuardEleven)
	
		SetPedDropsWeaponsWhenDead(GuardEleven,false)
	
	
		SetPedAsCop(GuardEleven,true)
	
		SetCanAttackFriendly(GuardEleven,false,true)
	
		GiveWeaponToPed(GuardEleven, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(GuardEleven, ped, 0, 16)
	
	
	
		local GuardTwelve = CreatePed(0, guardstrong, -0.33279722929001, -694.49792480469, 16.130815505981 ,true)

		SetEntityInvincible(GuardTwelve, false)
	
		SetEntityAsMissionEntity(GuardTwelve)
	
		SetPedDropsWeaponsWhenDead(GuardTwelve,false)
	
		SetPedAsCop(GuardTwelve,true)
	
		SetCanAttackFriendly(GuardTwelve,false,true)
	
		GiveWeaponToPed(GuardTwelve, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(GuardTwelve, ped, 0, 16)
	 


		--- Fourth ---

		local Guard13 = CreatePed(0, guard, -14.952754020691, -694.77008056641, 16.131036758423 ,true)
		
		SetEntityInvincible(Guard13, false)
	
		SetEntityAsMissionEntity(Guard13)
	
		SetPedDropsWeaponsWhenDead(Guard13,false)
	
	
		SetPedAsCop(Guard13,true)
	
		SetCanAttackFriendly(Guard13,false,true)
	
		GiveWeaponToPed(Guard13, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(Guard13, ped, 0, 16)
	
	
	
		local Guard14 = CreatePed(0, guard,-14.952754020691, -694.77008056641, 16.131036758423 ,true)
	
		SetEntityInvincible(Guard14, false)
	
		SetEntityAsMissionEntity(Guard14)
	
		SetPedDropsWeaponsWhenDead(Guard14,false)
	
	
		SetPedAsCop(Guard14,true)
	
		SetCanAttackFriendly(Guard14,false,true)
	
		GiveWeaponToPed(Guard14, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(Guard14, ped, 0, 16)
	
	
	
		local Guard15 = CreatePed(0, guard,-14.952754020691, -694.77008056641, 16.131036758423 ,true)
	
		SetEntityInvincible(Guard15, false)
	
		SetEntityAsMissionEntity(Guard15)
	
		SetPedDropsWeaponsWhenDead(Guard15,false)
	
	
		SetPedAsCop(Guard15,true)
	
		SetCanAttackFriendly(Guard15,false,true)
	
		GiveWeaponToPed(Guard15, GetHashKey("WEAPON_ADVANCEDRIFLE"), 1000, false, true)
	
		TaskCombatPed(Guard15, ped, 0, 16)
	
	
	
		local Guard16 = CreatePed(0, guardstrong, -14.952754020691, -694.77008056641, 16.131036758423 ,true)

		SetEntityInvincible(Guard16, false)
	
		SetEntityAsMissionEntity(Guard16)
	
		SetPedDropsWeaponsWhenDead(Guard16,false)
	
		SetPedAsCop(Guard16,true)
	
		SetCanAttackFriendly(Guard16,false,true)
	
		GiveWeaponToPed(Guard16, GetHashKey("WEAPON_assaultsmg"), 1000, false, true)
	
		TaskCombatPed(Guard16, ped, 0, 16)

	end
 end


 
RegisterNetEvent('Tronix:copblip')
AddEventHandler('Tronix:copblip', function(cx,cy,cz)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		local alpha = 250
		copblip = AddBlipForCoord(cx,cy,cz)
        SetBlipSprite(copblip , 161)
        SetBlipScale(copblip , 2.0)
	    SetBlipColour(copblip, 8)
	    PulseBlip(copblip)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('(Union Depository Robbery) ONGOING!')
		EndTextCommandSetBlipName(copblip)

		while alpha ~= 0 do
			Citizen.Wait(120 * 4)
			alpha = alpha - 1
			SetBlipAlpha(copblip,	 alpha)

		if alpha == 0 then
			RemoveBlip(copblip)
		return
      end
    end
  end
end)

