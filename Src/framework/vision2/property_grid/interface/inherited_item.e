indexing
	description: "Item that represents that a value is inherited from somewhere else."
	date: "$Date$"
	revision: "$Revision$"

class
	INHERITED_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		do
			Precursor
			expose_actions.force (agent draw_inherited)
		end

feature {NONE} -- Agents

	draw_inherited (a_drawable: EV_DRAWABLE) is
			-- Draw
		do
			a_drawable.clear
			a_drawable.draw_pixmap (0, 0, inherited)
		end

feature {NONE} -- Implementation

	inherited: EV_PIXMAP is
			-- Icon for inherited
		once
			create Result
			Result.set_with_named_file ("inherited.png")
		end


end
