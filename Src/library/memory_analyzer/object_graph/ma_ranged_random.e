indexing
	description: "Pseudo random number in a range."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David Stevens"
	date: "$Date$"
	revision: "$Revision$"

class
	MA_RANGED_RANDOM

inherit
	RANDOM

create
	make, make_default

feature {NONE} -- Initialization

	make_default is
		local
			t: TIME
		do
			create t.make_now
			set_seed (t.seconds \\ 1000)
		end

feature -- Access

	next_item_in_range (a_min: INTEGER; a_max: INTEGER): INTEGER is
		local
			l_double: DOUBLE
		do
			forth
			l_double := a_min + (a_max - a_min) * double_item
			Result := l_double.rounded
		end

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




end -- class RANGED_RANDOM
