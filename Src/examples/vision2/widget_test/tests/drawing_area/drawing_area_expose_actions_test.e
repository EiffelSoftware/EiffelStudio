indexing
	description: "Objects that demonstrate EV_DRAWING_AREA."
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_EXPOSE_ACTIONS_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		do
			create drawing_area
			drawing_area.set_minimum_size (300, 300)
			drawing_area.expose_actions.force_extend (agent redraw_figures)
			widget := drawing_area
		end
		
feature {NONE} -- Implementation

	drawing_area: EV_DRAWING_AREA
		-- Widget that test is to be performed on.
	
	redraw_figures is
			-- Clear `drawing_area' and draw set of figures.
			-- A drawing area does not keep its current image 
			-- internally, and therefore must be redrawn each time
			-- it requests this, via the `expose_actions'.
		local
			counter: INTEGER
			temp_int: INTEGER
		do
			drawing_area.clear
			from
				counter := 0
			until
				counter = 30
			loop
				temp_int := counter * 10
				drawing_area.draw_ellipse (150 - (temp_int // 2), 150 - (temp_int // 2) , temp_int, temp_int)
				counter := counter + 1
			end
		end
		
end -- class DRAWING_AREA_EXPOSE_ACTIONS_TEST
