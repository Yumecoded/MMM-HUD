resize = false
addScreenshot = false

width = 1280
height = 720

function onCreate()
    if resize then
        resizeWindow = getPropertyFromClass("flixel.FlxG", "resizeWindow")
        resizeWindow(width, height)
    end
end

function onCreatePost()
    if addScreenshot then
        makeLuaSprite("MMMscreenshot", "right upscroll")
        addLuaSprite("MMMscreenshot", false)
        setObjectCamera("MMMscreenshot", "hud")
        setProperty("MMMscreenshot.alpha", 0.5)
    end
end
