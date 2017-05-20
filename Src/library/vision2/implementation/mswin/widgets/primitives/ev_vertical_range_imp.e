note
	description:
		"Eiffel Vision vertical range. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_RANGE_IMP

inherit
	EV_VERTICAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			set_default_minimum_size,
			interface,
			make
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create as vertical range.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize `Current'
		do
			make_vertical (default_parent, 0, 0, 0, 0, 0)
			Precursor
		end

feature -- Status setting

   	set_default_minimum_size
   			-- Platform dependent initializations.
   		do
   			ev_set_minimum_size (30, 10, False)
 		end

feature {EV_ANY, EV_ANY_I, EV_INTERNAL_SILLY_WINDOW_IMP} -- Implementation

	interface: detachable EV_VERTICAL_RANGE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_VERTICAL_RANGE_IMP
