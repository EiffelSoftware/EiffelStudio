indexing
	description: "Objects that representa color being transported."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COLOR_STONE
	
create
	make_with_properties
	
feature {NONE}

	make_with_properties (a_color: EV_COLOR; foreground: BOOLEAN) is
			-- Create `Current' and assign `a_color' to `color' and `foreground' to `is_foreground'.
		require
			a_color_not_void: a_color /= Void
		do
			color := a_color
			is_foreground := foreground
		end

feature -- Access

	color: EV_COLOR
		-- Color represented by `Color'.
	
	is_foreground: BOOLEAN
		-- Does `Current' represent a foreground color?

end -- class GB_COLOR_STONE
