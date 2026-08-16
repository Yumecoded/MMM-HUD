--MMMsongName.lua
local t = {}

function t.create()
    local songNameString = songName..' ('..difficultyName..')'
    if playbackRate~=1 then
        local f = 2
        local rate = string.format("%."..f.."f", playbackRate)
        while tostring(rate:sub(#rate, #rate))=="0" do
            f = f-1
            rate = string.format("%."..f.."f", playbackRate)
        end
        songNameString = songNameString..' ('..rate..'x)'
    end

    makeLuaText("MMMsongName", songNameString, getProperty("camHUD.width"), 0, 5)
    setTextSize("MMMsongName", 21)
    setTextFont("MMMsongName", "RobotoMono-Regular.ttf")
    setTextBorder("MMMsongName", 1, 'black')
    addLuaText("MMMsongName")

    local songColor
    local difficultyColor

    local baseGame = currentModDirectory == ""
    if baseGame then
        songColor = "fe0000"
    else
        local json = parseJson("../"..currentModDirectory.."/pack.json")
        if json.color then
            songColor = rgbToHex(json.color[1], json.color[2], json.color[3])
        else
            local iconColor = getIconColor("dad")
            songColor = rgbToHex(iconColor[1], iconColor[2], iconColor[3])
        end
    end
    if difficultyColors[string.lower(difficultyName)] then
        difficultyColor = difficultyColors[string.lower(difficultyName)]
    else
        difficultyColor = difficultyColors["hard"]
    end

    textColorPart("MMMsongName", songColor, 0, #songName)
    textColorPart("MMMsongName", difficultyColor, #songName + 1, #songName + 3 + #difficultyName)
end

function t.resize(newWidth)
    setTextWidth("MMMsongName", newWidth)
end

return t
