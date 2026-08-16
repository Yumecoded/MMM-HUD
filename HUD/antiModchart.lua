--antiModchart.lua
local t = {}

function t.onUpdatePost()
    setOnScripts("noteTweenX", nil)
    setOnScripts("noteTweenY", nil)
    setOnScripts("noteTweenAngle", nil)
    setOnScripts("noteTweenAlpha", nil)
    setOnScripts("noteTweenDirection", nil)
end

return t
