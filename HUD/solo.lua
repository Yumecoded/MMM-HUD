--solo.lua
local t = {}
if multiplayer.opponentPresent then return nil end

for i=0, getProperty("unspawnNotes.length")-1 do
    if getPropertyFromGroup("unspawnNotes", i, "mustPress") ~= playsAsBF() then
        setPropertyFromGroup("unspawnNotes", i, "ignoreNote", true)
    end
end

if playsAsBF() then
    opponentCharacter = "dad"
    opponentIcon = "iconP2"
else
    opponentCharacter = "boyfriend"
    opponentIcon = "iconP1"
end

function t.create()
    setProperty("gf.visible", false)

    setProperty(opponentCharacter..".visible", opponentPresent)
end

return t
