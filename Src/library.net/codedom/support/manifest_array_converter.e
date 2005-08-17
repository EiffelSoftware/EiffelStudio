indexing
	description: "Conversion utility class for converting Eiffel manifest arrays to .NET arrays."
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	MANIFEST_ARRAY_CONVERTER [G -> SYSTEM_OBJECT]

feature -- Conversion

	convert_to (a_array: ARRAY [ANY]): NATIVE_ARRAY [G] is
			-- Converts `a_array' to an NATIVE_ARRAY.
		require
			a_array_not_void: a_array /= Void
		local
			ref: G
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
				ref ?= a_array[i]
				Result.put (i - 1, ref)
				i := i - 1
			end
		ensure
			result_not_void: Result /= Void
			result_count_matches_a_array: Result.count = a_array.count
		end

end -- class MANIFEST_ARRAY_CONVERTER
