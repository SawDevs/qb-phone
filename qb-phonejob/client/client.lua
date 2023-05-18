function openMenu()
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "open",
        config = Config,
    })
end

function closeMenu()
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "close"
    })
end

RegisterNetEvent('qb-phonejob:Client:OpenMenu')
AddEventHandler('qb-phonejob:Client:OpenMenu', function()
    openMenu()
    print("Menu opened")
end)

RegisterNUICallback('closeMenu', function(data, cb)
    closeMenu()
end)

RegisterNUICallback('notify', function(data, cb)
    QBCore.Functions.Notify(data.text, "error", 2500)
end)

RegisterNUICallback('payment', function(data, cb)
    QBCore.Functions.TriggerCallback('qb-phonejob:Server:BuyBalance', function(za)
        if za == true then
            QBCore.Functions.Notify(data.phone .. " Buyed " .. data.credit .. " credit for " .. data.price .. "$.", "success", 2500)
            closeMenu()
        elseif za == "nosim" then
            QBCore.Functions.Notify("Sim not found!", "error", 2500)
        elseif za == "notonline" then
            QBCore.Functions.Notify("Player is not online!", "error", 2500)
        else
            QBCore.Functions.Notify("Not enough money!", "error", 2500)
        end
        print(za)
        print(json.encode(data))
    end, data)
end)
