indexing
	description: 
		"BOX_DEMO_WINDOW, demo window to test box widget.%
		% Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	BOX_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			actions_window,
			main_widget,
			set_widgets,
			set_values
		end
	
creation
	make

feature -- Access

	main_widget: EV_HORIZONTAL_BOX is
			-- The main widget of the demo
		once
			!!Result.make (Current)
			Result.set_border_width (10)
		end
	
feature -- Access
	
	actions_window: BOX_ACTIONS_WINDOW

	button1, button2, button3: EV_BUTTON
			-- Buttons for the demo

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			!!button1.make (main_widget)
			!!button2.make (main_widget)
			!!button3.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Box demo")
			button1.set_text ("Press me")
			button2.set_text ("Button with a very long label")
			button3.set_text ("Button3")
			main_widget.set_homogeneous (False)
		end

end -- class BOX_DEMO_WINDOW

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

