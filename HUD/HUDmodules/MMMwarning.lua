--MMMwarning.lua
local t = {}

function t.create()
    makeLuaText("MMMwarningLeft", "[UNFAIR SONG!]", 0, 0, 0)
    setTextSize("MMMwarningLeft", 20)
    setTextFont("MMMwarningLeft", "RobotoMono-Regular.ttf")
    setTextBorder("MMMwarningLeft", 1, 'black')
    setObjectCamera("MMMwarningLeft", "other")
    setTextColor("MMMwarningLeft", "7b0a2b")
    addLuaText("MMMwarningLeft")
    setProperty("MMMwarningLeft.visible", false)

    makeLuaText("MMMwarningRight", "[UNFAIR SONG!]", 0, 0, 0)
    setTextSize("MMMwarningRight", 20)
    setTextFont("MMMwarningRight", "RobotoMono-Regular.ttf")
    setTextBorder("MMMwarningRight", 1, 'black')
    setObjectCamera("MMMwarningRight", "other")
    setTextColor("MMMwarningRight", "7b0a2b")
    addLuaText("MMMwarningRight")
    setProperty("MMMwarningRight.visible", false)

    local warningText

    if botPlay or replay then
        setTextColor("MMMwarningLeft", "white")
        setTextColor("MMMwarningRight", "white")
        warningText = '['..getProperty("botplayTxt.text"):gsub("\n", " ")..']'
    end

    if warningText then
        setTextString("MMMwarningLeft", warningText)
        setTextString("MMMwarningRight", warningText)

        setProperty("MMMwarningLeft.visible", true)
        setProperty("MMMwarningRight.visible", true)
    end

    setProperty("botplayTxt.y", -1000)

    t.resize(getProperty("camHUD.width"))
end

function t.resize(newWidth)
    t.width = 468
    t.x = getProperty("camHUD.width")*0.05
    t.leftX = t.x + 12
    t.rightX = getProperty("camHUD.width") - t.width - 12 - t.x
    t.y = 7

    setTextWidth("MMMwarningLeft", t.width)
    setProperty("MMMwarningLeft.x", t.leftX)
    setProperty("MMMwarningLeft.y", t.y)

    setTextWidth("MMMwarningRight", t.width)
    setProperty("MMMwarningRight.x", t.rightX)
    setProperty("MMMwarningRight.y", t.y)
end

function t.onUpdatePost(elapsed)
    if botPlay or replay then
        setProperty("MMMwarningLeft.alpha", 1 - math.sin((math.pi * botplaySine) / 180))
        setProperty("MMMwarningRight.alpha", 1 - math.sin((math.pi * botplaySine) / 180))
    end
end

function t.onTweenCompleted(tag, vars)
    if tag == "MMMwarningDisappear1" then
        runTimer(tag, 1/60*12)
    elseif tag == "MMMwarningDisappear2" then
        runTimer(tag, 1/60*6)
    end
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if tag == "MMMwarningDisappear1" then
        setProperty("MMMwarningLeft.alpha", 1)
        setProperty("MMMwarningRight.alpha", 1)

        runTimer("MMMwarningVisible1", 1/60*8)
    elseif tag == "MMMwarningVisible1" then
        doTweenAlpha("MMMwarningDisappear2", "MMMwarningLeft", 0, 1/60*16)
        doTweenAlpha("MMMwarningDisappear2_", "MMMwarningRight", 0, 1/60*16)
    elseif tag == "MMMwarningDisappear2" then
        setProperty("MMMwarningLeft.alpha", 1)
        setProperty("MMMwarningRight.alpha", 1)

        runTimer("MMMwarningVisible2", 1/60*6)
    elseif tag == "MMMwarningVisible2" then
        doTweenAlpha("MMMwarningDisappear3", "MMMwarningLeft", 0, 1/60*16)
        doTweenAlpha("MMMwarningDisappear3_", "MMMwarningRight", 0, 1/60*16)
    end
end

function t.onSongStart()
    if unfairSong and (not botPlay) and (not replay) then
        setProperty("MMMwarningLeft.visible", true)
        setProperty("MMMwarningRight.visible", true)

        doTweenAlpha("MMMwarningDisappear1", "MMMwarningLeft", 0, 1/60*20)
        doTweenAlpha("MMMwarningDisappear1_", "MMMwarningRight", 0, 1/60*20)
    end
end

return t
