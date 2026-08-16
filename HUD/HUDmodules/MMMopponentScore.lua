--MMMopponentScore.lua
local t = {}

function t.create()
    if hideHud or (not opponentStrums) then return end

    t.strums = HUDmodules[4]
    t.tag = "opponentStrums"

    makeLuaText("MMMopponentScore", "Accuracy: -", 0, 0, 0)
    if middlescroll then
        setTextSize("MMMopponentScore", 19)
    else
        setTextSize("MMMopponentScore", 21)
    end
    setTextFont("MMMopponentScore", "RobotoMono-Regular.ttf")
    setTextBorder("MMMopponentScore", 2, 'black')
    addLuaText("MMMopponentScore")

    t.resize(getProperty("camHUD.width"))
end

function t.resize(newWidth)
    if hideHud or (not opponentStrums) then return end

    t.width = (t.strums.width + t.strums[t.tag].noteSpacing)*keyCount

    if middlescroll then
        t.x = t.strums[t.tag].x - t.width / 4 + 7
        if downscroll then
            t.y = t.strums[t.tag].y + 84
        else
            t.y = t.strums[t.tag].y - 2
        end
    else
        t.x = t.strums[t.tag].x
        if downscroll then
            t.y = t.strums[t.tag].y + 121
        else
            t.y = t.strums[t.tag].y - 45
        end
    end

    setTextWidth("MMMopponentScore", t.width)
    setProperty("MMMopponentScore.x", t.x)
    setProperty("MMMopponentScore.y", t.y)
end

return t
