indexing
	description: "Objects that test an EV_SCROLLABLE_AREA with an `item'%
		%contained that is larger than its current size."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCROLLABLE_AREA_LARGE_ITEM_TEST

inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Implementation

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			button: EV_BUTTON
		do
			create scrollable_area
			scrollable_area.set_minimum_size (300, 300)
			create drawing_area
			drawing_area.set_minimum_size (500, 500)
			drawing_area.expose_actions.extend (agent update_drawing)
				-- Set a light blue as `foreground_color' of `drawing_area'.
			drawing_area.set_foreground_color (
				create {EV_COLOR}.make_with_8_bit_rgb (140, 149, 255))
			scrollable_area.extend (drawing_area)
			
			widget := scrollable_area
		end
	
feature {NONE} -- Implementation

	scrollable_area: EV_SCROLLABLE_AREA
	
	drawing_area: EV_DRAWING_AREA
		-- A drawing area to be inserted inside `scrollable_area' for this test.
		
	update_drawing (x, y, width, height: INTEGER) is
			-- Draw rectangles filling `drawing_area'
			-- using `all_stock_colors'.
		local
			x_counter, y_counter: INTEGER
		do
				-- Clear the drawing area
			drawing_area.clear
			from
				x_counter := 0
			until
				x_counter > 4
			loop
				from
					y_counter := 0
				until
					y_counter > 4
				loop
					drawing_area.fill_rectangle (x_counter * 100, y_counter * 100, 50, 50)
					y_counter := y_counter + 1
				end
				x_counter := x_counter + 1
			end
		end

end -- class SCROLLABLE_AREA_LARGE_ITEM_TEST
