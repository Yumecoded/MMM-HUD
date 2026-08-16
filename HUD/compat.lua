--compat.lua
local t = {}

t.allowedPrefixes = {["MMM"] = true}
t.varPrefix = "MMM_HUD_compat_"

function t.onUpdatePost()
    if songStarted then return end

    for k,v in pairs(_G) do
        if k:sub(1, #t.varPrefix) == t.varPrefix then
            if not t.allowedPrefixes[v] then
                t.allowedPrefixes[v] = true
                setOnLuas(k, nil)
            end
        end
    end
end

return t
