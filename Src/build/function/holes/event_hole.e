indexing
	description: "Hole which can receive event stones.%
				% Input of behavior function."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class EVENT_HOLE

inherit
	ELMT_HOLE
		redefine
			make_with_editor,
			symbol
		end

creation
	make_with_editor

feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; func: BEHAVIOR_EDITOR) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par, func)

			create cmd.make (func~update_input_hole)
			add_pnd_command (Pnd_types.event_type, cmd, Void)
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.event_pixmap
		end

--	associated_label: STRING is
--		do
--			Result := Widget_names.event_label
--		end

end -- class EVENT_HOLE

