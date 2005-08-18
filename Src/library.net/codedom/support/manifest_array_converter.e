indexing
	description: "Conversion utility class for converting Eiffel manifest arrays to .NET arrays."
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

end -- class MANIFEST_ARRAY_CONVERTER
