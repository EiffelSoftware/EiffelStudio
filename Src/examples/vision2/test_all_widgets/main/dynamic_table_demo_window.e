indexing
	description:
		"DYNAMIC_TABLE_DEMO_WINDOW, demo window to test the%
		% dynamic table widget. Belongs to EiffelVision example%
		% test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature -- Access

	main_widget: EV_DYNAMIC_TABLE is
			-- The main widget of the demo
		once
			create Result.make (Current)
			Result.set_row_layout
			Result.set_finite_dimension (2)
		end
	
feature -- Access
	
	button: EV_BUTTON

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			create button.make_with_text (main_widget, "Element 1")
			create button.make_with_text (main_widget, "Element 2")
			create button.make_with_text (main_widget, "Element 3")
			create button.make_with_text (main_widget, "Element 4")
			create button.make_with_text (main_widget, "Element 5")
			create button.make_with_text (main_widget, "Element 6")
			create button.make_with_text (main_widget, "Element 7")
			create button.make_with_text (main_widget, "Element 8")
			create button.make_with_text (main_widget, "Element 9")
			create button.make_with_text (main_widget, "Element 10")
			create button.make_with_text (main_widget, "Element 11")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Dynamic table demo")
			main_widget.set_homogeneous (True)
			main_widget.set_row_spacing (5)
			main_widget.set_column_spacing (5)
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


end -- class DYNAMIC_TABLE_DEMO_WINDOW

