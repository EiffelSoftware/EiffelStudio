note
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface
		end

	EV_ITEM_IMP
		redefine
			interface,
			needs_event_box,
			make
		end

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := False
		end

	is_dockable: BOOLEAN = False

	old_make (an_interface: attached like interface)
			-- Create the tool bar button.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			set_c_object ({GTK2}.gtk_separator_tool_item_new)
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TOOL_BAR_SEPARATOR_I
