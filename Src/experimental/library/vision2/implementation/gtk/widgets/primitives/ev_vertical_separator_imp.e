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

	old_make (an_interface: like interface)
			-- Create a GTK vertical seperator in an event box.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		local
			p: POINTER
		do
			set_c_object ({EV_GTK_EXTERNALS}.gtk_event_box_new)
			p := {EV_GTK_EXTERNALS}.gtk_vseparator_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (p)
			{EV_GTK_EXTERNALS}.gtk_container_add (c_object, p)
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (c_object, 1, -1)
			Precursor
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SEPARATOR note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_VERTICAL_SEPARATOR_IMP





