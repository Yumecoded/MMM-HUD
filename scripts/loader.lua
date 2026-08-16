function onCreatePost()
    for _,scriptName in ipairs({"ultrawide.lua", "main.lua"}) do
        local path = "HUD/"..scriptName

        addLuaScript(path)
        callScript(path, "onCreatePost")
    end

    close()
end
