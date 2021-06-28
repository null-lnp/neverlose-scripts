-- REFERENCES -- 

local autoPeek = g_Config:FindVar("Miscellaneous", "Main", "Movement", "Auto Peek")

-- REFERENCES -- 

-- LUA BODY -- 

local function main()

    local is_connected = g_EngineClient:IsConnected()

        if is_connected then

        local localplayer = g_EntityList:GetClientEntity(g_EngineClient:GetLocalPlayer())
        local getplayer = localplayer:GetPlayer()
        local localPlayerHealth = getplayer:GetProp("DT_BasePlayer", "m_iHealth")

        if not (localPlayerHealth > 0) then
            return
        end

        local active_weapon = getplayer:GetActiveWeapon()
        local activeWeaponID = active_weapon:GetWeaponID()

        if activeWeaponID == nil then
            return
        end

        if tonumber(activeWeaponID) == 64 then
            exploits.OverrideDoubleTapSpeed(15)
            return
        end


        if autoPeek:GetBool() then

            exploits.OverrideDoubleTapSpeed(62)
            return

        end

        exploits.OverrideDoubleTapSpeed(13)

    end

end

local function rageFire()

    if autoPeek:GetBool() then

        exploits.ForceCharge()
        exploits.ForceTeleport()

    end

end

-- LUA BODY -- 

cheat.RegisterCallback("draw", main)
cheat.RegisterCallback("ragebot_shot", rageFire)