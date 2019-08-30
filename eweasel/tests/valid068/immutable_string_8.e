class
	IMMUTABLE_STRING_8

create
	make,
	make_empty,
	make_from_c_byte_array

feature {NONE} -- Initialization

	make (n: INTEGER) is
		do
		end

	make_empty is
		do
			make (0)
		end	

	make_from_c_byte_array (a_byte_array: POINTER; a_character_count: INTEGER)
			-- Initialize from contents of `a_byte_array' for a length of `a_character_count`,
			-- given that each character is encoded in 1 single byte.
			-- ex: (char*) "abc"  for STRING_8 "abc"			
		require
			a_byte_array_exists: a_byte_array /= Default_pointer
		do
		end

end
