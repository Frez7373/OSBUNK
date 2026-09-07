term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK TERMINAL")
print("Type 'help' for commands. 'exit' returns to desktop.")
print("")
while true do
  term.write("bunker$ ")
  local line = read()
  if line == "exit" then break end
  if line == "help" then
    print("help, clear, time, label, id, peripherals, reboot, shutdown, exit")
  elseif line == "clear" then term.clear(); term.setCursorPos(1,1)
  elseif line == "time" then print(os.date("%Y-%m-%d %H:%M:%S"))
  elseif line == "label" then print(os.getComputerLabel() or "(no label)")
  elseif line == "id" then print(os.getComputerID())
  elseif line == "peripherals" then
    local p=peripheral.getNames()
    if #p==0 then print("No peripherals detected.") else for _,n in ipairs(p) do print("- "..n.." ["..peripheral.getType(n).."]") end end
  elseif line == "reboot" then os.reboot()
  elseif line == "shutdown" then os.shutdown()
  elseif line ~= "" then
    local ok,err = pcall(function() shell.run(line) end)
    if not ok then printError(err) end
  end
end
