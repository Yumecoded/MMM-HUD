--MMMratings.lua
local t = {}

function t.resize()
    if hideHud then return end

    t.xOffset = 140
    t.x = {
        [true] = t.strums["playerStrums"].x - t.xOffset,
        [false] = t.strums["playerStrums"].x + (t.strums["playerStrums"].width+t.strums["playerStrums"].noteSpacing)*mania + t.xOffset
    }
    t.opponentX = {
        [true] = t.strums["opponentStrums"].x,
        [false] = t.strums["opponentStrums"].x + (t.strums["opponentStrums"].width+t.strums["opponentStrums"].noteSpacing)*mania
    }
    if middlescroll then
        t.opponentX[true] = t.opponentX[true] - 28
        t.opponentX[false] = t.opponentX[false] + 88
    else
        t.opponentX[true] = t.opponentX[true] - t.xOffset
        t.opponentX[false] = t.opponentX[false] + t.xOffset
    end

    if downscroll then
        t.y = t.strums["playerStrums"].y + 70
        t.opponentY = t.strums["opponentStrums"].y + 70
    else
        t.y = t.strums["playerStrums"].y + 165
        if middlescroll then
            t.opponentY = t.strums["opponentStrums"].y + 100
        else
            t.opponentY = t.strums["opponentStrums"].y + 165
        end
    end

    t.scale = 0.3
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

function t.spawnRating(id, right, otherPlayer, sid)
    if middlescroll and (not otherPlayer) then right = not right end

    local tag = "MMMrating"
    local i = 1

    if comboStacking then
        while luaSpriteExists(tag..i) do
            i = i + 1
        end
    elseif otherPlayer then
        i = sid
    end

    local rating
    local x
    if otherPlayer then
        x = t.opponentX[right]
        y = t.opponentY
    else
        x = t.x[right]
        y = t.y
    end

    local scale = t.scale
    local velocity = -319.45
    local acceleration = 542.52
    if otherPlayer and middlescroll then
        scale = scale / 2
        velocity = velocity / 2
        acceleration = acceleration / 2
    end

    if type(id)=="string" then
        rating = id
    else
        local strumTimeNoAbs = getSongPosition() - getPropertyFromGroup("notes", id, "strumTime") + ratingOffset
        local strumTime = math.abs(strumTimeNoAbs)

        rating = t.getRating(strumTime)
    end

    if showNoteTiming then
        setProperty("MMMnoteTimingRating.x", x)
        setProperty("MMMnoteTimingRating.y", y+35)
        setTextString("MMMnoteTimingRating", math.floor(-strumTimeNoAbs).."ms")
        setTextColor("MMMnoteTimingRating", timingColors[rating])
        setProperty("MMMnoteTimingRating.alpha", 1)
        runTimer("MMMnoteTimingRating", 1)
    end

    makeLuaSprite(tag..i, rating, x, y)
    setObjectCamera(tag..i, "hud")
    scaleObject(tag..i, scale, scale)
    addLuaSprite(tag..i, true)

    setProperty(tag..i..".velocity.y", velocity)
    setProperty(tag..i..".acceleration.y", acceleration)

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
        t.spawnRating(id, playsAsBF(), false)
    end
end

function t.onMessageNoteHit(sid, message)
    local time = message[1]
    local noteData = message[2]
    local isSustainNote = message[3]
    local ratingImage = message[4]

    if sid==getPlayerSelfSID() then return end
    if isSustainNote then return end
    if not ratingImage then return end

    local player = getPlayer(sid)
    t.spawnRating(ratingImage, player.bfSide, true, sid)
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if tag:sub(1, 9) == "MMMrating" then
        removeLuaSprite(tag)
    elseif tag == "MMMnoteTimingRating" then
        setProperty("MMMnoteTimingRating.alpha", 0)
    end
end

return t
