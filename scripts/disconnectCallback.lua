function tableContains(table, value)
    for _,v in pairs(table) do
        if v==value then
            return true
        end
    end

    return false
end

function storePlayers()
    local sids = listPlayers()
    trackedPlayers = {names = {}}

    for i=1, #sids do
        local sid = sids[i]

        trackedPlayers.names[sid] = getPlayer(sid).name
    end

    trackedPlayers.length = #sids
end

function onCreatePost()
    if online then
        storePlayers()
    else
        close()
    end
end

function onUpdatePost(elapsed)
    if online then
        local players = listPlayers()
        local name = ""

        if trackedPlayers.length~=#players then
            for sid,_ in pairs(trackedPlayers.names) do
                if not tableContains(players, sid) then
                    name = trackedPlayers.names[sid]
                end
            end

            storePlayers()

            callOnLuas("onPlayerDisconnect", {name})
        end
    end
end
