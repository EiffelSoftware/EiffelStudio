indexing
	description: "Hole which can receive context data. Input of state function."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class CONTEXT_HOLE 

inherit
	ELMT_HOLE
		redefine
			make_with_editor,
			symbol
		end

creation
	make_with_editor
	
feature {NONE} -- Initialization

	make_with_editor (par: EV_TOOL_BAR; func: FUNC_EDITOR) is
		local
			cmd: EV_ROUTINE_COMMAND
		do
			Precursor (par, func)
			create cmd.make (func~update_input_hole)
			add_pnd_command (Pnd_types.context_type, cmd, Void)
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end

end -- class CONTEXT_HOLE

