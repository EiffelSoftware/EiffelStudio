indexing
	description: "Set iconic state at start of application."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PERM_ICONIC_CMD

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
			if context.is_iconic_state then
				Result := Command_names.cont_perm_iconic_cmd_name
			elseif context.is_maximize_state then
				Result := Command_names.cont_perm_maximize_cmd_name
			else
				Result := Command_names.cont_perm_normal_cmd_name
			end
		end

	context: WINDOW_C

	old_iconic_state, old_maximize_state: BOOLEAN

	work is
		do
			old_iconic_state := context.is_iconic_state
			old_maximize_state := context.is_maximize_state
		end

	undo is
		local
			new_iconic_state, new_maximize_state: BOOLEAN
		do
			new_iconic_state := context.is_iconic_state
			new_maximize_state := context.is_maximize_state
			context.set_iconic_state (old_iconic_state)
			context.set_maximize_state (old_maximize_state)
			old_iconic_state := new_iconic_state
			old_maximize_state := new_maximize_state
			{CONTEXT_CMD} Precursor
		end

end -- class PERM_ICONIC_CMD

