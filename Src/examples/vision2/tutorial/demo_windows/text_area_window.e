indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TEXT_AREA_WINDOW

inherit
	DEMO_WINDOW

	EV_TEXT
		redefine
			make
		end
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		do
			{EV_TEXT} Precursor (par)
			append_text ("This is a text area.")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "text area")
			add_text_component_commands (Current, event_window, "Text area")
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_primitive_tabs
			tab_list.extend (text_component_tab)
			tab_list.extend (text_tab)
			create action_window.make (Current, tab_list)
		end

end -- class TEXT_AREA_WINDOW

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

