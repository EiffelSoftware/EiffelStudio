note
	description:
		"Eiffel Vision vertical scroll bar. %N%
		%Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SCROLL_BAR_IMP

inherit
	EV_VERTICAL_SCROLL_BAR_I
		redefine
			interface
		end

	EV_SCROLL_BAR_IMP
		redefine
			interface,
			set_default_minimum_size,
			make
		end
create
	make

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create as vertical scrollbar.
		do
			assign_interface (an_interface)
		end

	make
			-- Create an initialize `Current'
		do
			make_vertical (default_parent, 0, 0, 0, 0, -1)
			Precursor
		end

feature -- Status setting

   	set_default_minimum_size
   			-- Platform dependant initializations.
   		do
			ev_set_minimum_width ((create {WEL_SYSTEM_METRICS})
				.vertical_scroll_bar_arrow_width)
 		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_VERTICAL_SCROLL_BAR note option: stable attribute end;

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

end -- class EV_VERTICAL_SCROLL_BAR_IMP
