indexing
	description: "Change the horizontal resizement policy."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_HORIZONTAL_RESIZE_CMD

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
			Result := Command_names.cont_set_horizontal_resize_cmd_name
		end

	context: WIDGET_C

	old_horizontal_resize: BOOLEAN

	work is
		do
			old_horizontal_resize := context.horizontal_resizable
		end

	undo is
		local
			new_h_resize: BOOLEAN
		do
			new_h_resize := context.horizontal_resizable
			context.set_horizontal_resize (old_horizontal_resize)
			old_horizontal_resize := new_h_resize
			{CONTEXT_CMD} Precursor
		end

end -- class SET_HORIZONTAL_RESIZE_CMD

