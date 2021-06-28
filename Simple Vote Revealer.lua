local localName = g_CVar:FindVar("name")

local function main(e)

    if e:GetName() == 'vote_cast' then

        vote = e:GetInt("vote_option")
        entID = e:GetInt("entityid")

        local entity = g_EntityList:GetClientEntity(entID)
        local player = entity:GetPlayer()
        local playerName = player:GetName()

        if vote == 0 then vote = 'Yes' else vote = 'No' end

        cheat.AddNotify("Simple Vote Revealer", string.format("%s voted %s", playerName:upper(), vote:upper()))

    end

end


cheat.RegisterCallback("events", main)