--unfairCheck.lua
local playingNoteCountLeft = 0
local playingNoteCountRight = 0

for i=0, getProperty("unspawnNotes.length")-1 do
    if not getPropertyFromGroup("unspawnNotes", i, "isSustainNote") then
        if getPropertyFromGroup("unspawnNotes", i, "mustPress") then
            playingNoteCountRight = playingNoteCountRight + 1
        else
            playingNoteCountLeft = playingNoteCountLeft + 1
        end
    end
end

if playingNoteCountLeft > 0 then
    songDensityLeft = playingNoteCountLeft / (getProperty("inst.length") / playbackRate / 1000) / 2
else
    songDensityLeft = 0
end

if playingNoteCountRight > 0 then
    songDensityRight = playingNoteCountRight / (getProperty("inst.length") / playbackRate / 1000) / 2
else
    songDensityRight = 0
end

local threshold = 1.1

local unfairNoteCount = math.max(playingNoteCountLeft, playingNoteCountRight)/math.min(playingNoteCountLeft, playingNoteCountRight) >= threshold
local unfairDensity = math.max(songDensityLeft, songDensityRight)/math.min(songDensityLeft, songDensityRight) >= threshold

debugPrint(math.max(playingNoteCountLeft, playingNoteCountRight))
debugPrint(math.min(playingNoteCountLeft, playingNoteCountRight))

unfairSong = unfairNoteCount or unfairDensity or (mania ~= 3)
