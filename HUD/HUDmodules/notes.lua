--notes.lua
local t = {}

function t.create()
    t.strums = HUDmodules[4]
end

function t.onUpdatePost()
    for i=0, getProperty("notes.length")-1 do
        setPropertyFromGroup("notes", i, "alpha", 1)

        if getPropertyFromGroup("notes", i, "mustPress") ~= playsAsBF() then
            if middlescroll then
                if downscroll then
                    setPropertyFromGroup("notes", i, "visible", getPropertyFromGroup("notes", i, "y") >= 120 and opponentStrums)
                else
                    setPropertyFromGroup("notes", i, "visible", getPropertyFromGroup("notes", i, "y") <= 500 and opponentStrums)
                end
            else
                setPropertyFromGroup("notes", i, "visible",  opponentStrums)
            end
        end
    end
end

function t.onSpawnNote(id, data, type, isSustainNote, strumTime)
    local playerScale = t.strums.playerStrums.scale
    local opponentScale = t.strums.opponentStrums.scale
    if getPropertyFromClass("PlayState", "isPixelStage") then
        playerScale = playerScale * 8
        opponentScale = opponentScale * 8
    end

    if getPropertyFromGroup("notes", id, "mustPress") == playsAsBF() then
        setPropertyFromGroup("notes", id, "scale.x", playerScale)
        if not isSustainNote then
            setPropertyFromGroup("notes", id, "scale.y", playerScale)
        end
    else
        if middlescroll then
            local multSpeed = getPropertyFromGroup("notes", id, "multSpeed")
            setPropertyFromGroup("notes", id, "multSpeed", multSpeed*0.25)
        end

        setPropertyFromGroup("notes", id, "scale.x", opponentScale)
        if isSustainNote then
            local animName = getPropertyFromGroup("notes", id, "animation.curAnim.name")
            local isHoldEnd = stringEndsWith(animName, "end")

            if isHoldEnd then
                setPropertyFromGroup("notes", id, "scale.y", opponentScale)
                setPropertyFromGroup("notes", id, "offsetY", -getPropertyFromGroup("notes", id, "height")/2.6)
                print(getPropertyFromGroup("notes", id, "height"))
            end
        else
            setPropertyFromGroup("notes", id, "scale.y", opponentScale)
        end
    end
end

return t
