originalWidth = 1280
originalHeight = 720

function resize()
    prevWindowWidth = getPropertyFromClass("openfl.Lib", "application.window.width")
    prevWindowHeight = getPropertyFromClass("openfl.Lib", "application.window.height")

    local aspectRatio = prevWindowWidth / prevWindowHeight
    if aspectRatio < (16/9) then aspectRatio = 16/9 end
    local newWidth = originalHeight * aspectRatio
    local offset = (newWidth - originalWidth) / 2

    targetOffset = ((newWidth - originalWidth) / 2)

    setProperty("camGame.width", newWidth)
    setProperty("camHUD.width", newWidth)
    setProperty("camOther.width", newWidth)
    setProperty("camLoading.width", newWidth)

    setProperty("camGame.x", 0 - offset)
    setProperty("camHUD.x", 0 - offset)
    setProperty("camOther.x", 0 - offset)
    setProperty("camLoading.x", 0 - offset)

    callOnLuas("onWindowResize", {newWidth})
end

function onCreatePost()
    resize()
end

function onUpdatePost()
    setProperty("camGame.targetOffset.x", 0 - targetOffset)

    local windowWidth = getPropertyFromClass("openfl.Lib", "application.window.width")
    local windowHeight = getPropertyFromClass("openfl.Lib", "application.window.height")

    local resolutionChanged = prevWindowWidth ~= windowWidth or prevWindowHeight ~= windowHeight
    if not resolutionChanged then return end

    resize()
end
