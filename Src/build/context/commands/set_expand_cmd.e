indexing
	description: "Change the expand policy."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_EXPAND_CMD

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
			Result := Command_names.cont_set_expand_cmd_name
		end

	context: WIDGET_C

	old_expandable: BOOLEAN

	work is
		do
			old_expandable := context.expandable
		end

	undo is
		local
			new_exp: BOOLEAN
		do
			new_exp := context.expandable
			context.set_expand (old_expandable)
			old_expandable := new_exp
			{CONTEXT_CMD} Precursor
		end

end -- class SET_EXPAND_CMD

