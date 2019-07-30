note
	description: "[
		Sequences of 32-bit characters, accessible through integer indices
		in a contiguous range.
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IMMUTABLE_STRING_32

inherit
	COMPARABLE
		redefine
			out
		end

	ITERABLE [CHARACTER_32]
		undefine
			is_equal
		redefine
			out
		end

create
	make,
	make_empty,
	make_from_cil,
	make_from_c_byte_array

convert
	to_cil: {SYSTEM_STRING},
	make_from_cil ({SYSTEM_STRING})

feature {NONE} -- Initialization

	make (n: INTEGER)
		do
			count := 0
			internal_hash_code := 0
			create area.make_filled ('%/000/', n + 1)
		end

	make_empty
		do
			make (0)
		end

	make_from_cil (a_system_string: detachable SYSTEM_STRING)
		do
			create area.make_empty (0)
		end

	make_from_c_byte_array (a_byte_array: POINTER; a_character_count: INTEGER)
			-- Initialize from contents of `a_byte_array' for a length of `a_character_count`,
			-- given that each character is encoded in 4 bytes (little endian).
			-- ex: (char*) "a\000\000\000b\000\000\000c\000\000\000" for unicode STRING_32 "abc"
		require
			a_byte_array_exists: a_byte_array /= Default_pointer
		do
			make (a_character_count)
		end

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [CHARACTER_32]
			-- <Precursor>
		do
			create Result.make
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is string lexicographically lower than `other'?
		do

		end

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := count = 0
		end

	code (i: INTEGER): NATURAL_32
			-- Character at position `i'
		do
			Result := area.item (i - 1).natural_32_code
		end

	area: SPECIAL [CHARACTER_32]

	internal_hash_code: INTEGER

	count: INTEGER
			-- Actual number of characters making up the string

feature -- Element change

	plus alias "+" (s: STRING_32): like Current
			-- <Precursor>
		do
			create Result.make (10)
		end

feature -- Conversion

	frozen to_cil: SYSTEM_STRING
			-- Create an instance of SYSTEM_STRING using characters
			-- of Current between indices `1' and `count'.
		do
			create Result.make (' ', 0)
		end

	as_string_8: STRING_8
			-- Convert `Current' as a STRING_8. If a code of `Current' is
			-- not a valid code for a STRING_8 it is replaced with the null
			-- character.
		local
			i, nb: INTEGER
			l_code: NATURAL_32
		do
			if attached {STRING_8} Current as l_result then
				Result := l_result
			else
				nb := count
				create Result.make (nb)
				Result.set_count (nb)
				from
					i := 1
				until
					i > nb
				loop
					l_code := code (i)
					if Result.valid_code (l_code) then
						Result.put_code (l_code, i)
					else
						Result.put_code ({NATURAL_32} 0, i)
					end
					i := i + 1
				end
			end
		ensure
			as_string_8_not_void: Result /= Void
		end

feature -- Output

	out: STRING
			-- Printable representation
		do
			Result := as_string_8
		end

;note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
