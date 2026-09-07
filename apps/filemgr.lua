local cwd = "/"
local function draw()
  term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
  print("OSBUNK FILE MANAGER   "..cwd)
  print("----------------------------------------")
  local list = fs.list(cwd)
  if #list == 0 then print("(empty)") else
    for i,name in ipairs(list) do
      local p=fs.combine(cwd,name)
      if fs.isDir(p) then print(string.format("%2d  <DIR>  %s",i,name)) else print(string.format("%2d  FILE    %s",i,name)) end
    end
  end
  print("----------------------------------------")
end
while true do
  draw(); print("Commands: cd <dir>, open <file>, delete <name>, mkdir <name>, back, exit")
  term.write("fm$ "); local line=read(); local cmd,arg=line:match("^(%S+)%s*(.-)$"); cmd=cmd or line
  if cmd=="exit" or cmd=="back" then break
  elseif cmd=="cd" and arg~="" then
    local target=fs.combine(cwd,arg); if fs.isDir(target) then cwd=fs.canonical(target) else print("Directory not found."); sleep(1) end
  elseif cmd=="open" and arg~="" then
    local p=fs.combine(cwd,arg); if fs.exists(p) and not fs.isDir(p) then shell.run("edit",p) else print("File not found."); sleep(1) end
  elseif cmd=="delete" and arg~="" then
    local p=fs.combine(cwd,arg); if fs.exists(p) then fs.delete(p) else print("Not found.") end
  elseif cmd=="mkdir" and arg~="" then fs.makeDir(fs.combine(cwd,arg))
  elseif cmd=="" then
  else print("Unknown command."); sleep(1) end
end
