local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")

local Player = Players.LocalPlayer

local Spawner = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"
))()

local CONFIG = {
	SpawnCooldown = 70,
	RoomDelay = 7,
	MinimumRoom = 5,
	MinimumRoomGap = 4,
	SpawnChance = 0.35,
	NormalSpeed = 12,
	ShockerTime = 70
}

local URLs = {
	Caption = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Caption",
	Stamina = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Stamina",

	Cease = "https://raw.githubusercontent.com/chubeteliet-cpu/Doors-hardcore-/refs/heads/main/Cease",
	Ripper = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/New%20ripper",
	Rebound = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Rebound",
	Frostbite = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Forsbite",
	Silence = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Silence",
	MultiMonster = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Multi%20monster%20a60",

	DeerGod = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Dear",
	Shocker = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Shocker",

	Seek = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Siuuu",
	Figure = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Figure",

	SeekMusic = "https://raw.githubusercontent.com/shadow-gelacy/Hardcore-mode/refs/heads/main/Seek%20music%20script"
}

local Entities = {
	{
		Name = "Cease",
		Weight = 45,
		URL = URLs.Cease
	},

	{
		Name = "Ripper",
		Weight = 60,
		URL = URLs.Ripper
	},

	{
		Name = "Rebound",
		Weight = 10,
		URL = URLs.Rebound
	},

	{
		Name = "Frostbite",
		Weight = 10,
		URL = URLs.Frostbite
	},

	{
		Name = "Silence",
		Weight = 5,
		URL = URLs.Silence
	},

	{
		Name = "MultiMonster",
		Weight = 3,
		URL = URLs.MultiMonster
	}
}

local GameData = ReplicatedStorage:WaitForChild("GameData")
local LatestRoom = GameData:WaitForChild("LatestRoom")

local lastEntityRoom = -math.huge
local lastEntityTime = 0
local lastSpawnedEntity = nil

local staminaLoaded = false
local staminaLoading = false
local shockerRunning = false

local function Notify(title, text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = 5
		})
	end)
end

local function RunScript(url)
	local success, result = pcall(function()
		return loadstring(game:HttpGet(url))()
	end)

	if not success then
		warn("[Hardcore] Failed:", url, result)
		return false
	end

	return true
end

local function LoadCaption()
	task.spawn(function()
		RunScript(URLs.Caption)
	end)
end

local function LoadStamina()
	if staminaLoaded or staminaLoading then
		return
	end

	staminaLoading = true

	task.spawn(function()
		local success = RunScript(URLs.Stamina)

		if success then
			staminaLoaded = true
		end

		staminaLoading = false
	end)
end

local function LoadSeek()
	task.spawn(function()
		RunScript(URLs.Seek)
	end)
end

local function LoadFigure()
	task.spawn(function()
		RunScript(URLs.Figure)
	end)
end

local function LoadDeerGod()
	task.spawn(function()
		RunScript(URLs.DeerGod)
	end)
end

local function LoadShocker()
	task.spawn(function()
		RunScript(URLs.Shocker)
	end)
end

local function LoadSeekMusic()
	task.spawn(function()
		local success, source = pcall(function()
			return game:HttpGet(URLs.SeekMusic)
		end)

		if not success or not source then
			warn("[Hardcore] Seek music script failed")
			return
		end

		local soundUrl = source:match(
			'local%s+soundUrl%s*=%s*"([^"]+)"'
		)

		if not soundUrl then
			warn("[Hardcore] soundUrl not found")
			return
		end

		local fileName = "hardcorechaser0ts.mp3"

		if not isfile(fileName) then
			local downloadSuccess, data = pcall(function()
				return game:HttpGet(soundUrl)
			end)

			if not downloadSuccess or not data then
				warn("[Hardcore] Music download failed")
				return
			end

			writefile(fileName, data)
		end

		local getAsset = getcustomasset or getsynasset

		if not getAsset then
			warn("[Hardcore] Custom asset API unavailable")
			return
		end

		local customSoundId = getAsset(fileName)

		local function ApplyMusic(child)
			task.spawn(function()
				local seekMusic = child:FindFirstChild("SeekMusic", true)

				if not seekMusic then
					seekMusic = child:WaitForChild("SeekMusic", 5)
				end

				if seekMusic and seekMusic:IsA("Sound") then
					seekMusic.SoundId = customSoundId
				end
			end)
		end

		for _, child in ipairs(Workspace:GetChildren()) do
			if string.lower(child.Name) == "seekmovingnewclone" then
				ApplyMusic(child)
			end
		end

		Workspace.ChildAdded:Connect(function(child)
			if string.lower(child.Name) == "seekmovingnewclone" then
				ApplyMusic(child)
			end
		end)

		Notify("Hardcore mode", "Seek music loaded")
	end)
end

local function GetWeightedEntity()
	local totalWeight = 0

	for _, entity in ipairs(Entities) do
		totalWeight += entity.Weight
	end

	local randomValue = math.random() * totalWeight
	local currentWeight = 0

	for _, entity in ipairs(Entities) do
		currentWeight += entity.Weight

		if randomValue <= currentWeight then
			return entity
		end
	end

	return Entities[1]
end

local function SpawnEntity(entity)
	if not entity then
		return
	end

	if entity.Name == lastSpawnedEntity then
		local attempts = 0

		while entity.Name == lastSpawnedEntity and attempts < 5 do
			entity = GetWeightedEntity()
			attempts += 1
		end
	end

	lastSpawnedEntity = entity.Name

	task.spawn(function()
		local success, result = pcall(function()
			return loadstring(game:HttpGet(entity.URL))()
		end)

		if not success then
			warn(
				"[Hardcore] Entity failed:",
				entity.Name,
				result
			)
		end
	end)
end

local function TryRandomEntity(room)
	if room < CONFIG.MinimumRoom then
		return
	end

	if room - lastEntityRoom < CONFIG.MinimumRoomGap then
		return
	end

	if os.clock() - lastEntityTime < CONFIG.SpawnCooldown then
		return
	end

	if math.random() > CONFIG.SpawnChance then
		return
	end

	local entity = GetWeightedEntity()

	if not entity then
		return
	end

	lastEntityRoom = room
	lastEntityTime = os.clock()

	SpawnEntity(entity)
end

local function HandleRoom(room)
	if room == 32 then
		LoadDeerGod()
		return
	end

	if room == 75 then
		LoadDeerGod()
		return
	end

	if room == 50 then
		LoadFigure()
		return
	end

	if room == 100 then
		LoadFigure()
		return
	end

	TryRandomEntity(room)
end

local function StartRoomWatcher()
	local previousRoom = tonumber(LatestRoom.Value) or 0

	LatestRoom.Changed:Connect(function()
		local room = tonumber(LatestRoom.Value)

		if not room or room == previousRoom then
			return
		end

		previousRoom = room

		task.delay(CONFIG.RoomDelay, function()
			HandleRoom(room)
		end)
	end)
end

local function StartShockerTimer()
	if shockerRunning then
		return
	end

	shockerRunning = true

	task.spawn(function()
		while true do
			task.wait(CONFIG.ShockerTime)
			LoadShocker()
		end
	end)
end

local function SetupCharacter(character)
	local humanoid = character:WaitForChild("Humanoid", 10)

	if humanoid then
		humanoid.WalkSpeed = CONFIG.NormalSpeed
	end
end

local function SendHardcoreMessage()
	local message =
		"[Hardcore Ping noonie ]remake by mutan red eyes and Samsung_galacy,zephyr(pro)"

	local channels = TextChatService:FindFirstChild("TextChannels")
	local general = channels and channels:FindFirstChild("RBXGeneral")

	if general then
		pcall(function()
			general:DisplaySystemMessage(
				'<font color="#00FF00">' ..
				message ..
				"</font>"
			)
		end)
	end
end

Player.CharacterAdded:Connect(SetupCharacter)

if Player.Character then
	task.spawn(function()
		SetupCharacter(Player.Character)
	end)
end

LoadCaption()
LoadStamina()
LoadSeek()
LoadSeekMusic()

StartShockerTimer()
StartRoomWatcher()

SendHardcoreMessage()

Notify(
	"Hardcore mode execute",
	"Hardcore mode loaded"
)
