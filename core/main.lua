--os.pullEvent = os.pullEventRaw
local menu = true
while true do
if menu then
menu = false
term.clear()
term.setCursorPos(1,1)
os.loadAPI("BCWorks_MiniOS/packageList")
print("Choose module (name only):")
for _,file in pairs(fs.list(packageList.modulesDirObj)) do
    print(file)
end
write("$ ")
local inpModule = io.read()
local hModule = fs.open(packageList.modulesDir..inpModule..".lua", "r")
print(packageList.modulesDir..inpModule..".lua")
loadstring(hModule.readAll())()
menu = true

end end