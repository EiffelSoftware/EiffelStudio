indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FIXED

inherit
	EV_FIXED
		redefine
			set_item_position
		end

feature

	set_item_position (a_widget: EV_WIDGET; an_x: INTEGER; a_y: INTEGER) is
			-- Only weak precondition.
		require else
			not_destroyed: not is_destroyed
			has_a_widget: has (a_widget)
		do
			Precursor {EV_FIXED} (a_widget, an_x, a_y)
		end
		
end
