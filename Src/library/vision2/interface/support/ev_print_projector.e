indexing
	description:
		"Projection to a Printer."
	status: "See notice at end of class"
	keywords: "printer, output, projector"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_PROJECTOR

inherit

	EV_ANY
		redefine
			implementation
		end

	EV_PROJECTOR
		undefine
			default_create,
			copy
		end

create
	make_with_context

feature {NONE} -- Initialization

	make_with_context (a_world: EV_FIGURE_WORLD; a_context: EV_PRINT_CONTEXT) is
			-- Create with `a_world' and `a_context'.
		require
			a_world_not_void: a_world /= Void
			a_context_not_void: a_context /= Void
			output_file_unique: a_context.output_to_file implies
						not (create {RAW_FILE}.make (a_context.file_name)).exists
		do
			world := a_world
			context := clone (a_context)
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

feature {EV_ANY_I} -- Implementation

	context: EV_PRINT_CONTEXT

	implementation: EV_PRINT_PROJECTOR_I

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_PRINT_PROJECTOR_IMP} implementation.make (Current)
		end

end -- class EV_PRINT_PROJECTOR

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------
