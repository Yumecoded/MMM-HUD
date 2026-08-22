--MMMopponentScore.lua
local t = {}

function t.create()
    if hideHud or (not opponentStrums) then return end

    t.strums = HUDmodules[4]
    t.tag = "opponentStrums"
    t.updateScore = false

    makeLuaText("MMMopponentScore", "Accuracy: -", 0, 0, 0)
    if middlescroll then
        setTextSize("MMMopponentScore", 19)
    else
        setTextSize("MMMopponentScore", 21)
    end
    setTextFont("MMMopponentScore", "RobotoMono-Regular.ttf")
    setTextBorder("MMMopponentScore", 2, 'black')
    addLuaText("MMMopponentScore")

    t.resize(getProperty("camHUD.width"))
end

function t.resize(newWidth)
    if hideHud or (not opponentStrums) then return end

    t.width = (t.strums.width + t.strums[t.tag].noteSpacing)*keyCount

    if middlescroll then
        t.x = t.strums[t.tag].x - t.width / 4 + 7
        if downscroll then
            t.y = t.strums[t.tag].y + 84
        else
            t.y = t.strums[t.tag].y - 2
        end
    else
        t.x = t.strums[t.tag].x
        if downscroll then
            t.y = t.strums[t.tag].y + 121
        else
            t.y = t.strums[t.tag].y - 45
        end
    end

    setTextWidth("MMMopponentScore", t.width)
    setProperty("MMMopponentScore.x", t.x)
    setProperty("MMMopponentScore.y", t.y)
end

function t.onUpdatePost()
    if not multiplayer.opponentBotplay then return end

    if getTextString("MMMopponentScore")~="[BOTPLAY]" then
        setTextString("MMMopponentScore", "[BOTPLAY]")
    end
    setProperty("MMMopponentScore.alpha", 1 - math.sin((math.pi * botplaySine) / 180))
end

function t.doScoreUpdate(sid)
    if multiplayer.isPlayerOnTheSameSide(sid) then return end
    if multiplayer.opponentBotplay then return end

    local winCondition = multiplayer.winCondition
    local value = multiplayer.getStat(winCondition, sid)

    local opponentScoreString = multiplayer.winConditions[winCondition][1]..": "..value

    if winCondition==0 then
        opponentScoreString = opponentScoreString..'%'
    end

    if getTextString("MMMopponentScore")~=opponentScoreString then
        setTextString("MMMopponentScore", opponentScoreString)
    end
end

function t.onMessageNoteHit(sid, message)
    if not t.updateScore then
        t.updateScore = true
        t.doScoreUpdate(sid)
    end
end

function t.onMessageNoteMiss(sid, message)
    if not t.updateScore then
        t.updateScore = true
        t.doScoreUpdate(sid)
    end
end

function t.onUpdateScorePlayer(sid)
    if not t.updateScore then return end

    t.doScoreUpdate(sid)
end

function t.onMessageStrumPlay(sid, message)
    if multiplayer.isPlayerOnTheSameSide(sid) then return end
    if multiplayer.opponentBotplay then return end

    if not t.updateScore then
        t.updateScore = true

        local opponentScoreString
        local winCondition = multiplayer.winCondition
        if winCondition==0 then
            opponentScoreString = multiplayer.winConditions[winCondition][1]..": 0.00%"
        else
            opponentScoreString = multiplayer.winConditions[winCondition][1]..": 0"
        end

--         if MMMTeamMode then
--             opponentScoreString = "Team "..opponentScoreString
--         end

        if getTextString("MMMopponentScore")~=opponentScoreString then
            setTextString("MMMopponentScore", opponentScoreString)
        end
    end
end

return t
