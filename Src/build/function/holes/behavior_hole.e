indexing
	description: "Hole which can receive behavior data. Output of state function."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class BEHAVIOR_HOLE 

inherit
	ELMT_HOLE
		redefine
			make_with_editor,
			symbol
		end

creation
	make_with_editor
	
feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; func: STATE_EDITOR) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par, func)
			create cmd.make (func~update_output_hole)
			add_pnd_command (Pnd_types.behavior_type, cmd, Void)
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.behavior_pixmap
		end

end -- class BEHAVIOR_HOLE

