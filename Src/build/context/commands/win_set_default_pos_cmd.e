indexing
	description: "Change the starting position (default/gived position) of the window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class WIN_SET_DEFAULT_POS_CMD 

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.window_att_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_win_position_cmd_name
		end

	context: WINDOW_C

	old_default_state: BOOLEAN

	work is
		do
			old_default_state := context.default_position
		end

	undo is
		local
			new_default_state: BOOLEAN
		do
			new_default_state := context.default_position
			context.set_default_position (old_default_state)
			old_default_state := new_default_state
			{CONTEXT_CMD} Precursor
		end

end -- class WIN_SET_DEFAULT_POS_CMD

