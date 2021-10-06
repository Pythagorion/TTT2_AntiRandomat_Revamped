//Some code has been adapted from Gamefreak. All credits go to him.
net.Receive("AntiRandomatRanWeps", function()
    local is_item = net.ReadBit() == 1
    local id = is_item and net.ReadUInt(16) or net.ReadString()
    hook.Add("TTTBoughtItem", is_item, id)
end)