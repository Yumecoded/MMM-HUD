--healthBar.lua
local t = {}

function t.fixColors()
    if playsAsBF() then
        setHealthBarColors("ff1b00", "5ede31");
    else
        setHealthBarColors("5ede31", "ff1b00");
    end
end

function t.resize(newWidth)
    t.x = newWidth / 2 - getProperty("healthBar.width") / 2
    if downscroll then
        t.y = 94
    else
        t.y = 648
    end
end

function t.create()
    t.resize(getProperty("camHUD.width"))
    t.fixColors()
end

function t.onUpdatePost()
    setProperty("healthBar.visible", true)
    setProperty("healthBar.bg.visible", true)

    setProperty("healthBar.scale.x", 1)
    setProperty("healthBar.scale.y", 1)

    setProperty("healthBar.x", t.x)
    setProperty("healthBar.y", t.y)
end

function t.onEvent(name, value1, value2, strumTime)
    if name=="Change Character" then
        t.fixColors()
    end
end

return t
