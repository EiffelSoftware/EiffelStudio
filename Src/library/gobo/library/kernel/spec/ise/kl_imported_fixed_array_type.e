indexing

	description:

		"Imported type anchor for FIXED_ARRAY [G]. %
		%A fixed array is a zero-based indexed sequence of values, %
		%equipped with features `put', `item' and `count'."

	library:    "Gobo Eiffel Kernel Library"
	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1999, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class KL_IMPORTED_FIXED_ARRAY_TYPE [G]

feature -- Type anchors

	FIXED_ARRAY_TYPE: SPECIAL [G] is do end
			-- Type anchor

end -- class KL_IMPORTED_FIXED_ARRAY_TYPE
