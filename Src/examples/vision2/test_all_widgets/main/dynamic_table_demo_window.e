indexing
	description:
		"DYNAMIC_TABLE_DEMO_WINDOW, demo window to test the%
		% dynamic table widget. Belongs to EiffelVision example%
		% test_all_widgets.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_TABLE_DEMO_WINDOW

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

	main_widget: EV_DYNAMIC_TABLE is
			-- The main widget of the demo
		once
			!! Result.make (Current)
			Result.set_row_layout
			Result.set_finite_dimension (2)
		end
	
feature -- Access
	
	button: EV_BUTTON

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			!!button.make_with_text (main_widget, "Element 1")
			!!button.make_with_text (main_widget, "Element 2")
			!!button.make_with_text (main_widget, "Element 3")
			!!button.make_with_text (main_widget, "Element 4")
			!!button.make_with_text (main_widget, "Element 5")
			!!button.make_with_text (main_widget, "Element 6")
			!!button.make_with_text (main_widget, "Element 7")
			!!button.make_with_text (main_widget, "Element 8")
			!!button.make_with_text (main_widget, "Element 9")
			!!button.make_with_text (main_widget, "Element 10")
			!!button.make_with_text (main_widget, "Element 11")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Dynamic table demo")
			main_widget.set_homogeneous (True)
			main_widget.set_row_spacing (5)
			main_widget.set_column_spacing (5)
		end

end -- class DYNAMIC_TABLE_DEMO_WINDOW

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

