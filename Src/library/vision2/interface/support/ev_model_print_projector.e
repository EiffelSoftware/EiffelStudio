indexing
	description:
		"Projection to a Printer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PRINT_PROJECTOR

inherit

	EV_ANY
		redefine
			implementation
		end

	EV_MODEL_PROJECTOR
		undefine
			default_create,
			copy
		end

create
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_world: EV_MODEL_WORLD; a_context: EV_PRINT_CONTEXT) is
			-- Create with `a_world' and `a_context'.
		require
			a_world_not_void: a_world /= Void
			a_context_not_void: a_context /= Void
			has_printer: not a_context.output_to_file implies (create {EV_ENVIRONMENT}).has_printer
			output_file_unique: a_context.output_to_file implies
						not (create {RAW_FILE}.make (a_context.file_name.as_string_8)).exists
		do
			world := a_world
			context := a_context.twin
			default_create
		end

feature -- Basic operations

	project is
			-- Make a standard projection of the world on the device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.project
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	context: EV_PRINT_CONTEXT

	implementation: EV_MODEL_PRINT_PROJECTOR_I

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MODEL_PRINT_PROJECTOR_IMP} implementation.make (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_PROJECTOR

