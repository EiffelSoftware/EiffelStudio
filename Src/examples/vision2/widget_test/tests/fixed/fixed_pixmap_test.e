indexing
	description: "Objects that demonstrate an EV_FIXED%
		%with a background_pixmap"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FIXED_PIXMAP_TEST
	
inherit
	COMMON_TEST
		redefine
			default_create
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create `Current' and initialize test in `widget'.
		local
			counter: INTEGER
			button: EV_BUTTON
		do
			create fixed
			fixed.set_minimum_size (fixed_dimension, fixed_dimension)
			fixed.set_background_pixmap (background_pixmap)
			from
				counter := 0
			until
				counter > widgets_fitting * widgets_fitting
			loop
				if counter \\ 2 = 1 then
					create button.make_with_text ("A button")
					fixed.extend (button)
					button.set_minimum_size (widget_dimension, widget_dimension)
					fixed.set_item_position (button, (counter \\ widgets_fitting) * widget_dimension,
						(counter // widgets_fitting) * widget_dimension)
				end
				counter := counter + 1
			end
			
			widget := fixed
		end

feature {NONE} -- Implementation

	background_pixmap: EV_PIXMAP is
			-- Image used for background of `fixed'.
		do
			create Result
			Result.set_foreground_color ((create {EV_STOCK_COLORS}).red)
			Result.set_background_color ((create {EV_STOCK_COLORS}).white)
			Result.clear
			Result.set_minimum_size (40, 40)
			Result.set_size (40, 40)
			Result.fill_ellipse (5, 5, 30, 30)
		end
		
	widget_dimension: INTEGER is 60
		-- Dimension used for `width' and `height' of widgets in `fixed'.
		
	fixed_dimension: INTEGER is 300
		-- Dimension to be used as `minimum_width' and `minimum_height' of `fixed'.
		
	widgets_fitting: INTEGER is
		-- Result is `fixed_dimension' divided by `widget_dimnsion'.
		once
			Result := fixed_dimension // widget_dimension	
		end
		
	fixed: EV_FIXED;
		-- Widget that test is to be performed on.

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


end -- class FIXED_PIXMAP_TEST
