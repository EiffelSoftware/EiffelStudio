indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	SCROLLABLE_WINDOW

inherit
	EV_SCROLLABLE_AREA
		redefine
			make
		end
	DEMO_WINDOW

	PIXMAP_PATH

	WIDGET_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			pix: EV_PIXMAP
		do
			{EV_SCROLLABLE_AREA} Precursor (par)
			create pix.make_from_file (pixmap_path ("isepower"))
			create ta.make_with_pixmap (Current, pix)
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "scrollable area")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
			set_container_tabs
			tab_list.extend(scrollable_area_tab)
			create action_window.make (Current, tab_list)	
		end

feature -- Access

	ta: EV_DRAWING_AREA
	--scrollable_area_tab:SCROLLABLE_AREA_TAB
		-- A drawing_area for the demo

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

