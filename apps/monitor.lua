local function line(label,value)
  term.write(string.format("%-22s ",label)); term.setTextColor(colors.white); print(tostring(value))
end
local function countType(t)
  local n=0; for _,name in ipairs(peripheral.getNames()) do if peripheral.getType(name)==t then n=n+1 end end; return n
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK SYSTEM MONITOR")
print("========================================")
line("Computer ID",os.getComputerID())
line("Label",os.getComputerLabel() or "(none)")
line("Runtime",string.format("%.1fs",os.clock()))
local w,h=term.getSize(); line("Terminal",w.."x"..h)
line("Color terminal",term.isColor())
line("Free space",fs.getFreeSpace("/") or "unknown")
line("Modems",countType("modem")); line("Monitors",countType("monitor")); line("Drives",countType("drive")); line("Printers",countType("printer")); line("Speakers",countType("speaker"))
print("----------------------------------------")
print("Connected peripherals:")
for _,name in ipairs(peripheral.getNames()) do print("  "..name.."  <"..(peripheral.getType(name) or "unknown")..">") end
print("========================================")
print("Press any key to return")
os.pullEvent("key")
