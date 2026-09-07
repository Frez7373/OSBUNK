local function describe(name)
  local typ=peripheral.getType(name) or "unknown"
  print(name.."  ["..typ.."]")
  local p=peripheral.wrap(name)
  if not p then return end
  local methods=peripheral.getMethods(name) or {}
  print("  methods: "..#methods)
  for _,m in ipairs(methods) do print("   - "..m) end
  print("")
end
term.setBackgroundColor(colors.black); term.setTextColor(colors.white); term.clear(); term.setCursorPos(1,1)
print("OSBUNK DEVICE CENTER")
print("========================================")
local names=peripheral.getNames()
if #names==0 then print("No peripherals connected.") else for _,n in ipairs(names) do describe(n) end end
print("========================================")
print("Press any key to return")
os.pullEvent("key")
