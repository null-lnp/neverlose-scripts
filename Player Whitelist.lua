local totalEntities = {}
local pList = {}
local pListName = {}

-- DYNAMIC ELEMENTS --

local dynamicElements = {}
local dynamicPriorityElement = {}
local dynamicSafetyElement = {}
local dynamicHitSafeElement = {}

-- DYNAMIC ELEMENTS -- 

-- ENT LISTS --

local ignoreEntList = {}
local priorityEntList = {}
local safetyEntList = {}
local hitSafeEntList = {}

-- ENT LISTS -- 

local function onList(list, val)

    for i = 1, #list do

        if list[i] == val then

            return true
        end
    end

    return false

end

local function updateList()

    for i = 1, #pList do

        if not onList(totalEntities, pList[i]) then

            table.insert(dynamicElements, menu.Switch(string.format("%s", pListName[i]), "Whitelist", false))

            table.insert(dynamicPriorityElement, menu.Switch(string.format("%s", pListName[i]), "Priority", false))

            table.insert(dynamicSafetyElement, menu.Switch(string.format("%s", pListName[i]), "Force Safety", false))

            table.insert(dynamicHitSafeElement, menu.MultiCombo(string.format("%s", pListName[i]), "Safety Hitboxes", {"Head", "Arms", "Legs", "Feet"}, 0))

            table.insert(totalEntities, pList[i])

        end

    end


    for i = 1, #totalEntities do

        if not onList(pList, totalEntities[i]) then

            if dynamicElements[i] == nil or dynamicPriorityElement[i] == nil or dynamicSafetyElement == nil or dynamicSafetyElement == nil then
                return
            end

            menu.DestroyItem(dynamicElements[i])
            menu.DestroyItem(dynamicPriorityElement[i])
            menu.DestroyItem(dynamicSafetyElement[i])
            menu.DestroyItem(dynamicHitSafeElement[i])
            table.remove(totalEntities, i)
            table.remove(dynamicElements, i)
            table.remove(dynamicPriorityElement, i)
            table.remove(dynamicSafetyElement, i)
            table.remove(dynamicHitSafeElement, i)
            
        end

    end


end

local function entitiesMonitor()

    pList = {}
    pListName= {}

    local ents = cheat.GetEntitiesByName("CCSPlayer")
    local numPlayers = #ents

    local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
    local getplayer = localplayer:GetPlayer()

    for i = 0, numPlayers do

        i = i + 1

        dtPlayers = g_EntityList:GetClientEntity(i)

        if not (dtPlayers == nil) then

            dtPlayers = dtPlayers:GetPlayer()


            if dtPlayers:IsPlayer() then

                enemyTeamNumber = dtPlayers:GetProp("DT_BaseEntity", "m_iTeamNum")
                localTeamNumber = localplayer:GetProp("DT_BaseEntity", "m_iTeamNum")

                if not (enemyTeamNumber == localTeamNumber) then

                    enemyIndex = dtPlayers:EntIndex()
                    enemyName = dtPlayers:GetName()

                    table.insert(pList, enemyIndex)
                    table.insert(pListName, enemyName)

                end
            end
        end
    end

end

local function doExecute()

    for i = 1, #ignoreEntList do

        ragebot.IgnoreTarget(ignoreEntList[i])

    end

    for i = 1, #priorityEntList do

        ragebot.SetTargetPriority(priorityEntList[i], 100)

    end

    for i = 1, #safetyEntList do

        ragebot.ForceSafety(safetyEntList[i])

    end

    for i = 1, #hitSafeEntList do

        if dynamicHitSafeElement[i] == nil then

            return

        end

        if dynamicHitSafeElement[i]:GetBool(0) then

            ragebot.ForceHitboxSafety(hitSafeEntList[i], 0)

        end

        if dynamicHitSafeElement[i]:GetBool(1) then

            ragebot.ForceHitboxSafety(hitSafeEntList[i], 13)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 14)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 15)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 16)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 17)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 17)

        end

        if dynamicHitSafeElement[i]:GetBool(2) then

            ragebot.ForceHitboxSafety(hitSafeEntList[i], 7)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 8)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 9)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 10)

        end

        if dynamicHitSafeElement[i]:GetBool(3) then

            ragebot.ForceHitboxSafety(hitSafeEntList[i], 12)
            ragebot.ForceHitboxSafety(hitSafeEntList[i], 13)

        end

    end

end

local function whiteListCheck()
    
    if #pList == 0 then
        return
    end

    for i = 1, #pList do

        if dynamicElements[i] == nil then

            return

        end
        

        if dynamicElements[i]:GetBool() then

            table.insert(ignoreEntList, pList[i])

        else

            for d = 1, #ignoreEntList do

                if ignoreEntList[d] == pList[i] then

                    table.remove(ignoreEntList, d)

                end

            end

        end

    end

end

local function priorityCheck()

    if #pList == 0 then

        return

    end

    for i = 1, #pList do

        if dynamicPriorityElement[i] == nil then

            return
            
        end

        if dynamicPriorityElement[i]:GetBool() then

            table.insert(priorityEntList, pList[i])

        else

            for d = 1, #priorityEntList do

                if priorityEntList[d] == pList[i] then

                    table.remove(priorityEntList, d)

                end

            end

        end

    end

end

local function safetyCheck()

    if #pList == 0 then

        return

    end

    for i = 1, #pList do

        if dynamicSafetyElement[i] == nil then

            return
            
        end

        if dynamicSafetyElement[i]:GetBool() then

            table.insert(safetyEntList, pList[i])

        else

            for d = 1, #safetyEntList do

                if safetyEntList[d] == pList[i] then

                    table.remove(safetyEntList, d)

                end

            end

        end

    end

end

local function hitSafeCheck()

    if #pList == 0 then

        return

    end

    for i = 1, #pList do

        if dynamicHitSafeElement[i] == nil then

            return
            
        end

        if dynamicHitSafeElement[i]:GetInt() > 0 then

            table.insert(hitSafeEntList, pList[i])

        else

            for d = 1, #hitSafeEntList do

                if hitSafeEntList[d] == pList[i] then

                    table.remove(hitSafeEntList, d)

                end

            end

        end

    end

end

local function main()

    local is_connected = g_EngineClient:IsConnected()

    if is_connected then

        updateList()
        entitiesMonitor()

    else

        pList = {}
        pListName = {}

    end

    -- RESET LISTS FOR SERVER CHANGE -- 

    -- ENT LISTS --

    local ignoreEntList = {}
    local priorityEntList = {}
    local safetyEntList = {}
    local hitSafeEntList = {}

end

local function doChecks()

    local is_connected = g_EngineClient:IsConnected()

    if is_connected then

        whiteListCheck()
        priorityCheck()
        safetyCheck()
        hitSafeCheck()

        return

    end

end

cheat.RegisterCallback("pre_prediction", doExecute)
cheat.RegisterCallback("draw", main)
cheat.RegisterCallback("events", refreshList)
cheat.RegisterCallback("prediction", doChecks)
