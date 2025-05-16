local vehicle = nil
local topspeedms = nil
local selectedgear = 0
local manualon = false
local currspeedlimit = nil
local realistic = false

-- Global variable
isInVehicleModel = false

Citizen.CreateThread(function()
    local hasBeenSet = false
    local vehicleModels = { 'sultan', 'tyrus' }

    while true do
        Citizen.Wait(100)

        local player = GetPlayerPed(-1)
        local vehicle = GetVehiclePedIsIn(player, false)
        local model = GetEntityModel(vehicle)
        isInVehicleModel = false
        for i, modelName in ipairs(vehicleModels) do
            if model == GetHashKey(modelName) then
                isInVehicleModel = true
                break
            end
        end

        if IsPedInAnyVehicle(player, false) and isInVehicleModel then
            if not hasBeenSet then
                manualon = true
                print("A manual car? cool cool")
                hasBeenSet = true
            end
        else
            manualon = false
            hasBeenSet = false
        end
    end
end)

function getinfo(gea)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)

    local vehicleClass = GetVehicleClass(vehicle)

    if isInVehicleModel then
        if gea == 0 then
            return "N"
        elseif gea == -1 then
            return "R"
        else
            return gea
        end
    else
        if vehicleClass ~= 15 and vehicleClass ~= 16 then
            return GetVehicleCurrentGear(vehicle)
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        realistic = true
    end
end)

local disable = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if realistic == true then
            if manualon == true and vehicle ~= nil then
                if selectedgear > 1 then
                    if IsControlPressed(0, 71) then
                        local speed = GetEntitySpeed(vehicle)
                        local minspeed = currspeedlimit / 7

                        if speed < minspeed then
                            if GetVehicleCurrentRpm(vehicle) < 0.4 then
                                disable = true
                            end
                        end
                    end
                end
            else
                Citizen.Wait(100)
            end
        else
            Citizen.Wait(100)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if disable == true then
            SetVehicleEngineOn(vehicle, false, true, false)
            Citizen.Wait(1000)

            disable = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if vehicle ~= nil and selectedgear ~= 0 then
            local speed = GetEntitySpeed(vehicle)

            if currspeedlimit ~= nil then
                if speed >= currspeedlimit then
                    if Config.enginebrake == true then
                        if speed / currspeedlimit > 1.1 then
                            --print('dead')
                            local hhhh = speed / currspeedlimit
                            SetVehicleCurrentRpm(vehicle, hhhh)
                            SetVehicleCheatPowerIncrease(vehicle, -100.0)
                        else
                            SetVehicleCheatPowerIncrease(vehicle, 0.0)
                        end
                    else
                        SetVehicleCheatPowerIncrease(vehicle, 0.0)
                    end
                end
            else
                if speed >= topspeedms then
                    SetVehicleCheatPowerIncrease(vehicle, 0.0)
                end
            end
        end
    end
end)

function round(value, numDecimalPlaces)
    if numDecimalPlaces then
        local power = 10 ^ numDecimalPlaces
        return math.floor((value * power) + 0.5) / (power)
    else
        return math.floor(value + 0.5)
    end
end

function getSelectedGear()
    return selectedgear
end
