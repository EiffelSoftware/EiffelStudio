indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	BOX_WINDOW

inherit
	EV_HORIZONTAL_BOX
		redefine
			make
		end
	DEMO_WINDOW
	WIDGET_COMMANDS		

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the box without
			-- parent.
		do
			{EV_HORIZONTAL_BOX} Precursor (Void)
			set_border_width (10)
			!! button.make_with_text (Current, "Press me")
			!! button.make_with_text (Current, "Button with a very long label")
			set_child_expandable (button, False)
			!! button.make_with_text (Current, "Button 3")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "box")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
			set_container_tabs
			tab_list.extend (box_tab)
			create action_window.make (Current, tab_list)
		end


feature -- Access

	button: EV_BUTTON

end -- class BOX_WINDOW

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

