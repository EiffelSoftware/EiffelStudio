indexing
	description: 
		"SPLIT_AREA_DEMO_WINDOW, demo window to test split_area%
		% widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	SPLIT_AREA_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end
	
creation
	make

feature -- Access

	main_widget: EV_VERTICAL_SPLIT_AREA is
			-- The main widget of the demo
		once
			!! Result.make (Current)
		end
	
	
	h: EV_HORIZONTAL_SPLIT_AREA
		-- A split area for the demo

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			button: EV_BUTTON
			texta: EV_TEXT
		do
			-- The first child of the vertical split area
			-- is a horizontal split area
			!! h.make (main_widget)
			-- The first child of the horizontal split
			-- area is a button
			!! button.make_with_text (h, "Hello")
			-- There is no second child for the horizontal
			-- split area (this is acceptable)
			
			-- The second child of the vertical split area
			-- is a text area
			!! texta.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Split area demo")
		end

end -- class SPLIT_AREA_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

