--MMMratings.lua
local t = {}

function t.resize()
    if hideHud then return end

    t.xOffset = 140
    t.x = {
        [true] = t.strums["playerStrums"].x - t.xOffset,
        [false] = t.strums["playerStrums"].x + (t.strums.width+t.strums["playerStrums"].noteSpacing)*mania + t.xOffset
    }
    if downscroll then
        t.y = t.strums["playerStrums"].y + 70
    else
        t.y = t.strums["playerStrums"].y + 165
    end
end

function t.create()
    if hideHud then return end

    setProperty("showComboNum", false)
    setProperty("showRating", false)

    t.strums = HUDmodules[4]
    t.resize()

    t.timingWindows = {
        getPropertyFromClass("backend.ClientPrefs", "data.sickWindow"),
        getPropertyFromClass("backend.ClientPrefs", "data.goodWindow"),
        getPropertyFromClass("backend.ClientPrefs", "data.badWindow")
    }
    t.ratingNames = {"sick", "good", "bad"}

    if showNoteTiming then
        makeLuaText("MMMnoteTimingRating", "0ms", 0, 0, 0)
        setTextBorder("MMMnoteTimingRating", 1, 'black')
        setTextSize("MMMnoteTimingRating", 20)
        setTextFont("MMMnoteTimingRating", "RobotoMono-Regular.ttf")
        setProperty("MMMnoteTimingRating.alpha", 0)
        addLuaText("MMMnoteTimingRating")
    end
end

function t.getRating(strumTime)
    for i=1, #t.timingWindows do
        if strumTime <= t.timingWindows[i] then
            return t.ratingNames[i]
        end
    end
    return "shit"
end

function t.spawnRating(id, right)
    if middlescroll then right = not right end

    local tag = "MMMrating"
    local i = 1

    if comboStacking then
        while luaSpriteExists(tag..i) do
            i = i + 1
        end
    end

    local strumTimeNoAbs = getSongPosition() - getPropertyFromGroup("notes", id, "strumTime") + ratingOffset
    local strumTime = math.abs(strumTimeNoAbs)

    local x = t.x[right]

    local rating = t.getRating(strumTime)

    if showNoteTiming then
        setProperty("MMMnoteTimingRating.x", x)
        setProperty("MMMnoteTimingRating.y", t.y+35)
        setTextString("MMMnoteTimingRating", math.floor(-strumTimeNoAbs).."ms")
        setTextColor("MMMnoteTimingRating", timingColors[rating])
        setProperty("MMMnoteTimingRating.alpha", 1)
        runTimer("MMMnoteTimingRating", 1)
    end

    makeLuaSprite(tag..i, rating, x, t.y)
    setObjectCamera(tag..i, "hud")
    scaleObject(tag..i, 0.3, 0.3)
    addLuaSprite(tag..i, true)

    setProperty(tag..i..".velocity.y", -319.45)
    setProperty(tag..i..".acceleration.y", 542.52)

    if colorRating then
        setProperty(tag..i..".color", FlxColor(ratingColors[rating]))
    end

    runTimer(tag..i, 1/60*45)
end

function t.goodNoteHit(id, noteData, noteType, isSustainNote)
    if hideHud then return end
    if isSustainNote or disableComboRating then return end

    if playsAsBF() then
        t.spawnRating(id, playsAsBF())
    end
end

function t.opponentNoteHit(id, noteData, noteType, isSustainNote)
    if hideHud then return end
    if isSustainNote or disableComboRating then return end

    if (not playsAsBF()) then
        t.spawnRating(id, playsAsBF())
    end
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if tag:sub(1, 9) == "MMMrating" then
        removeLuaSprite(tag)
    elseif tag == "MMMnoteTimingRating" then
        setProperty("MMMnoteTimingRating.alpha", 0)
    end
end

return t
