indexing
	description: "Change the repartition of the widget in the container."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	SET_HOMOGENEOUS_CMD

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
			Result := Command_names.cont_set_homogeneous_cmd_name
		end

	context: INVISIBLE_CONTAINER_C

	old_homogeneous: BOOLEAN

	work is
		do
			old_homogeneous := context.is_homogeneous
		end

	undo is
		local
			new_homogeneous: BOOLEAN
		do
			new_homogeneous := context.is_homogeneous
			context.set_homogeneous (old_homogeneous)
			old_homogeneous := new_homogeneous
			{CONTEXT_CMD} Precursor
		end

end -- class SET_HOMOGENEOUS_CMD

