--helpers.lua
function parseJson(file)
    return callMethodFromClass('tjson.TJSON', 'parse', {getTextFromFile(file)})
end

function textColorPart(tag, color, startIndex, endIndex)
    addHaxeLibrary("FlxTextFormat", "flixel.text")
    runHaxeCode([[
        var txt = modchartTexts["]]..tag..[["];
        txt.addFormat(
            new FlxTextFormat(0x]]..color..[[),
            ]]..startIndex..[[, ]]..endIndex..[[
        );
    ]])
end

function rgbToHex(r, g, b)
    return string.format("%02X%02X%02X", r, g, b)
end

function getIconColor(character)
	return(getProperty(character..".healthColorArray"))
end
