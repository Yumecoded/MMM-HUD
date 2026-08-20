--multiplayer.lua
local t = {}

t.winConditions = {
    [0] = {"Accuracy"},
    [1] = {"Score"},
    [2] = {"Misses"},
    [3] = {"FP", "songPoints"},
    [4] = {"Combo", "maxCombo"}
}

function t.isPlayerOnTheSameSide(sid)
    local player = getPlayer(sid)
    return player.bfSide==playsAsBF()
end

function t.getStat(winCondition, sid)
    local statName

    if t.winConditions[winCondition][2] then
        statName = t.winConditions[winCondition][2]
    else
        statName = t.winConditions[winCondition][1]:lower()
    end

    local stat

    if statName=="accuracy" then
        stat = string.format("%.2f", getPlayerAccuracy(sid))
    else
        local player = getPlayer(sid)
        stat = player[statName]
    end

    return stat
end

if online then
    t.room = getRoomState()
    t.winCondition = t.room.winCondition

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
    t.winCondition = 0
    t.opponentPresent = false
end

return t
