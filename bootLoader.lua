term.clear()
term.setCursorPos(1,1)
print("")
print("")
print("")
print("")
print("               +----+------->XXX                  ")
print("               |    |        XXX                  ")
print("               |  +------------+XXX               ")
print("               +----+          |XXX               ")
print("               |  |  BCWorks   | ||               ")
print("               |  |    MiniOS  | \\/               ")
print("               |  |          +----+               ")
print("               |  +------------+  |               ")
print("               |             |    |               ")
print("               +-------------+----+               ")
os.sleep(5)
term.clear()
term.setCursorPos(1,1)
local mainModule = fs.open("/BCWorks_MiniOS/main.lua", "r")
loadstring(mainModule.readAll())()
--os.loadAPI("/BCWorks_MiniOS/main.lua")
--main.main()