indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- For efficiency, we first create the box without
			-- parent.
		do
			Precursor {EV_HORIZONTAL_BOX} (Void)
			set_border_width (10)
			create button.make_with_text (Current, "Press me")
			create button.make_with_text (Current, "Button with a very long label")
			set_child_expandable (button, False)
			create button.make_with_text (Current, "Button 3")
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

	button: EV_BUTTON;

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


end -- class BOX_WINDOW

