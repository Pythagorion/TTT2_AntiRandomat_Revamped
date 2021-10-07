net.Receive("AntiRandomatMSG", function()
    local message_str = net.ReadString()

    EPOP:AddMessage({text = message_str, color = 133, 1, 25,255}, "", 10)
    surface.PlaySound("weapons/init_c4_cs.wav") 
end)