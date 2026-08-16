--haxeFunctions.lua
runHaxeCode([[
    function getObjectsToDestroy() {
        var arr = [];
        for (key in modchartTexts.keys()) {
            var txt = modchartTexts.get(key);
            if (txt != null && txt.camera != camGame)
                arr.push(key);
        }
        for (key in modchartSprites.keys()) {
            var spr = modchartSprites.get(key);
            if (spr != null && spr.camera != camGame)
                arr.push(key);
        }
        return arr;
    }
]])
