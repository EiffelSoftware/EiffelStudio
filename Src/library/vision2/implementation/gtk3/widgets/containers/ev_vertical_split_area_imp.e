note
	description:
		"Eiffel Vision Split Area, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit
	EV_VERTICAL_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
		redefine
			interface,
			make
		end

create
	make

feature -- initialization

	old_make (an_interface: attached like interface)
			-- Connect interface and initialize `c_object'.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'.
		do
			container_widget := {GTK}.gtk_paned_new ({GTK_ORIENTATION}.gtk_orientation_vertical)
			set_c_object (container_widget)
			Precursor
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SPLIT_AREA note option: stable attribute end;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

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

end -- class EV_VERTICAL_SPLIT_AREA_IMP
