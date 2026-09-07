local file = "/OSBUNK/notes.txt"
local function load()
  if fs.exists(file) then local h=fs.open(file,"r"); local s=h.readAll(); h.close(); return s end
  return ""
end
local function save(s)
  local h=fs.open(file,"w"); h.write(s); h.close()
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK NOTES")
print("========================================")
print("Commands: view, edit, clear, exit")
while true do
  term.write("notes$ "); local cmd=read()
  if cmd=="exit" then break
  elseif cmd=="view" then print(load()); print("")
  elseif cmd=="clear" then save(""); print("Notes cleared.")
  elseif cmd=="edit" then shell.run("edit",file)
  elseif cmd=="" then
  else print("Unknown command.") end
end
