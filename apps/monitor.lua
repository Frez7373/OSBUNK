local function line(label, value)
  term.write(string.format("%-22s ", label)); term.setTextColor(colors.white); print(tostring(value))
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK SYSTEM MONITOR")
print("========================================")
line("Computer ID", os.getComputerID())
line("Label", os.getComputerLabel() or "(none)")
line("Computer uptime", string.format("%.1fs", os.epoch("utc") / 1000))
line("Term size", select(1,term.getSize()).."x"..select(2,term.getSize()))
line("Color", term.isColor())
line("Advanced", term.isColor() and "possible" or "basic")
line("Free space", fs.getFreeSpace("/") or "unknown")
line("Modem count", #peripheral.find("modem"))
print("----------------------------------------")
print("Live peripheral summary:")
for _,name in ipairs(peripheral.getNames()) do
  local typ=peripheral.getType(name) or "unknown"
  print("  "..name.."  <"..typ..">")
end
print("----------------------------------------")
print("Press any key to return")
os.pullEvent("key")
