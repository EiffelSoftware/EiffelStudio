note
	description:
		"Eiffel Vision vertical separator. GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SEPARATOR_IMP

inherit
	EV_VERTICAL_SEPARATOR_I
		redefine
			interface
		end

	EV_SEPARATOR_IMP
		redefine
			interface, make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a GTK vertical separator in an event box.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		local
			p: POINTER
		do
			set_c_object ({GTK}.gtk_event_box_new)
			p := {GTK}.gtk_separator_new ({GTK_ORIENTATION}.gtk_orientation_vertical)
			{GTK}.gtk_widget_show (p)
			{GTK}.gtk_container_add (c_object, p)
			{GTK}.gtk_widget_set_size_request (c_object, 1, -1)
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_VERTICAL_SEPARATOR_IMP
