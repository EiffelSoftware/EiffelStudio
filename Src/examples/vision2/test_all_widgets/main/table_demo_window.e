indexing
	description:
		" TABLE_DEMO_WINDOW, demo window to test the table %
		%widget. Belongs to EiffelVision example test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	TABLE_DEMO_WINDOW

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

	main_widget: EV_TABLE is
			-- The main widget of the demo
		once
			create Result.make (Current)
			Result.set_minimum_size(300,300)
		end
	
feature -- Access
	
	note: EV_NOTEBOOK
	text: EV_TEXT_FIELD
	button: EV_BUTTON

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			create button.make_with_text (main_widget, "OK")
			main_widget.set_child_position (button, 0, 0, 3, 1)

			create note.make (main_widget)
			create button.make_with_text (note, "Press me")
			note.append_page (button, "Page 1")
			create button.make_with_text (note, "Me too")
			note.append_page (button, "Page 2")
			main_widget.set_child_position (note, 1, 1, 3, 3)
			create text.make (main_widget)
			main_widget.set_child_position (text, 0, 1, 1, 3)
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Dynamic table demo")
			main_widget.set_homogeneous (False)
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


end -- class TABLE_DEMO_WINDOW

