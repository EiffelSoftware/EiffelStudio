indexing
	description: "Objects that is a EV_MODEL_WORLD_CELL using an EG_PROJECTOR to display an EG_FIGURE_WORLD."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_WORLD_CELL
	
inherit
	EV_MODEL_WORLD_CELL
		redefine
			projector,
			world
		end

create
	make_with_world
	
feature -- Access

	projector: EG_PROJECTOR
			-- Projector used to render `world'.
	
	world: EG_FIGURE_WORLD;
			-- World `Current' displays.
	
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




end -- class WORLD_CELL
