local EVENT = {}

EVENT.Title = "ttt2_event_sideways"
EVENT.Time = 90

function EVENT:Boot()
	self:AddHook("SetupMove", function(ply, mv, cmd)
		if ply:IsTerror() then
			mv:SetForwardSpeed(0)
		end
	end)
end

AntiRandomat:register("sideways", EVENT)
