--strums.lua
local t = {}

function t.positionStrums()
    for i=0, mania do
        setPropertyFromGroup("playerStrums", i, "alpha", 1)
        setPropertyFromGroup("opponentStrums", i, "alpha", 1)

        setPropertyFromGroup(t.opponentStrumsTag, i, "visible", opponentStrums)

        for _,v in ipairs({{t.playerStrumsTag, "playerStrums"}, {t.opponentStrumsTag, "opponentStrums"}}) do
            local x = t[v[1]].x
            local y = t[v[1]].y
            local noteSpacing = t[v[1]].noteSpacing
            local scale = t[v[1]].scale
            if noteSkinPostfix == "-pixel" then
                scale = scale*6
            end
            local width = t[v[1]].width

            setPropertyFromGroup(v[2], i, "x", x + (width or t.width)*i + noteSpacing*i)
            setPropertyFromGroup(v[2], i, "y", y)
            if scale then
                setPropertyFromGroup(v[2], i, "scale.x", scale)
                setPropertyFromGroup(v[2], i, "scale.y", scale)
            end

            setPropertyFromGroup(v[2], i, "angle", 0)
            setPropertyFromGroup(v[2], i, "direction", 90)
        end
    end
end

function t.create()
    if playsAsBF() then
        t.playerStrumsTag = "playerStrums"
        t.opponentStrumsTag = "opponentStrums"
    else
        t.playerStrumsTag = "opponentStrums"
        t.opponentStrumsTag = "playerStrums"
    end

    t.width = 109

    t.resize(getProperty("camHUD.width"))
    t.positionStrums()
end

function t.resize(newWidth)
    t.left = {}
    if middlescroll and playsAsBF() then
        t.left.noteSpacing = 6
        t.left.scale = 0.25
        t.left.offset = 0.042
        t.left.width = 38.5
    else
        t.left.noteSpacing = 12
        t.left.width = 185 - 20 * math.min(keyCount, 5) - 10 * math.max(keyCount - 5, 0)
        t.left.scale = t.left.width/157
        t.left.offset = 0.052
    end
    t.left.x = newWidth*t.left.offset
    if downscroll then
        t.left.y = 525

        if middlescroll and playsAsBF() then
            t.left.y = t.left.y - 69
        end
    else
        t.left.y = 69

        if middlescroll and playsAsBF() then
            t.left.y = t.left.y + 87
        end
    end

    t.right = {}
    if middlescroll and (not playsAsBF()) then
        t.right.noteSpacing = 6
        t.right.scale = 0.25
        t.right.offset = 0.093
        t.right.width = 38.5
    else
        t.right.noteSpacing = 12
        t.right.width = 185 - 20 * math.min(keyCount, 5) - 10 * math.max(keyCount - 5, 0)
        t.right.scale = t.right.width/157
        t.right.offset = 0.052
    end
    t.right.x = newWidth - keyCount * (t.right.width or t.width) - keyCount * t.right.noteSpacing - newWidth*t.right.offset
    if downscroll then
        t.right.y = 525

        if middlescroll and (not playsAsBF()) then
            t.right.y = t.right.y - 69
        end
    else
        t.right.y = 69

        if middlescroll and (not playsAsBF()) then
            t.right.y = t.right.y + 87
        end
    end

    if playsAsBF() then
        t.opponentStrums = t.left
        t.playerStrums = t.right
    else
        t.playerStrums = t.left
        t.opponentStrums = t.right
    end

    if middlescroll then
        t.playerStrums.x = newWidth/2 - (keyCount*t.width + keyCount*t.playerStrums.noteSpacing)/2
        if downscroll then
            t.playerStrums.y = t.playerStrums.y + 25
        else
            t.playerStrums.y = t.playerStrums.y + 10
        end
    end

    t.positionStrums()
end

function t.onUpdatePost()
    t.positionStrums()
end

return t
