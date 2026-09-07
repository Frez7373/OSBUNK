-- OSBUNK installer / repair tool
local BASE="https://raw.githubusercontent.com/Frez7373/OSBUNK/main/"
local files={
  "startup.lua",
  "boot.lua",
  "osbunk.lua",
  "apps/terminal.lua",
  "apps/filemgr.lua",
  "apps/monitor.lua",
  "apps/devices.lua",
  "apps/notes.lua"
}

term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK INSTALLER")
print("Version 1.0.0 | CC:Tweaked 1.21.1")
print("========================================")

if not http then error("HTTP is disabled. Enable HTTP in the CC:Tweaked computer configuration.") end
fs.makeDir("/OSBUNK/apps")

local function download(path)
  local url=BASE..path
  local ok,res=pcall(http.get,url)
  if not ok or not res then return false,"HTTP request failed: "..url end
  local data=res.readAll(); res.close()
  if not data or #data==0 then return false,"Empty response: "..path end
  local full="/OSBUNK/"..path
  local dir=fs.getDir(full); if dir~="" then fs.makeDir(dir) end
  local h=fs.open(full,"w"); if not h then return false,"Cannot write "..full end
  h.write(data); h.close(); return true
end

for _,path in ipairs(files) do
  io.write("Installing "..path.." ... ")
  local ok,err=download(path)
  if ok then print("OK") else print("FAIL"); print(err); error("Installation aborted.") end
end

local h=fs.open("/OSBUNK/version","w"); h.write("1.0.0"); h.close()
print("========================================")
print("OSBUNK installed successfully.")
print("The computer will reboot in 3 seconds...")
sleep(3)
os.reboot()
