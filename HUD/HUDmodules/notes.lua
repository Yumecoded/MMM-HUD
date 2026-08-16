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
    if getPropertyFromGroup("notes", id, "mustPress") == playsAsBF() then
        setPropertyFromGroup("notes", id, "scale.x", t.strums.playerStrums.scale)
        if not isSustainNote then
            setPropertyFromGroup("notes", id, "scale.y", t.strums.playerStrums.scale)
        end
    else
        if middlescroll then
            local multSpeed = getPropertyFromGroup("notes", id, "multSpeed")
            setPropertyFromGroup("notes", id, "multSpeed", multSpeed*0.25)
        end

        setPropertyFromGroup("notes", id, "scale.x", t.strums.opponentStrums.scale)
        if not isSustainNote then
            setPropertyFromGroup("notes", id, "scale.y", t.strums.opponentStrums.scale)
        end
    end
end

return t
