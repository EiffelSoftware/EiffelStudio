indexing
	description: "Objects that is a EV_MODEL_WORLD_CELL using an EG_PROJECTOR to display an EG_FIGURE_WORLD."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	WORLD_CELL
	
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
	
	world: EG_FIGURE_WORLD
			-- World `Current' displays.
	
end -- class WORLD_CELL
