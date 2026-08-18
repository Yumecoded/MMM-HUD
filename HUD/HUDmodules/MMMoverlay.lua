--MMMoverlay.lua
local t = {}

function t.create()
    if not online then return end

    makeLuaSprite("MMMoverlay", "", 0, 0)
    makeGraphic("MMMoverlay", getProperty("camOther.width"), 720, "000000")
    setObjectCamera("MMMoverlay", "other")
    setProperty("MMMoverlay.alpha", 0.5)
    addLuaSprite("MMMoverlay")
end

function t.resize(newWidth)
    if not online then return end

    if not songStarted then
        makeGraphic("MMMoverlay", newWidth, 720, "000000")
    end
end

function t.onStartCountdown()
    removeLuaSprite("MMMoverlay")
end

return t
