indexing
	description: "a ARRAYED_LIST with STOREABLE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_ARRAYED_LIST_STORABLE [G]

inherit
	ARRAYED_LIST [G]
		redefine
			make
		end
	STORABLE
		undefine
			copy, is_equal
		end

create
	make

create {MA_ARRAYED_LIST_STORABLE}
	make_filled

feature {NONE} -- Initlization

	make (n: INTEGER) is
			-- Creation method
		do
			Precursor {ARRAYED_LIST} (n)
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




end
