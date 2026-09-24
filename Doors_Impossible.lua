if game.ReplicatedStorage.GameData.LatestRoom.Value <= 0 then
game.StarterGui:SetCore( "ChatMakeSystemMessage",  { Text = "[Oof's Error Detector]: You must execute this script in room 1 or higher.", Color = Color3.fromRGB( 255,0,0 ), Font = nothingactually, FontSize = Enum.FontSize.Size24 } )
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "You must execute this script in room 1.")
end
---- first message, error detection ----

if game.ReplicatedStorage.GameData.LatestRoom.Value >= 1 then
game.StarterGui:SetCore( "ChatMakeSystemMessage",  { Text = "[Oof's Impossible Mode]: Script succesfully executed.", Color = Color3.fromRGB( 0,255,0 ), Font = nothingactually, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore( "ChatMakeSystemMessage",  { Text = "SCRIPT VERSION: MULTIPLAYER (v1.4)", Color = Color3.fromRGB( 0,255,0 ), Font = nothingactually, FontSize = Enum.FontSize.Size24 } )
game.StarterGui:SetCore( "ChatMakeSystemMessage",  { Text = "Good Luck.", Color = Color3.fromRGB( 255,255,255 ), Font = nothingactually, FontSize = Enum.FontSize.Size24 } )
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "Oof's impossible mode script succesfully loaded.")
--
game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
game.StarterGui:SetCore( "ChatMakeSystemMessage",  { Text = "Script synced according to the room.", Color = Color3.fromRGB( 255,255,255 ), Font = nothingactually, FontSize = Enum.FontSize.Size24 } )
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "Script sync'd according to the room.")
wait(2.5)
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "Shoutout to INK!CHARA#0001 for finishing the game with this difficulty.")
-- eyes
coroutine.wrap(function()
while true do
wait(100)
loadstring(game:HttpGet("https://pastebin.com/raw/7aNww6a2"))()
end
end)()
--

-- screech
coroutine.wrap(function()
while true do
local sctm = math.random(30,60)
wait(sctm)
loadstring(game:HttpGet("https://pastebin.com/raw/uLMymFsz"))()
end
end)()
--

-- smiler
coroutine.wrap(function()
while true do
wait(200)
game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
loadstring(game:HttpGet("https://pastebin.com/raw/7XUSYqdJ"))()
end
end)()
--

-- dimensional eye
coroutine.wrap(function()
while true do
wait(300)
game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
loadstring(game:HttpGet("https://pastebin.com/raw/27ewusGV"))()
end
end)()
--

-- Smiley
coroutine.wrap(function()
while true do
local chance = math.random(1, 2)
wait(1800)
if chance == 1 then
loadstring(game:HttpGet("https://pastebin.com/raw/RJsTpRqm"))()
else
firesignal(game.ReplicatedStorage.Bricks.Caption.OnClientEvent, "Secret entity did not spawn.")
end
end
end)
-- Hunger & Nightmare Hunger
coroutine.wrap(function()
while true do
wait(696)
local spawn_chance = math.random(1, 100)
game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
if spawn_chance >= 16 then
local spawn_nm = Instance.new("Sound", workspace)
spawn_nm.SoundId = "rbxassetid://933230732"
spawn_nm.Volume = 1
spawn_nm:Play()
wait(16.5)
loadstring(game:HttpGet("https://pastebin.com/raw/n97tfcnj"))() -- spawn hunger
elseif spawn_chance <= 15 then
local spawn_nm = Instance.new("Sound", workspace)
spawn_nm.SoundId = "rbxassetid://933230732"
spawn_nm.Volume = 1
spawn_nm:Play()
wait(16.5)
loadstring(game:HttpGet("https://pastebin.com/raw/grRsu3Yc"))() -- spawn nightmare hunger
end
end
end)()
-- wh1t3
coroutine.wrap(function()
while true do
wait(500)
game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
loadstring(game:HttpGet("https://pastebin.com/raw/cAnaGhZe"))()
end
end)()
-- Silence
coroutine.wrap(function()
while true do
wait(379)
loadstring(game:HttpGet("https://pastebin.com/raw/xHG9rb2y"))()
end
end)()
--
-- customroom
coroutine.wrap(function()
loadstring(game:HttpGet("https://pastebin.com/raw/wDDm2xH2"))()
end)()
--
-- redroom
--game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
--loadstring(game:HttpGet("https://pastebin.com/raw/UVKaJuyq"))()
--end)
--

-- damage if u take too long to enter next room
--game.ReplicatedStorage.GameData.LatestRoom.Changed:Connect(function()
--loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/timer_for_damage"))()
--end)



end

--


-- extra --
loadstring(game:HttpGet("https://pastebin.com/raw/gkvFviLW"))()