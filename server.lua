RegisterNetEvent("nexgen:checkace:server")
AddEventHandler("nexgen:checkace:server", function()
    local source = source
    if IsPlayerAceAllowed(source, Config.aceperm) then
        TriggerClientEvent("nexgen:fetchace:client", source, true)
    else 
        TriggerClientEvent("nexgen:fetchace:client", source, false)
    end 
end)
