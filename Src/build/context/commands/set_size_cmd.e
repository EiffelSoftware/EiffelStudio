indexing
	description: "Change the size of a context."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class SET_SIZE_CMD 

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
			Result := Command_names.cont_set_size_cmd_name
		end

	context: WIDGET_C

	old_width: INTEGER

	old_height: INTEGER

	work is
		do
			old_width := context.width
			old_height := context.height
		end

	undo is
		local
			new_w, new_h: INTEGER
		do
			new_w := context.width
			new_h := context.height
			context.set_size (old_width, old_height)
			old_width := new_w
			old_height := new_h
			{CONTEXT_CMD} Precursor
		end

end -- class SET_SIZE_CMD

