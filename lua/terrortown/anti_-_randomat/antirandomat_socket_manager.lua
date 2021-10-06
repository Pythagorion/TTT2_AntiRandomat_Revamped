//Some code has been adapted from Gamefreak. All credits go to him.
util.AddNetworkString("AntiRandomatMSG")

AntiRandomat.EvilEvents = AntiRandomat.EvilEvents or {}
AntiRandomat.EvilMapEvents = AntiRandomat.EvilMapEvents or {}
AntiRandomat.RunningEvilEvents = {}

local antirandomat_contents = {}
antirandomat_contents.identifier = antirandomat_contents

local function randomizeTable(t)
    math.randomseed(os.time())
    local rdm = math.random 

    local interacts = #t
    local k 

    for i = interacts, 2, -1 do
        k = rdm(i)
        t[i], t[k] = t[k], t[i]
    end
end

local function e_eventIndices()
    math.randomseed(os.time())
    local lgth = math.random(1, 10)

    if lgth < 1 then return end

    local output = ""

    for i=1, lgth do
        output = output .. string.char(math.random(32, 126))
    end

    return output
end

function AntiRandomat:initialize(id, tbl)
    if AntiRandomat.EvilEvents[id] then error("ttt2_weapon_antirandomat_error" .. id) return end
    tbl.Id = id
    tbl.identifier = tbl
    setmetatable(tbl, antirandomat_contents)
    AntiRandomat.EvilEvents[id] = tbl
end

function AntiRandomat:TriggerEvilEvent(ply)
    if table.Count(AntiRandomat.EvilMapEvents) == 0 then AntiRandomat.EvilMapEvents = table.Copy(AntiRandomat.EvilEvents) end
    local evs = AntiRandomat.EvilMapEvents
    local indices = e_eventIndices()
    randomizeTable(evs)
    local e_event = table.Random(evs)
    AntiRandomat.RunningEvilEvents[indices] = e_event
    AntiRandomat.RunningEvilEvents[indices].Ident = indices
    AntiRandomat.RunningEvilEvents[indices].Owner = ply 
    AntiRandomat:EventAnnouncement(AntiRandomat.RunningEvilEvents[indices].Title)
    AntiRandomat.RunningEvilEvents[indices]:Boot()

    if AntiRandomat.RunningEvilEvents[indices].Time ~= nil then
        timer.Create("Anti-Randomat" .. AntiRandomat.RunningEvilEvents[indices].Ident, AntiRandomat.RunningEvilEvents[indices].Time or 60, 1, function()
            AntiRandomat.RunningEvilEvents[indices]:Terminate()
            AntiRandomat.RunningEvilEvents[indices] = nil
        end)
    end
    AntiRandomat.EvilMapEvents[e_event.Id]
end

function AntiRandomat:EventAnnouncement(title)
    net.Start("AntiRandomatMSG")
    net.Broadcast()
end

function antirandomat_contents:GetEveryPlayer(rand)
    return self:GetLivingPlys(rand)
end

function antirandomat_contents:GetLivingPlys(rand)
    local plys = player.GetAll()

    for i=1, #plys do
        local ply = plys[i]

        if IsValid(ply) and not ply:IsSpec() and ply:IsActive() and ply:Alive() then
            table.insert(plys, ply)
        end
    end

    if rand then
        randomizeTable(plys)
    end

    return plys
end

function antirandomat_contents:AddHook(hooktype, callbackfunc)
    callbackfunc = callbackfunc or self[hooktype]

    hook.Add(hooktype, "AntiRandomatEvilEvent." .. self.Ident .. "." .. self.Id .. ":" .. hooktype, function(...)
        return callbackfunc(...)
    end)

    self.Hooks = self.Hooks or {}

    table.insert(self.Hooks,{hooktype, "AntiRandomatEvilEvent." .. self.Ident .. "." .. self.Id .. ":" .. hooktype})
end

function antirandomat_contents:PurgeHooks()
    if not self.Hooks then return end

    for _, thook in pairs(self.Hooks) do
        hook.Remove(thook[1], thook[2])
    end

    table.Empty(self.Hooks)
end

function antirandomat_contents:Boot() end

function antirandomat_contents:Terminate()
    self:PurgeHooks()
end

hook.Add("TTTEndRound", "AntiRandomatRoundEnd", function()
    if AntiRandomat.RunningEvilEvents ~= {} then
        for _, r_events in pairs(AntiRandomat.RunningEvilEvents) do
            timer.Remove("Anti-Randomat" .. r_events.Ident)
            r_events:Terminate()
        end

        AntiRandomat.RunningEvilEvents = {}
    end
end)

hook.Add("TTTPrepareRound", "AntiRandomatRoundPreparation", function()
    if AntiRandomat.RunningEvilEvents ~= {} then
        for _, r_events in pairs(AntiRandomat.RunningEvilEvents) do
            timer.Remove("Anti-Randomat" .. r_events.Ident)
            r_events:Terminate()
        end

        AntiRandomat.RunningEvilEvents = {}
    end
end)
