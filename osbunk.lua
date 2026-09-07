-- OSBUNK bunker operating system
local VERSION = "1.0.0"
local ROOT = "/OSBUNK"
local state = {running = true, message = "System ready"}

local function draw()
  local w,h = term.getSize()
  term.setBackgroundColor(colors.black); term.clear(); term.setCursorPos(1,1)
  term.setBackgroundColor(colors.gray); term.setTextColor(colors.white); term.clearLine(); term.write(" OSBUNK 1.0.0   BUNKER CONTROL SYSTEM")
  term.setBackgroundColor(colors.black); term.setTextColor(colors.lightBlue); term.setCursorPos(2,3); term.write("APPLICATIONS")
  local apps={{"[1] File Manager",colors.blue},{"[2] Terminal",colors.orange},{"[3] System Monitor",colors.green},{"[4] Device Center",colors.cyan},{"[5] Notes",colors.yellow},{"[6] Reboot",colors.red}}
  for i,a in ipairs(apps) do
    local y=4+(i-1)*2; term.setCursorPos(3,y); term.setBackgroundColor(a[2]); term.setTextColor(colors.white); term.write(" "..a[1].." "); term.setBackgroundColor(colors.black)
  end
  term.setCursorPos(2,h-2); term.setTextColor(colors.gray); local msg=state.message or ""; term.write(msg..string.rep(" ",math.max(0,w-3-#msg)))
  term.setCursorPos(2,h); term.write("OSBUNK | 1-6 / click | Q shutdown")
end

local function app(file)
  local ok,err=pcall(function() shell.run(ROOT.."/apps/"..file) end)
  if not ok then state.message="APP ERROR: "..tostring(err); sleep(2) else state.message="Returned to desktop" end
end

local function launch(n)
  if n==1 then app("filemgr.lua") elseif n==2 then app("terminal.lua") elseif n==3 then app("monitor.lua") elseif n==4 then app("devices.lua") elseif n==5 then app("notes.lua") elseif n==6 then os.reboot() end
end

while state.running do
  draw()
  local e,a,b,c=os.pullEvent()
  if e=="key" then
    if a==keys.q then state.running=false
    elseif a==keys.one then launch(1) elseif a==keys.two then launch(2) elseif a==keys.three then launch(3) elseif a==keys.four then launch(4) elseif a==keys.five then launch(5) elseif a==keys.six then launch(6) end
  elseif e=="mouse_click" or e=="monitor_touch" then
    launch(math.floor((c-4)/2)+1)
  end
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1); print("OSBUNK halted."); print("Use 'reboot' to start again.")
