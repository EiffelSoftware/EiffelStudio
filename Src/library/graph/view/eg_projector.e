indexing
	description: "Objects that ..."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EG_PROJECTOR

inherit
	EV_MODEL_BUFFER_PROJECTOR
		redefine
			world,
			full_project,
			project
		end
	
create
	make_with_buffer
	
feature -- Access

	world: EG_FIGURE_WORLD

feature -- Display updates

	full_project is
			-- Project entire area.
		do
			world.update
			Precursor {EV_MODEL_BUFFER_PROJECTOR}
		end
		
	project is
			-- Make a standard projection of world on device.
		do
			world.update
			Precursor {EV_MODEL_BUFFER_PROJECTOR}
		end

end -- class EG_PROJECTOR

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

