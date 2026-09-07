-- OSBUNK startup loader
local ok, err = pcall(function()
    if not fs.exists("/OSBUNK/boot.lua") then
        error("OSBUNK is not installed. Run: wget run https://raw.githubusercontent.com/Frez7373/OSBUNK/main/install.lua")
    end
    shell.run("/OSBUNK/boot.lua")
end)
if not ok then
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.red)
    term.clear()
    term.setCursorPos(1, 1)
    print("OSBUNK BOOT ERROR")
    print("")
    print(err)
    print("")
    print("Run the installer again to repair the system.")
end
