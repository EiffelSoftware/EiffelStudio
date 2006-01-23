indexing
	description: "Objects that demonstrate EV_DRAWING_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_CLIPPED_TEST
	
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
			clip_area: EV_RECTANGLE
		do
			create clip_area.make (0, 100, 300, 100)
			drawing_area.clear
			from
				counter := 0
			until
				counter = 30
			loop
				temp_int := counter * 10
					-- Depending on value of `counter', set or remove
					-- the `clip_area' from `drawing_area'.
				if counter \\ 2 = 1 then
					drawing_area.set_clip_area (clip_area)
				else
					drawing_area.remove_clip_area
				end
				drawing_area.draw_ellipse (150 - (temp_int // 2), 150 - (temp_int // 2) , temp_int, temp_int)
				counter := counter + 1
			end
			drawing_area.remove_clip_area
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


end -- class DRAWING_AREA_CLIPPED_TEST
