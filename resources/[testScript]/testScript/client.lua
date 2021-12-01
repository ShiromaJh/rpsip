RegisterCommand('car', function(source, args)
    -- account for the arg not being passed--
    local vehicleName = args[1] or 'adder'

    -- test to see if vehivle exists--
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName)then
        TriggerEvent('chat:addMessage', {
            args ={'Good One Bud'}
        })
        return
    end

    --load model --
    RequestModel(vehicleName)

    --wait--
    while not HasModelLoaded(vehicleName)do
        Wait(500)
    end

    --get player postion--
    local playerPed = PlayerPedId() --get player id--
    local pos = GetEntityCoords(playerPed) --get the position of player ped--

    --create vehicle--

    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)
    -- local vehicle = CreateVehicle(vehicleName, pos.x pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    --set player ped in driver seat--
    SetPedIntoVehicle(playerPed, vehicle, -1)

    --give vehicle back to game--
    SetEntityAsNoLongerNeeded(vehicle)

    --release model--
    SetModelAsNoLongerNeeded(vehicleName)

    --tell player vehicle is spawned in--
    TriggerEvent('chat:addMessage', {
        args = {'You have Spawned a ' .. vehicleName.. '.'}
    })
end, false)

RegisterCommand('dv', function()
    --get local player ped--
    local playerPed = PlayerPedId()
    --get vehicle play is in--
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    --delete--
    DeleteEntity(vehicle)
end, false)