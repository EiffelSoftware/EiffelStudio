indexing
	description: 
		"NOTEBOOK_DEMO_WINDOW, demo window to test notebook widget.%
		% Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	NOTEBOOK_DEMO_WINDOW

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

	main_widget: EV_NOTEBOOK is
			-- The main widget of the demo
		once
			!! Result.make (Current)
		end
	
feature -- Access

	button1, button_box: EV_BUTTON
		-- Buttons for the demo

	box: EV_VERTICAL_BOX
		-- Box for the demo
	
feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			!! button1.make (main_widget)
			!! box.make (main_widget)
			!! button_box.make_with_text (box, "button 1")
			!! button_box.make_with_text (box, "button 2")
			!! button_box.make_with_text (box, "button 3")
			!! button_box.make_with_text (box, "button 4")
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Notebook demo")
			button1.set_text ("Button")			
			main_widget.append_page (button1, "Button")
			main_widget.append_page (box, "Pixmap 2")
			main_widget.set_current_page (2)
		end

end -- class NOTEBOOK_DEMO_WINDOW

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

