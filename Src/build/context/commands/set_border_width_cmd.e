indexing
	description: "Change the border width of the container."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_BORDER_WIDTH_CMD

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
			Result := Command_names.cont_set_border_width_cmd_name
		end

	context: INVISIBLE_CONTAINER_C

	old_border_width: INTEGER

	work is
		do
			old_border_width := context.border_width
		end

	undo is
		local
			new_border_width: INTEGER
		do
			new_border_width := context.border_width
			context.set_border_width (old_border_width)
			old_border_width := new_border_width
			{CONTEXT_CMD} Precursor
		end

end -- class SET_BORDER_WIDTH_CMD

