indexing
	description: "Item that represents that a value overrides an inherited value."
	date: "$Date$"
	revision: "$Revision$"

class
	OVERRIDEN_ITEM

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
			expose_actions.force (agent draw_overriden)
		end

feature {NONE} -- Agents

	draw_overriden (a_drawable: EV_DRAWABLE) is
			-- Draw
		do
			a_drawable.clear
			a_drawable.draw_pixmap (0, 0, overriden)
		end

feature {NONE} -- Implementation

	overriden: EV_PIXMAP is
			-- Icon for inherited
		once
			create Result
			Result.set_with_named_file ("overriden.png")
		end


end
