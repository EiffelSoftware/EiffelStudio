indexing

	description: "Command for the trash hole: removes data objects.";
	date: "$Date$";
	revision: "$Revision $"

class TRASH_HOLE_COM

inherit
	--EC_LICENCED_COMMAND
	--	redefine 
	--		process_any, stone_type
	--	end

	EV_COMMAND

	CONSTANTS

feature {BUTTON_HOLE} -- Properties 

	stone_type: INTEGER is
			-- Stone type of hole associated to Current command
		once
			Result := Stone_types.any_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing button associated to Current command
		once
			--Result := Pixmaps.trash_pixmap
		end

feature {BUTTON_HOLE} -- Update

	process_any (s: STONE) is
			-- Process stone dropped in Current command associated hole:
			-- Destroy dropped stone `s'.
		do
			s.destroy_data
		end

feature {NONE} -- Inapplicable

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Callback for associated button:
			--| Not a clickable button.
		do
		end

end -- class TRASH_HOLE_COM
