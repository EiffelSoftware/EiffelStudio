indexing
	description: "Item that allows to force child properties to use the inherited value."
	date: "$Date$"
	revision: "$Revision$"

class
	FORCE_INHERIT_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			initialize,
			is_in_default_state
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialization
		do
			Precursor
			expose_actions.force (agent draw_inherited)

			set_tooltip ("Force child properties to use inherited value.")
		end

feature {NONE} -- Agents

	draw_inherited (a_drawable: EV_DRAWABLE) is
			-- Draw
		do
			a_drawable.clear
			a_drawable.draw_pixmap (0, 0, force_inherit)
		end

feature {NONE} -- Implementation

	force_inherit: EV_PIXMAP is
			-- Icon for inherited
		once
			create Result
			Result.set_with_named_file ("forceinherit.png")
		end

	is_in_default_state: BOOLEAN is True
			-- Contract.

end

