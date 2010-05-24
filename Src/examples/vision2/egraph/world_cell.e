note
	description: "Objects that is a EV_MODEL_WORLD_CELL using an EG_PROJECTOR to display an EG_FIGURE_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	WORLD_CELL

inherit
	EV_MODEL_WORLD_CELL
		redefine
			new_projector,
			world
		end

create
	make_with_world

feature -- Access

	world: EG_FIGURE_WORLD
			-- World `Current' displays.

feature {NONE} -- Implementation

	new_projector: EV_MODEL_WIDGET_PROJECTOR
			-- <Precursor>
		do
			create {EG_PROJECTOR} Result.make (world, drawing_area)
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WORLD_CELL
