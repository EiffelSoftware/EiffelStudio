indexing
	description: "Change the minimum size of a widget."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_MINIMUM_SIZE_CMD

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
			Result := Command_names.cont_set_minimum_size_cmd_name
		end

	context: WIDGET_C

	old_min_width, old_min_height: INTEGER

	work is
		do
			old_min_width := context.minimum_width
			old_min_height := context.minimum_height
		end

	undo is
		local
			new_w, new_h: INTEGER
		do
			new_w := context.minimum_width
			new_h := context.minimum_height
			context.set_minimum_size (old_min_width, old_min_height)
			old_min_width := new_w
			old_min_height := new_h
			{CONTEXT_CMD} Precursor
		end

end -- class SET_MINIMUM_SIZE_CMD

