indexing
	description: "Change the spacing of the container."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_SPACING_CMD

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
			Result := Command_names.cont_set_spacing_cmd_name
		end

	context: INVISIBLE_CONTAINER_C

	old_spacing: INTEGER

	work is
		do
			old_spacing := context.spacing
		end

	undo is
		local
			new_spacing: INTEGER
		do
			new_spacing := context.spacing
			context.set_spacing (old_spacing)
			old_spacing := new_spacing
			{CONTEXT_CMD} Precursor
		end

end -- class SET_SPACING_CMD

