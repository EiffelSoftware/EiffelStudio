indexing
	description: "Objects that demonstrate EV_PIXMAP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PIXMAP_DRAWING_TEST
	
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
			create pixmap
			vertical_box.extend (pixmap)
			create label.make_with_text ("Left click pixmap to draw rectangle.%NRight click to clear.")
			vertical_box.extend (label)
			vertical_box.disable_item_expand (label)
			
				-- The minimum size of a pixmap is 0x0 pixels,
				-- so we must assign one, in order for it to be visible.
				-- We must also set the size of the image allocated to the pixmap.
			pixmap.set_minimum_size (250, 250)
			pixmap.set_size (300, 300)
			pixmap.pointer_button_press_actions.force_extend (agent draw_rectangle )
			widget := vertical_box
		end
		
feature {NONE} -- Implementation

	pixmap: EV_PIXMAP
		-- Widget that test is to be performed on.
	
	draw_rectangle (an_x, a_y, a_button: INTEGER) is
			-- Draw a rectangle on `pixmap' at position 
			-- (`an_x', `a_y') if left button pressed,
			-- otherwise if right button pressed,
			-- clear.
		do
			if a_button = 1 then
				pixmap.draw_rectangle (an_x, a_y, 50, 50)
			elseif a_button = 3 then
				pixmap.clear
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


end -- class PIXMAP_DRAWING_TEST
