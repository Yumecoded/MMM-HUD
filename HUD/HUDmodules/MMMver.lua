--MMMver.lua
local t = {}

function t.create()
    local PEOver = getPropertyFromClass("Main", "PSYCH_ONLINE_VERSION")
    local verString = "v"..PEOver
    local x = -18
    local y = 681

    makeLuaText("MMMverShadow", verString, getProperty("camOther.width"), x+3, y+2)
    setTextSize("MMMverShadow", 25)
    setTextFont("MMMverShadow", "PermanentMarker-Regular.ttf")
    setTextBorder("MMMverShadow", 0, "black")
    setTextAlignment("MMMverShadow", "right")
    setObjectCamera("MMMverShadow", "other")
    setTextColor("MMMverShadow", "black")
    setProperty("MMMverShadow.alpha", 0.5)
    addLuaText("MMMverShadow")
    -- I hate this ^^^

    makeLuaText("MMMver", verString, getProperty("camOther.width"), x, y)
    setTextSize("MMMver", 25)
    setTextFont("MMMver", "PermanentMarker-Regular.ttf")
    setTextBorder("MMMver", 0, "black")
    setTextAlignment("MMMver", "right")
    setObjectCamera("MMMver", "other")
    addLuaText("MMMver")
end

function t.resize(newWidth)
    setTextWidth("MMMverShadow", newWidth)
    setTextWidth("MMMver", newWidth)
end

return t
