--MMMunderlay.lua
local t = {}

function t.create()
    setProperty("noteUnderlays.visible", false)

    t.strums = HUDmodules[4]

    t.left = {}
    t.left.width = ((t.strums.left.width or t.strums.width)+t.strums.left.noteSpacing)*keyCount + (32 * (t.strums.left.scale or 1))

    t.right = {}
    t.right.width = ((t.strums.right.width or t.strums.width)+t.strums.right.noteSpacing)*keyCount + (32 * (t.strums.right.scale or 1))

    if noteUnderlayOpacity > 0 and (not botPlay) and (not replay) then
        t.left.x = t.strums.left.x
        t.right.x = t.strums.right.x

        if middlescroll and playsAsBF() then
            t.left.x = t.left.x + 30
        else
            t.left.x = t.left.x - 16
        end

        if middlescroll and (not playsAsBF()) then
            t.right.x = t.right.x + 30
        else
            t.right.x = t.right.x - 16
        end

        if downscroll then
            if middlescroll then
                if playsAsBF() then
                    t.left.height = 358
                    t.right.height = 690

                    t.left.y = t.strums.left.y - t.left.height + 85
                    t.right.y = 0
                else
                    t.left.height = 690
                    t.right.height = 358

                    t.left.y = 0
                    t.right.y = t.strums.right.y - t.right.height + 85
                end
            else
                t.left.height = 660
                t.right.height = 660

                t.left.y = 0
                t.right.y = 0
            end
        else
            if middlescroll then
                if playsAsBF() then
                    t.left.height = 358
                    t.right.height = 665

                    t.left.y = t.strums.left.y + 25
                    t.right.y = 720-t.right.height
                else
                    t.left.height = 665
                    t.right.height = 358

                    t.left.y = 720-t.left.height
                    t.right.y = t.strums.right.y + 25
                end
            else
                t.left.height = 680
                t.right.height = 680

                t.left.y = 720-t.left.height
                t.right.y = 720-t.right.height
            end
        end

        makeLuaSprite("MMMunderlayLeft", "", t.left.x, t.left.y)
        makeGraphic("MMMunderlayLeft", t.left.width, t.left.height, "000000")
        setObjectCamera("MMMunderlayLeft", "hud")
        setProperty("MMMunderlayLeft.alpha", noteUnderlayOpacity)
        addLuaSprite("MMMunderlayLeft")

        makeLuaSprite("MMMunderlayRight", "", t.right.x, t.right.y)
        makeGraphic("MMMunderlayRight", t.right.width, t.right.height, "000000")
        setObjectCamera("MMMunderlayRight", "hud")
        setProperty("MMMunderlayRight.alpha", noteUnderlayOpacity)
        addLuaSprite("MMMunderlayRight")

        if not opponentStrums then
            if playsAsBF() then
                setProperty("MMMunderlayLeft.visible", false)
            else
                setProperty("MMMunderlayRight.visible", false)
            end
        end
    end
end

function t.resize(newWidth)
    if noteUnderlayOpacity > 0 and (not botPlay) and (not replay) then
        t.left.x = t.strums.left.x
        t.right.x = t.strums.right.x

        if middlescroll and playsAsBF() then
            t.left.x = t.left.x + 30
        else
            t.left.x = t.left.x - 16
        end

        if middlescroll and (not playsAsBF()) then
            t.right.x = t.right.x + 30
        else
            t.right.x = t.right.x - 16
        end

        setProperty("MMMunderlayLeft.x", t.left.x)
        setProperty("MMMunderlayRight.x", t.right.x)
    end
end

return t
