function module(path)
    return assert(loadstring(getTextFromFile(path)))()
end

function hidePsychHUD()
    setProperty("timeTxt.visible", false)
    setProperty("timeBar.visible", false)
    setProperty("timeBarBG.visible", false)
    setProperty("scoreTxt.visible", false)

    if online then
        if multiplayer.room.teamMode then
            setProperty("scoreTxtOthers[LEFTSIDE].visible", false)
            setProperty("scoreTxtOthers[RIGHTSIDE].visible", false)
        else
            for i=1, #multiplayer.players do
                setProperty("scoreTxtOthers["..multiplayer.players[i].."].visible", false)
            end
        end
    end
end

function destroyCustomHUD()
    local tags = runHaxeFunction("getObjectsToDestroy")

    for _, tag in pairs(tags) do
        local destroy = true

        for prefix,_ in pairs(compat.allowedPrefixes) do
            if tag:sub(1, #prefix) == prefix then
                destroy = false
            end
        end

        if destroy then
            removeLuaSprite(tag)
            removeLuaText(tag)
        end
    end
end

function createHUD()
    HUDmodules = {}

    for i,v in ipairs({"MMMver", "MMMsongName", "MMMtimer", "strums", "MMMopponentScore", "healthBar", "icons", "MMMscore", "MMMwarning", "MMMratings", "MMMunderlay", "notes", "MMMoverlay", "MMMwaitReadyTxt"}) do
        HUDmodules[i] = module("HUD/HUDmodules/"..v..".lua")
        HUDmodules[i].create()
    end
end

function callHUD(callbackName, ...)
    for _, HUDmodule in ipairs(HUDmodules) do
        local func = HUDmodule[callbackName]

        if func then
            func(...)
        end
    end
end

function onCreatePost()
    module("HUD/helpers.lua")
    module("HUD/haxeFunctions.lua")

    module("HUD/modifiers.lua")
    module("HUD/staticClientPrefs.lua")
    module("HUD/unfairCheck.lua")

    difficultyColors = module("HUD/difficultyColors.lua")
    ratingColors = module("HUD/ratingColors.lua")
    timingColors = module("HUD/timingColors.lua")

    compat = module("HUD/compat.lua")
    antiModchart = module("HUD/antiModchart.lua")

    multiplayer = module("HUD/multiplayer.lua")
    solo = module("HUD/solo.lua")
    if solo then
        solo.create()
    end

    botplaySine = 0

    hidePsychHUD()
    createHUD()
end

function onUpdatePost(elapsed)
    showFP = getPropertyFromClass("backend.ClientPrefs", "data.showFP")

    botplaySine = botplaySine+(180 * elapsed)

    compat.onUpdatePost()
    antiModchart.onUpdatePost()

    hidePsychHUD()
    destroyCustomHUD()

    callHUD("onUpdatePost", elapsed)
end

function onSongStart()
    songStarted = true

    callHUD("onSongStart")
end

function onCountdownTick(counter)
    callHUD("onCountdownTick", counter)
end

function onEvent(name, value1, value2, strumTime)
    callHUD("onEvent", name, value1, value2, strumTime)
end

function onBeatHit()
    callHUD("onBeatHit")
end

function onSectionHit()
    callHUD("onSectionHit")
end

function noteMiss()
    callHUD("noteMiss")
end

function onUpdateScore(miss)
    callHUD("onUpdateScore", miss)
end

function onGhostTap()
    callHUD("onGhostTap")
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    callHUD("goodNoteHit", id, noteData, noteType, isSustainNote)
end

function opponentNoteHit(id, noteData, noteType, isSustainNote)
    callHUD("opponentNoteHit", id, noteData, noteType, isSustainNote)
end

function onTweenCompleted(tag, vars)
    callHUD("onTweenCompleted", tag, vars)
end

function onTimerCompleted(tag, loops, loopsLeft)
    callHUD("onTimerCompleted", tag, loops, loopsLeft)
end

function onSpawnNote(id, data, type, isSustainNote, strumTime)
    callHUD("onSpawnNote", id, data, type, isSustainNote, strumTime)
end

function onStartCountdown()
    callHUD("onStartCountdown")
end

function onWindowResize(newWidth)
    callHUD("resize", newWidth)
end
