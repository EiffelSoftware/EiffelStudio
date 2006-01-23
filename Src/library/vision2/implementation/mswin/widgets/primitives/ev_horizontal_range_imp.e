indexing 
	description:
		"Eiffel Vision horizontal range. %N%
		%Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_RANGE_IMP

inherit
	EV_HORIZONTAL_RANGE_I
		redefine
			interface
		end

	EV_RANGE_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create as horizontal range.
		do
			base_make (an_interface)
			make_horizontal (default_parent, 0, 0, 0, 0, 0)
		end

feature -- Status setting

   	set_default_minimum_size is
   			-- Platform dependant initializations.
   		do
			ev_set_minimum_height (30)
			ev_set_minimum_width (10)
 		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_RANGE;

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




end -- class EV_HORIZONTAL_RANGE_IMP

