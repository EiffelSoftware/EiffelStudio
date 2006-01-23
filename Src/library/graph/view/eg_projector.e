indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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




end -- class EG_PROJECTOR

