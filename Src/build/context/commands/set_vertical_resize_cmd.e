indexing
	description: "Change the vertical resizement policy."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_VERTICAL_RESIZE_CMD

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
			Result := Command_names.cont_set_vertical_resize_cmd_name
		end

	context: WIDGET_C

	old_vertical_resize: BOOLEAN

	work is
		do
			old_vertical_resize := context.vertical_resizable
		end

	undo is
		local
			new_v_resize: BOOLEAN
		do
			new_v_resize := context.vertical_resizable
			context.set_vertical_resize (old_vertical_resize)
			old_vertical_resize := new_v_resize
			{CONTEXT_CMD} Precursor
		end

end -- class SET_VERTICAL_RESIZE_CMD

