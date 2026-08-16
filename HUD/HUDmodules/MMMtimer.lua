--MMMtimer.lua
local t = {}

function t.create()
    if timeBarType=="Disabled" then return end

    makeLuaText("MMMtimer", "[]", getProperty("camHUD.width"), 0, 31)
    setTextSize("MMMtimer", 21)
    setTextFont("MMMtimer", "RobotoMono-Regular.ttf")
    setTextBorder("MMMtimer", 1, 'black')
    addLuaText("MMMtimer")

    t.countdownFrames = {"[-]", "[-:]", "[-:-]", "[-:--]", "[-:--]"}
end

function t.resize(newWidth)
    if timeBarType=="Disabled" then return end

    setTextWidth("MMMtimer", newWidth)
end

function t.onUpdatePost(elapsed)
    if timeBarType=="Disabled" then return end

    local timerString = '['..getProperty("timeTxt.text")..']'
    if getProperty('timeTxt.text')~='' and getTextString("MMMtimer")~=timerString then
        setTextString("MMMtimer", timerString)
    end
end

function t.onCountdownTick(counter)
    if timeBarType=="Disabled" then return end

    setTextString("MMMtimer", t.countdownFrames[counter+1])
end

return t
