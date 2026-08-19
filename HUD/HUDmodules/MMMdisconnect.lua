--MMMdisconnect.lua
local t = {}

function t.create()
    makeLuaText("MMMdisconnect", "Opponent has left the match.", getProperty("camHUD.width"), 0, 18)
    setTextSize("MMMdisconnect", 22)
    setTextFont("MMMdisconnect", "RobotoMono-Regular.ttf")
    setTextBorder("MMMdisconnect", 1, 'black')
    setTextColor("MMMdisconnect", "be6564")
    setProperty("MMMdisconnect.alpha", 0)
    setObjectCamera("MMMdisconnect", "other")
    addLuaText("MMMdisconnect")
end

function t.resize(newWidth)
    setTextWidth("MMMdisconnect", newWidth)
end

function t.onPlayerDisconnect(name)
--     if MMMTeamMode then
--         setTextString("MMMdisconnect", name.." has left the match.")
--     else
--         setTextString("MMMdisconnect", "Opponent has left the match.")
--     end
    playSound("MMMforfeit", 4)

    setProperty("MMMdisconnect.alpha", 1)
    setProperty("MMMsongName.alpha", 0)
    setProperty("MMMtimer.alpha", 0)

    runTimer("MMMdisconnect", 1)
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if tag=="MMMdisconnect" then
        doTweenAlpha("MMMdisconnect", "MMMdisconnect", 0, 2)
        if songStarted then
            doTweenAlpha("MMMsongName", "MMMsongName", 1, 2)
            doTweenAlpha("MMMtimer", "MMMtimer", 1, 2)
        end
    end
end

return t
