indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	FRAME_WINDOW

inherit
	EV_FRAME
		redefine
			make
		end

	DEMO_WINDOW
	WIDGET_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'. For efficiency, we
			-- first create the frame without parent.

		do
			{EV_FRAME} Precursor (par)
			set_text ("A frame with text")
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "frame")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			create frame_tab.make(Void)
			tab_list.extend(frame_tab)
			create action_window.make(Current,tab_list)	
		end

feature -- Access

	frame_tab: FRAME_TAB

end -- class SCROLLABLE_WINDOW

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

