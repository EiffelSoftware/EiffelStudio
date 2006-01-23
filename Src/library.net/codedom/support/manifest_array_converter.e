indexing
	description: "Conversion utility class for converting Eiffel manifest arrays to .NET arrays."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	MANIFEST_ARRAY_CONVERTER [G -> SYSTEM_OBJECT]

feature -- Conversion

	cil_array (a_array: ARRAY [ANY]): NATIVE_ARRAY [G] is
			-- Instance of NATIVE_ARRAY with same elements as `a_array'.
		require
			attached_array: a_array /= Void
		local
			obj: G
			i: INTEGER
			l, u: INTEGER
		do
			create Result.make (a_array.count)
			l := a_array.lower
			u := a_array.upper
			from
				i := u
			until
				i < l
			loop
				obj ?= a_array[i]
				Result.put (i - 1, obj)
				i := i - 1
			end
		ensure
			attached_cil_array: Result /= Void
			counts_match: Result.count = a_array.count
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


end -- class MANIFEST_ARRAY_CONVERTER
