indexing
	description: "Change resizement policy of a window."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class WINDOW_RESIZE_CMD 

inherit
	CONTEXT_CMD
		redefine
			context, undo
		end

feature {NONE} -- Implementation

	associated_form: INTEGER is
		do
			Result := Context_const.geometry_form_nbr
		end

	name: STRING is
		do
			Result := Command_names.cont_win_resize_cmd_name
		end

	context: WINDOW_C

	old_resize_policy: BOOLEAN

	work is
		do
			old_resize_policy := context.resize_policy_disabled
		end

	undo is
		local
			new_resize_policy: BOOLEAN
		do
			new_resize_policy := context.resize_policy_disabled
			context.disable_resize_policy (old_resize_policy)
			old_resize_policy := new_resize_policy
			{CONTEXT_CMD} Precursor
		end

end -- class WINDOW_RESIZE_CMD

