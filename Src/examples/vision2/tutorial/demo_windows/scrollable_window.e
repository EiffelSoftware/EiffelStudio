indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			pix: EV_PIXMAP
		do
			Precursor {EV_SCROLLABLE_AREA} (par)
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

	ta: EV_DRAWING_AREA;
	--scrollable_area_tab:SCROLLABLE_AREA_TAB
		-- A drawing_area for the demo

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


end -- class SCROLLABLE_WINDOW

