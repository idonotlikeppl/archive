local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

if game.Players.LocalPlayer.Character == nil then
    local tempwindow = Rayfield:CreateWindow({
        Name = "westbound 🌟 v0.0",
        LoadingTitle = "💫supernova💫",
        LoadingSubtitle = "A project by Exxen",
        ConfigurationSaving = {
           Enabled = false,
           FolderName = "ExxensScripts",
           FileName = "Westbound"
        },
        Discord = {
           Enabled = false,
           Invite = "yPfnRkwW6r",
           RememberJoins = true
        },
        KeySystem = false
     })
     
    Rayfield:Notify({
        Title = "Notice",
        Content = "The GUI will boot once you spawn in!",
        Duration = 5,
        Image = 4483362458,
        Actions = { -- Notification Buttons
        Ignore = {Name = "Okay!",Callback = function()
        end}
    },
    })
end

repeat wait() until game.Players.LocalPlayer.Character ~= nil and game.Players.LocalPlayer.Character:FindFirstChild("CharacterLocal")

local Window = Rayfield:CreateWindow({
   Name = "westbound 🌟 Dev Build",
   LoadingTitle = "💫supernova💫",
   LoadingSubtitle = "A project by Exxen",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "ExxensScripts",
      FileName = "Westbound"
   },
   Discord = {
      Enabled = false,
      Invite = "yPfnRkwW6r",
      RememberJoins = true
   },
   KeySystem = false
})

local combatTab = Window:CreateTab("Combat", 4483362458)
local charTab = Window:CreateTab("Character", 4483362458)
local miscTab = Window:CreateTab("Misc", 4483362458)

local plr = game.Players.LocalPlayer
local notif = require(game:GetService("ReplicatedStorage").UIModules.NotifyUser)
local function char()
    return plr.Character
end
local module = require(game:GetService("ReplicatedStorage").GunScripts.GunStats)
local originals = {}
for i,v in pairs(module) do
    originals[i] = v
end
writefile("guns.lua", game:GetService("HttpService"):JSONEncode(originals))
originals = game:GetService("HttpService"):JSONDecode(readfile("guns.lua"))
local settings = {}
local getinfo = debug.getinfo
local func;
local func2;
local index; local newindex;
local getupvalues = debug.getupvalues
local setupvalue = debug.setupvalue
settings.horseHipHeight = 0
settings.horseJumpPower = 50
settings.horseWSpeed = 16
settings.antiRagdoll = false
settings.maxFOV = false
settings.WalkSpeed = false
settings.ws = 13
settings.JumpPower = false
settings.jp = 45
settings.MaxSlopeAngle = false
settings.showBypass = true
local function getHorse()
    for i,v in pairs(game.Workspace.Horses:GetChildren()) do
        if v.Scripts.Owner.Value == plr then
            return v
        end
    end
end


combatTab:CreateToggle({Name = "Gun Mods",CurrentValue = false,Callback = function(Value)
    if Value == true then
        for i,v in pairs(module) do
            v["MaxShots"] = 100
            v["ReloadSpeed"] = 0
            v["camShakeResist"] = 0
            v["Spread"] = 0
            v["ReloadAnimationSpeed"] = 0
            v["HipFireAccuracy"] = 0
            v["ZoomAccuracy"] = 0
            v["InstantFireAnimation"] = true
            v["equipTime"] = 0
            v["prepTime"] = 0
            v["BulletSpeed"] = 0
            if v["BulletCount"] ~= nil then
                v["BulletCount"] = 100
            end
        end
    else
        for i,v in pairs(module) do
            print(originals[i]["MaxShots"])
            v["MaxShots"] = originals[i]["MaxShots"]
            v["ReloadSpeed"] = originals[i]["ReloadSpeed"]
            v["camShakeResist"] = originals[i]["camShakeResist"]
            v["Spread"] = originals[i]["Spread"]
            v["ReloadAnimationSpeed"] = originals[i]["ReloadAnimationSpeed"]
            v["HipFireAccuracy"] = originals[i]["HipFireAccuracy"]
            v["ZoomAccuracy"] = originals[i]["ZoomAccuracy"]
            v["InstantFireAnimation"] = originals[i]["InstantFireAnimation"]
            v["equipTime"] = originals[i]["equipTime"]
            v["prepTime"] = originals[i]["prepTime"]
            v["BulletSpeed"] = originals[i]["BulletSpeed"]
            if v["BulletCount"] ~= nil then
                v["BulletCount"] = originals[i]["BulletCount"]
            end
        end
    end
end})

charTab:CreateToggle({Name = "Toggle WalkSpeed",CurrentValue = false,Callback = function(Value)
    settings.wsToggle = Value
    if Value == false then
        if char():FindFirstChildOfClass("Humanoid") then
            char():FindFirstChildOfClass("Humanoid").WalkSpeed = 13   
        end
    end
end})
charTab:CreateSlider({Name = "WalkSpeed",Range = {13, 250},Increment = 1,Suffix = " ",CurrentValue = 13,Callback = function(Value)
    settings.ws = Value
end})

charTab:CreateToggle({Name = "Toggle JumpPower",CurrentValue = false,Callback = function(Value)
    settings.jpToggle = Value
    if Value == false then
        if char():FindFirstChildOfClass("Humanoid") then
            char():FindFirstChildOfClass("Humanoid").JumpPower = 45   
        end
    end
end})
charTab:CreateSlider({Name = "JumpPower",Range = {45, 250},Increment = 1,Suffix = " ",CurrentValue = 45,Callback = function(Value)
    settings.jp =Value
end})

charTab:CreateToggle({Name = "Climb Steeper Slopes",CurrentValue = false,Callback = function(Value)
    settings.playerSlope = Value
    if Value == false then
        if char():FindFirstChildOfClass("Humanoid") then
            char():FindFirstChildOfClass("Humanoid").MaxSlopeAngle = 60   
        end
    end
end})

charTab:CreateToggle({Name = "Anti-Ragdoll",Flag = "antirag",CurrentValue = false,Callback = function(Value)
    settings.antiRagdoll = Value
end})


miscTab:CreateSlider({Name = "Horse Float Height",Range = {0, 50},Increment = 1,Suffix = " ",CurrentValue = 0,Callback = function(Value)
    settings.horseHipHeight = Value
    if Value == 0 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.HipHeight = 0
        end
    end
end})
miscTab:CreateSlider({Name = "Horse Jump Height",Range = {50, 500},Increment = 1,Suffix = " ",CurrentValue = 50,Callback = function(Value)
    settings.horseJumpPower = Value
    if Value == 50 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.JumpPower = 50
        end
    end
end})
miscTab:CreateSlider({Name = "Horse Speed",Range = {16, 250},Increment = 1,Suffix = " ",CurrentValue = 16,Callback = function(Value)
    settings.horseWSpeed = Value
    if Value == 16 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.WalkSpeed = 16
        end
    end
end})
miscTab:CreateToggle({Name = "Notifiy On Bypass",Flag = "notifbypass",CurrentValue = true,Callback = function(Value)
    settings.showBypass = Value
end})


local namecall; namecall = hookmetamethod(game,"__namecall",function(self,...)
    local args = {...}
    local method = getnamecallmethod():lower()
    if tostring(self) == "ChangeCharacter" and method == "fireserver" and settings.antiRagdoll == true then
        if args[1] == "Damage" or args[1] == "Ragdoll" then
            print("attempted to",args[1])
            args[1] = nil
            args[2] = nil
            return namecall(self,unpack(args))
        end
    end
    return namecall(self,...)
end)

for i,v in pairs(getgc()) do
    if type(v) == "function" and getinfo(v).name == "EnableRagdoll" then
        func = v
    end
    if type(v) == "function" and getinfo(v).name == "DisableRagdoll" then
        func2 = v
    end
end

local oldhookfunction; oldhookfunction = hookfunction(func,function(p1,p2)
    if settings.antiRagdoll == true then
        print("attempted to ragdoll:",p2)
        if char().Humanoid.Sit == true then
            return print("lol")
        end
        return func2(p1,p2)
    else
        return oldhookfunction(p1,p2)
    end
end)

for i,v in pairs(getgc(true)) do
    if type(v) == "function" and getinfo(v).name  then
        local info = getinfo(v)
        if info.source == "=Workspace."..tostring(game.Players.LocalPlayer)..".CharacterLocal" then
            local upvs = getupvalues(v)
            if tostring(upvs[1]) == "Humanoid" and upvs[2] == false and type(upvs[3]) == "table" then
                setupvalue(v,3,{RunSpeed = math.huge})
                if settings.showBypass == true then
                    notif:ShowNotification("Bypassed")
                end
            end
        end
    end
end

plr.CharacterAdded:Connect(function(c)
    repeat wait() until c:FindFirstChild("CharacterLocal")
    for i,v in pairs(getgc(true)) do
        if type(v) == "function" and getinfo(v).name  then
            local info = getinfo(v)
            if info.source == "=Workspace."..tostring(game.Players.LocalPlayer)..".CharacterLocal" then
                local upvs = getupvalues(v)
                if tostring(upvs[1]) == "Humanoid" and upvs[2] == false and type(upvs[3]) == "table" then
                    setupvalue(v,3,{RunSpeed = math.huge})
                    if settings.showBypass == true then
                        notif:ShowNotification("Bypassed")
                    end
                end
            end
        end
    end
end)



game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    if settings.horseHipHeight ~= 0 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.HipHeight = settings.horseHipHeight
        end
    end
    if settings.horseJumpPower ~= 50 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.JumpPower = settings.horseJumpPower
        end
    end
    if settings.horseWSpeed ~= 16 then
        if getHorse() ~= nil then
            local horse = getHorse()
            horse.Humanoid.WalkSpeed = settings.horseWSpeed
        end
    end
    if settings.jpToggle == true then
        if char() ~= nil and char():FindFirstChild("Humanoid") then
            local humanoid = char():FindFirstChild("Humanoid")
            humanoid.JumpPower = settings.jp
        end
    end
    if settings.wsToggle == true then
        if char() ~= nil and char():FindFirstChild("Humanoid") then
            local humanoid = char():FindFirstChild("Humanoid")
            humanoid.WalkSpeed = settings.ws
        end
    end
    if settings.playerSlope == true then
        if char() ~= nil and char():FindFirstChild("Humanoid") then
            local humanoid = char():FindFirstChild("Humanoid")
            humanoid.MaxSlopeAngle = 100
        end
    end
end)
