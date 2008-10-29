indexing
	description:
		"Comparators for character ranges"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RANGE_COMPARATOR inherit

	COMPARATOR

create

	make

feature {NONE} -- Initialization

	make (lo, up: CHARACTER) is
			-- Create comparator.
		do
			lower := lo
			upper := up
		ensure
			lower_set: lower = lo
			upper_set: upper = up
		end

feature -- Access

	character_set: STRING is
			-- Character set represented by comparator
		do
			create Result.make (3)
			Result.extend (lower)
			Result.extend ('-')
			Result.extend (upper)
		end

	contains (c: CHARACTER): BOOLEAN is
			-- Does comparator contain `c'?
		do
			Result := lower <= c and c <= upper
		end
		
feature {NONE} -- Implementation

	lower: CHARACTER
	
	upper: CHARACTER;

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




end -- class RANGE_COMPARATOR

