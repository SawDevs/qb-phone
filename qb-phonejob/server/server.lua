QBCore.Commands.Add("phonebalance", "Open balance menu for business owner. (Business Only)", {}, false, function(source, args)
    local src = source
    if checkPerm(src) then
        TriggerClientEvent('qb-phonejob:Client:OpenMenu', src)
    end
end)

QBCore.Functions.CreateCallback('qb-phonejob:Server:BuyBalance', function(source, cb, data)
	local src = source
    print(data.phone)
    local Target = QBCore.Functions.GetPlayerByPhone(data.phone)
    local targetCitizenId = Target.PlayerData.citizenid
    local Player = QBCore.Functions.GetPlayer(src)

    local cashBalance = Player.PlayerData.money["cash"]
    local bankBalance = Player.PlayerData.money["bank"]
    
    if Target ~= nil then
        local targetPhoneCache = Target.PlayerData.metadata["phonecachedata"]
        print(json.encode(targetPhoneCache))
        print(json.encode(targetCitizenId))
        print(targetPhoneCache[targetCitizenId].phone)

        if targetPhoneCache[targetCitizenId].phone ~= false then
            if cashBalance >= data.price then
                targetPhoneCache[targetCitizenId].balance = targetPhoneCache[targetCitizenId].balance + data.credit
                Target.Functions.SetMetaData("phonecachedata", targetPhoneCache)
                cb(true)
            elseif bankBalance >= data.price then
                targetPhoneCache[targetCitizenId].balance = targetPhoneCache[targetCitizenId].balance + data.credit
                Target.Functions.SetMetaData("phonecachedata", targetPhoneCache)
                cb(true)
            else
                cb(false)
            end
        else
            cb("nosim")
        end
    else
        cb("notonline")
    end


    
end)

function checkPerm(source)
    return true
end