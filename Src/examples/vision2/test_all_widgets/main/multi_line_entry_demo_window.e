indexing
	description: 
		"TEXT_AREA_DEMO_WINDOW, demo window to test multi line%
		% text area widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	TEXT_AREA_DEMO_WINDOW

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

	main_widget: EV_TEXT is
			-- The main widget of the demo
		once
			!! Result.make (Current)
		end
	

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Text area demo")
			main_widget.append_text ("edit me")
		end

end -- class TEXT_AREA_DEMO_WINDOW

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

