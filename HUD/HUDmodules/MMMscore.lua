--MMMscore.lua
local t = {}

function t.create()
    if hideHud then return end

    makeLuaText("MMMscore", "", getProperty("camHUD.width"), 0, 683)
    setTextSize("MMMscore", 21)
    setTextFont("MMMscore", "RobotoMono-Regular.ttf")
    setTextBorder("MMMscore", 1, 'black')
    addLuaText("MMMscore")

    t.updateScore = false
end

function t.resize(newWidth)
    if hideHud then return end

    setTextWidth("MMMscore", newWidth)
end

function t.onUpdatePost(elapsed)
    if hideHud then return end

    if t.updateScore then
        local score = score
        local misses = misses
        local accuracy = string.format("%.2f", rating*100)
        local combo = combo
        local fp = getProperty("songPoints")

        local scoreString

--         if MMMTeamMode then
--             score = 0
--
--             for i=1, #myTeam do
--                 local sid = myTeam[i]
--                 local player = getPlayer(sid)
--
--                 score = score + player.score
--             end
--         end

        scoreString = "Score: "..score.." | Misses: "..misses.." | Accuracy: "..accuracy..'%'

        if not disableComboCounter then
            scoreString = scoreString.." | Combo: "..combo
        end

        if showFP then
            scoreString = scoreString.." | FP: "..fp
        end

        if getTextString("MMMscore")~=scoreString then
            setTextString("MMMscore", scoreString)
        end
    else
        local staticScore = "Score: - | Misses: - | Accuracy: -"

        if not disableComboCounter then
            staticScore = staticScore.." | Combo: -"
        end

        if showFP then
            staticScore = staticScore.." | FP: -"
        end

        if getTextString("MMMscore")~=staticScore then
            setTextString("MMMscore", staticScore)
        end

        for _,v in pairs(getProperty("keysArray")) do
            if keyJustPressed(v) then
                t.updateScore = true
            end
        end
    end
end

function t.noteMiss()
    if hideHud then return end

    if not t.updateScore then
        t.updateScore = true
    end
end

function t.onUpdateScore(miss)
    if hideHud then return end

    if not t.updateScore then
        t.updateScore = true
    end
end

function t.onGhostTap()
    if hideHud then return end

    if not t.updateScore then
        t.updateScore = true
    end
end

function t.goodNoteHit()
    if hideHud then return end

    if (not t.updateScore) and playsAsBF() then
        t.updateScore = true
    end
end

function t.opponentNoteHit()
    if hideHud then return end

    if (not t.updateScore) and (not playsAsBF()) then
        t.updateScore = true
    end
end

return t
