indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SPLIT_AREA_WINDOW

inherit
	EV_VERTICAL_SPLIT_AREA
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
			-- We first create the split area without parent,
			-- it is more efficient.
		do
			{EV_VERTICAL_SPLIT_AREA} Precursor (Void)
			!! hsplit.make (Current)
			set_position (50)
			!! button.make_with_text (hsplit, "Hello")
			hsplit.set_position (100)
			!! texta.make (Current)
			set_position (50)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "split area")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend (split_area_tab)
			create action_window.make (hsplit, tab_list)
		end

feature -- Access

	hsplit: EV_HORIZONTAL_SPLIT_AREA
		-- An horizontal split area for the demo

	button: EV_BUTTON
		-- A button for the demo

	texta: EV_TEXT
		-- A text are for the demo

end -- class SPLIT_AREA_WINDOW

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

