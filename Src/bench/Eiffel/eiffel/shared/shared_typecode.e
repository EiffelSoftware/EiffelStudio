indexing
	description: "Type code used for TUPLE elements"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_TYPECODE

feature -- Access

	boolean_code: INTEGER is 0
	character_code: INTEGER is 1
	double_code: INTEGER is 2
	real_code: INTEGER is 3
	integer_code: INTEGER is 4
	pointer_code: INTEGER is 5
	reference_code: INTEGER is 6
	integer_8_code: INTEGER is 7
	integer_16_code: INTEGER is 8
	integer_64_code: INTEGER is 9
			-- Code used to identify type in tuple.

end -- class SHARED_TYPECODE
