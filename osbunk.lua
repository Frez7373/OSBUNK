-- OSBUNK bunker operating system
local VERSION = "1.0.0"
local ROOT = "/OSBUNK"
local state = {running = true, app = nil, message = "System ready"}

local function screen()
  local w,h = term.getSize()
  term.setBackgroundColor(colors.black); term.clear()
  term.setCursorPos(1,1); term.setBackgroundColor(colors.gray); term.setTextColor(colors.white)
  term.clearLine(); term.write(" OSBUNK 1.0.0    BUNKER CONTROL SYSTEM")
  term.setBackgroundColor(colors.black)
  term.setCursorPos(2,3); term.setTextColor(colors.lightBlue); term.write("APPLICATIONS")
  local apps = {
    {"[1] File Manager", colors.blue},
    {"[2] Terminal", colors.orange},
    {"[3] System Monitor", colors.green},
    {"[4] Device Center", colors.cyan},
    {"[5] Notes", colors.yellow},
    {"[6] Reboot", colors.red},
  }
  for i,a in ipairs(apps) do
    local y = 4 + (i-1)*2
    term.setCursorPos(3,y); term.setBackgroundColor(a[2]); term.setTextColor(colors.white); term.write(" "..a[1].." ")
    term.setBackgroundColor(colors.black)
  end
  term.setCursorPos(2,h-2); term.setTextColor(colors.gray)
  term.write((state.message or "")..string.rep(" ", math.max(0,w-3-#(state.message or ""))))
  term.setCursorPos(2,h); term.setTextColor(colors.gray); term.write("OSBUNK | Press 1-6 or click | Q = shutdown")
end

local function runApp(file)
  state.app = file
  local ok, err = pcall(function() shell.run(ROOT.."/apps/"..file) end)
  state.app = nil
  if not ok then state.message = "APP ERROR: "..tostring(err); sleep(2) end
end

local function clickApp(y)
  local n = math.floor((y-4)/2)+1
  if y >= 4 and y <= 14 and (y-4)%2 == 0 then
    if n == 1 then runApp("filemgr.lua")
    elseif n == 2 then runApp("terminal.lua")
    elseif n == 3 then runApp("monitor.lua")
    elseif n == 4 then runApp("devices.lua")
    elseif n == 5 then runApp("notes.lua")
    elseif n == 6 then os.reboot() end
  end
end

while state.running do
  screen()
  local e,a,b = os.pullEvent()
  if e == "key" then
    if a == keys.q then state.running = false
    elseif a >= keys.one and a <= keys.six then clickApp(4 + (a-keys.one)*2) end
  elseif e == "mouse_click" or e == "monitor_touch" then
    clickApp(b)
  elseif e == "term_resize" then
    -- redraw on resize
  end
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK halted.")
print("Use 'reboot' to start again.")
