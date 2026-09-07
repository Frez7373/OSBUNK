-- OSBUNK boot manager
local VERSION = "1.0.0"
term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1,1)
print("OSBUNK BIOS v" .. VERSION)
print("Initializing bunker computer...")

local checks = {
  {"Filesystem", function() return fs and fs.exists end},
  {"Computer API", function() return os and os.pullEvent end},
  {"Term API", function() return term and term.getSize end},
}
for _, c in ipairs(checks) do
  local ok = false
  pcall(function() ok = c[2]() ~= nil end)
  if ok then print("[ OK ] " .. c[1]) else print("[FAIL] " .. c[1]) end
end

sleep(0.4)
if not fs.exists("/OSBUNK/osbunk.lua") then
  error("Kernel missing. Re-run the OSBUNK installer.")
end
shell.run("/OSBUNK/osbunk.lua")
