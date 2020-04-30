--os.pullEvent = os.pullEventRaw
local menu = true
while true do
if menu then
menu = false
term.clear()
term.setCursorPos(1,1)
print("Choose module (name only):")
print(fs.list("BCWorks_MiniOS/modules"))
write("$")
local inpModule = io.read()
if inpModule == "crypto_chat" then
    local hChat = fs.open(packageList.modulesDir.."crypto_chat.lua", "r")
    loadstring(hChat.readAll())()
    menu = true
end

end end