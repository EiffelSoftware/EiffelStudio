indexing

	description:

		"Imported routines that ought to be in class FIXED_ARRAY. %
		%A fixed array is a zero-based indexed sequence of values, %
		%equipped with features `put', `item' and `count'."

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobosoft.com>"
	copyright:  "Copyright (c) 1999, Eric Bezault and others"
	license:    "Eiffel Forum Freeware License v1 (see forum.txt)"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_IMPORTED_FIXED_ARRAY_ROUTINES

feature -- Access

	FIXED_ANY_ARRAY_: KL_FIXED_ARRAY_ROUTINES [ANY] is
			-- Routines that ought to be in class FIXED_ARRAY
		once
			!! Result
		ensure
			fixed_any_array_routines_not_void: Result /= Void
		end

	FIXED_INTEGER_ARRAY_: KL_FIXED_ARRAY_ROUTINES [INTEGER] is
			-- Routines that ought to be in class FIXED_ARRAY
		once
			!! Result
		ensure
			fixed_integer_array_routines_not_void: Result /= Void
		end

	FIXED_STRING_ARRAY_: KL_FIXED_ARRAY_ROUTINES [STRING] is
			-- Routines that ought to be in class FIXED_ARRAY
		once
			!! Result
		ensure
			fixed_string_array_routines_not_void: Result /= Void
		end

feature -- Type anchors

	FIXED_ANY_ARRAY_TYPE: SPECIAL [ANY] is do end
	FIXED_INTEGER_ARRAY_TYPE: SPECIAL [INTEGER] is do end
	FIXED_STRING_ARRAY_TYPE: SPECIAL [STRING] is do end
			-- Type anchors

end -- class KL_IMPORTED_FIXED_ARRAY_ROUTINES
