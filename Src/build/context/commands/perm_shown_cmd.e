indexing
	description: "Change the start state (hidden/shown) of the window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_SHOWN_CMD

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
			Result := Command_names.cont_perm_shown_cmd_name
		end

	context: WINDOW_C

	old_hidden: BOOLEAN

	work is
		do
			old_hidden := context.start_hidden
		end

	undo is
		local
			new_hidden: BOOLEAN
		do
			new_hidden := context.start_hidden
			context.set_start_hidden (old_hidden)
			old_hidden := new_hidden
			{CONTEXT_CMD} Precursor
		end

end -- class PERM_SHOWN_CMD

