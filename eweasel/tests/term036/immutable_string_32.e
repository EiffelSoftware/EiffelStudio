class
	IMMUTABLE_STRING_32

create
	make_from_c_byte_array

feature {NONE} -- Initialization

	make_from_c_byte_array (a_byte_array: POINTER; a_character_count: INTEGER)
			-- Initialize from contents of `a_byte_array' for a length of `a_character_count`,
			-- given that each character is encoded in 4 bytes (little endian).
			-- ex: (char*) "a\000\000\000b\000\000\000c\000\000\000" for unicode STRING_32 "abc"
		require
			a_byte_array_exists: a_byte_array /= Default_pointer
		do
		end

end
