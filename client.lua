local playerAce = false
local isSpeedSet = false

-- Client Events

RegisterNetEvent("nexgen:fetchace:client")
AddEventHandler("nexgen:fetchace:client", function(boolean)
    playerAce = boolean
end)

-- Threads

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        
        while not IsPedInAnyVehicle(PlayerPedId(), false) do
            Citizen.Wait(2500)
        end

        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local currentSpeed = GetEntitySpeed(vehicle)

        if (currentSpeed == 0) then
            Citizen.Wait(2000)
        end

        if vehicle ~= nil then
            isSpeedSet = false
            setSpeed(vehicle)
        end
        
        while isSpeedSet and IsPedInAnyVehicle(PlayerPedId(), false) do
            local currentVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            if currentVeh ~= vehicle then
                setSpeed(currentVeh)
            end
            Citizen.Wait(2500)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerServerEvent('nexgen:fetchace:server)
end)

-- Functions

function setSpeed(vehicle)
    local vehicleClass = GetVehicleClass(vehicle)
    local source = GetPlayerServerId(PlayerId())
    
    if playerAce == true then
        print("Player has bypass permission")
        return
    end
    
    if vehicleClass == 16 or vehicleClass == 15 then
        print("Vehicle is exempt from speed limit")
        return
    end
    
    local speed = Config.maxSpeed
    if Config.kmh then
        speed = speed / 3.6 -- Convert max speed to km/h if Config.kmh is true
    else
        speed = speed / 2.23694 -- Convert max speed to mph if Config.kmh is false
    end
    
    SetVehicleMaxSpeed(vehicle, speed)
    isSpeedSet = true
    print("Speed limit set to " .. speed)
end
