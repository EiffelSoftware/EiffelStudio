indexing
	description: "Change the position of a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SET_POSITION_CMD

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
			Result := Command_names.cont_set_position_cmd_name
		end

	context: WIDGET_C

	old_x: INTEGER

	old_y: INTEGER

	work is
		do
			old_x := context.x
			old_y := context.y
		end

	undo is
		local
			new_x, new_y: INTEGER
		do
			new_x := context.x
			new_y := context.y
			context.set_x_y (old_x, old_y)
			old_x := new_x
			old_y := new_y
			{CONTEXT_CMD} Precursor
		end

end -- class SET_POSITION_CMD

