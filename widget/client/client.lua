--Debut du script :

local function sendNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
end

RegisterCommand("discord", function(source, args, rawCommand)
    -- lien du discord :
    sendNotification("~b~le discord est : ~r~https://discord.gg/wexU45vH")
    print("discord du créateur : mac'#7803")
end, false)

--Suicide,
--Si vous ne voulez pas la commande "Suicide", suprime de la ligne 18 à 30.
 
RegisterCommand("suicide", function(source, args, rawCommand)
    local ped = PlayerPedId()

    sendNotification("~r~Vous allez vous suicider !")
    
    local health = GetEntityHealth(ped)

    local finalHealt = 0

    SetEntityHealth(ped, finalHealt)

end, false)

-- coordonnées (pour les enlevers, suprimer de la ligne 34 à 36)

RegisterCommand("co", function(source, args, rawCommand)
    local pos = GetEntityCoords(PlayerPedId())
    print(pos.x.." ,"..pos.y..", "..pos.z)
end, false)

-- location de BMX

local hasBmx = false

local colorByState = {
    [true] = {
        r = 255,
        g = 0,
        b = 0
    },

    [false] = {
        r = 0,
        g = 255,
        b = 0
    }
}

Citizen.CreateThread(function()
    while true do
        local interval = 1
        local pos = GetEntityCoords(PlayerPedId())
        local dest = vector3(176.41, -874.06, 30.94)
        local distance = GetDistanceBetweenCoords(pos, dest, true)

        if distance > 30 then
            interval = 200
        else  
            interval = 1
            local color = colorByState[hasBmx]
            DrawMarker(38, 176.41, -874.06, 30.94,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, color.r, color.g, color.b, 170, 0, 1, 2, 0, nil, nil, 0)
            if distance < 1  then
                AddTextEntry("HELP", "Appuyer sur ~INPUT_CONTEXT~ ~s~pour accéder au menu")
                DisplayHelpTextThisFrame("HELP", false)
                if IsControlJustPressed(1, 51) then
                    if hasBmx then
                        sendNotification("~r~vous avez déjà un BMX !")
                    else
                        hasBmx = true
                        local model=GetHashKey("bmx")
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local bmx = CreateVehicle(model, pos, 90.0, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), bmx, -1)
                        print("profitez bien de votre balade !")
                    end
                end
            end
        end

        Citizen.Wait(interval)
    end
end)
