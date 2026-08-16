--multiplayer.lua
local t = {}

if online then
    t.room = getRoomState()
    t.players = listPlayers()

    t.playersLeftSide = listPlayersBySide(false)
    t.playersRightSide = listPlayersBySide(true)
    if playsAsBF() then
        t.myTeam = t.playersRightSide
        t.opponents = t.playersLeftSide
    else
        t.myTeam = t.playersLeftSide
        t.opponents = t.playersRightSide
    end

    t.opponentPresent = #t.opponents > 0
else
    t.opponentPresent = false
end

return t
