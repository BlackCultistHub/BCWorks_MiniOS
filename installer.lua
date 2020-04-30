term.clear()
term.setCursorPos(1,1)
print("***********[ BCWorks MiniOS installer ]***********")
print("*                                                *")
print("*   Detecting for installed MiniOS...            *")
if not fs.exists("/BCWorks_MiniOS") then
    print("*   Do you want to install MiniOS? (y/n)         *")
    term.write("* : ")
    if io.read() == "n" then
        print("*   Terminating install.                         *")
        print("**************************************************")
        do return end
    end
    print("*   Installing MiniOS...                         *")
    local hBootLoader = fs.open("/BCWorks_MiniOS/.MiniOSLoader", "w")
    if hBootLoader ~= nil then
        local bootLoaderContent = http and http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/core/bootLoader.lua")
        hBootLoader.write(bootLoaderContent.readAll())
        hBootLoader.close()
        bootLoaderContent.close()
        print("*   [OK] BootLoader installed.                   *")
    else
        print("*   /!\\ Cannot create BootLoader!                *")
        do return end
    end
else
    print("*   MiniOS detected!                             *")
    print("*   Do you want to update/reinstall?             *")
    print("*   u.Update  r.Reinstall  U.Uninstall  n.No     *")
    term.write("* : ")
    local inp = io.read()
    if inp == "u" then
        os.sleep(1)
        local hBootLoader = fs.open("/BCWorks_MiniOS/.MiniOSLoader", "w")
        local bootLoaderContent = http and http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/core/bootLoader.lua")
        hBootLoader.write(bootLoaderContent.readAll())
        hBootLoader.close()
        bootLoaderContent.close()
        print("*   [OK] BootLoader updated.                      *")
        if fs.exists("startup") then fs.delete("startup") end
    elseif inp == "r" then
        fs.delete("/BCWorks_MiniOS")
        if fs.exists("startup") then
            fs.delete("startup")
        end
        os.sleep(1)
        print("*   /!\\ MiniOS erased.                           *")
        print("*   Installing MiniOS...                         *")
        local hBootLoader = fs.open("/BCWorks_MiniOS/.MiniOSLoader", "w")
        if hBootLoader ~= nil then
            local bootLoaderContent = http and http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/core/bootLoader.lua")
            hBootLoader.write(bootLoaderContent.readAll())
            hBootLoader.close()
            bootLoaderContent.close()
            print("*   [OK] BootLoader installed.                   *")
        end
    elseif inp == "U" then
        fs.delete("/BCWorks_MiniOS")
        if fs.exists("startup") then
            fs.delete("startup")
        end
        print("*   MiniOS uninstalled successfully.             *")
        print("**************************************************")
        do return end
    else
        print("*   Terminating install.                         *")
        print("**************************************************")
        do return end
    end
end
do
local hPackageList = fs.open("BCWorks_MiniOS/packageList", "w")
if hPackageList == nil then
    print("*   /!\\ Package file creating error.             *")
    print("**************************************************")
    do return end
end
local packageListContent = http and http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/core/packageList")
hPackageList.write(packageListContent.readAll())
hPackageList.close()
packageListContent.close()
print("*   [OK] Package file created.                   *")
os.loadAPI("BCWorks_MiniOS/packageList")
--Fetch core
for name, path in pairs(packageList.modulesCoreList) do
    local hModule = fs.open(path..name, "w")
    if hModule == nil then
        print("*   /!\\ Error creating file for module " .. name .. " in " .. path .. "!")
        print("**************************************************")
        fs.delete("/BCWorks_MiniOS")
        if fs.exists("startup") then
            fs.delete("startup")
        end
        do return end
    end
    local moduleCoreContent = http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/core/" .. name)
    hModule.write(moduleCoreContent.readAll())
    print("*   [OK] Module " .. name .. " installed.")
    hModule.close()
    moduleCoreContent.close()
end
--Fetch modules
for name, path in pairs(packageList.modulesList) do
    local hModule = fs.open(path..name, "w")
    if hModule == nil then
        print("*   /!\\ Error creating file for module " .. name .. " in " .. path .. "!")
        print("**************************************************")
        fs.delete("/BCWorks_MiniOS")
        if fs.exists("startup") then
            fs.delete("startup")
        end
        do return end
    end
    local moduleContent = http.get("https://raw.githubusercontent.com/BlackCultistHub/BCWorks_MiniOS/master/modules/" .. name)
    hModule.write(moduleContent.readAll())
    print("*   [OK] Module " .. name .. " installed.")
    hModule.close()
    moduleContent.close()
end
fs.copy("/BCWorks_MiniOS/.MiniOSLoader", "startup")
print("*   [OK] BootLoader written in startup.          *")
print("*   Your machine will now reboot...              *")
print("**************************************************")
os.sleep(5)
os.reboot()
do return end
end