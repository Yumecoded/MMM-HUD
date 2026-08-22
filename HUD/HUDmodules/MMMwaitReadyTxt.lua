--MMMwaitReadyTxt.lua

local t = {}

function t.create()
    if not online then return end

    makeLuaText("MMMwaitReadyTxt", "Press accept to start", getProperty("camOther.width"), 0, 338)
    setTextSize("MMMwaitReadyTxt", 30)
    setTextFont("MMMwaitReadyTxt", "PermanentMarker-Regular.ttf")
    setObjectCamera("MMMwaitReadyTxt", "other")
    addLuaText("MMMwaitReadyTxt")

    t.dots = 1
    t.updateDots = false
end

function t.onUpdatePost(elapsed)
    if not online then return end

    if not songStarted then
        setProperty("waitReadySpr.visible", false)
        if getProperty("waitReadySpr.text")=="waiting for other player..." and (not t.updateDots) then
            t.updateDots = true
            setTextString("MMMwaitReadyTxt", "Waiting for other player"..string.rep(".", t.dots))
            runTimer("MMMwaitReadyTxt", 1/3)
        end
    end
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if not online then return end

    if tag=="MMMwaitReadyTxt" then
        t.dots = t.dots + 1
        if t.dots > 3 then
            t.dots = 1
        end

        if luaTextExists("MMMwaitReadyTxt") then
            setTextString("MMMwaitReadyTxt", "Waiting for other player"..string.rep(".", t.dots))
            runTimer("MMMwaitReadyTxt", 1/3)
        end
    end
end

function t.resize(newWidth)
    setTextWidth("MMMwaitReadyTxt", newWidth)
end

function t.onStartCountdown()
    removeLuaText("MMMwaitReadyTxt")
end

return t
