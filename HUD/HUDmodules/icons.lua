--icons.lua
local t = {}

function t.create()
    runHaxeCode([[
        function scaleIcons() {
            for (icon in iconP1s.concat(iconP2s)) {
                icon.scale.x = 0.65;
                icon.scale.y = 0.65;
                icon.alpha = 1;
                icon.visible = true;
                icon.y = healthBar.y-71;
                icon.updateHitbox();
            }
        }
    ]])

    if not multiplayer.opponentPresent then
        runHaxeCode(opponentIcon..".changeIcon(\"Face\")")
    end
    runTimer("icons", 0.25)
end

function t.onUpdatePost()
    runHaxeFunction("scaleIcons")
end

function t.resize()
    --hack to get x positions to update
    --resets... on the next frame, I think
    if getProperty("healthBar.percent") == 100 then
        setProperty("healthBar.percent", 0)
    else
        setProperty("healthBar.percent", 100)
    end
end

function t.onBeatHit()
    runHaxeFunction("scaleIcons")
end

function t.onSectionHit()
    runHaxeFunction("scaleIcons")
end

function t.onTimerCompleted(tag, loops, loopsLeft)
    if tag=="icons" then
        t.resize()
    end
end

function t.onEvent(name, value1, value2, strumTime)
    if name=="Change Character" and (not multiplayer.opponentPresent) then
        runHaxeCode(opponentIcon..".changeIcon(\"Face\")")
    end
end

return t
