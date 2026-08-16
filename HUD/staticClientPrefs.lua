--staticClientPrefs.lua
local list = {"comboStacking", "noteUnderlayOpacity", "colorRating", "disableComboRating", "disableComboCounter", "showNoteTiming", "opponentStrums", "ratingOffset"}

for _,v in ipairs(list) do
    _G[v] = getPropertyFromClass("backend.ClientPrefs", "data."..v)
end
