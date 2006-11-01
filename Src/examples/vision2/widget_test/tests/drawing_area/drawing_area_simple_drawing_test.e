indexing
	description: "Objects that demonstrate EV_DRAWING_AREA."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_AREA_SIMPLE_DRAWING_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			vertical_box: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			create vertical_box
			create drawing_area
			vertical_box.extend (drawing_area)
			create label.make_with_text ("Left click drawing area to draw rectangle.%NRight click to clear." +
				"%NTry moving another window over the drawing area.")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
			drawing_area.set_minimum_size (250, 250)
			drawing_area.pointer_button_press_actions.force_extend (agent draw_rectangle )
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	drawing_area: EV_DRAWING_AREA
		-- Widget that test is to be performed on.
	
	draw_rectangle (an_x, a_y, a_button: INTEGER) is
			-- Draw a rectangle on `drawing_area' at position 
			-- (`an_x', `a_y') if left button pressed,
			-- otherwise if right button pressed then clear.
		do
			if a_button = 1 then
					-- The image of a drawing area is only temporary and
					-- if another window passes over the area,
					-- the old image of the area is not retained. To allow this,
					-- responding to the `expose_actions' is required and the whole image
					-- must be redrawn. Therefore, these rectangles are only temporary.
				drawing_area.draw_rectangle (an_x, a_y, 50, 50)
			elseif a_button = 3 then
				drawing_area.clear
			end
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


end -- class DRAWING_AREA_SIMPLE_DRAWING_TEST
