note
	description: "[
			Build binary in memory.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_MANAGED_POINTER

create
	make

convert
	managed_pointer: {MANAGED_POINTER}

feature {NONE} -- Initialization

	make (a_size: INTEGER)
			-- Initialize `Current'.
		do
			create mp.make (a_size)
			internal_pos := 0
		end

feature -- Access

	managed_pointer: MANAGED_POINTER
		do
			Result := mp
		end

	count: INTEGER
		do
			Result := internal_pos
		end

feature {NONE} -- Implementation

	mp: MANAGED_POINTER

	internal_pos: INTEGER

feature -- Change

	put_padding (nb: INTEGER; v: NATURAL_8)
		local
			i: INTEGER
		do
			from
				i := 0
			until
				i >= nb
			loop
				mp.put_natural_8_le (v, internal_pos + i)
				i := i + 1
			end
			internal_pos := internal_pos + nb
		end

	put_character (c: CHARACTER_8)
		do
			mp.put_character (c, internal_pos)
			internal_pos := internal_pos + 1
		end

	put_natural_8_array (v: ARRAY [NATURAL_8])
		do
			mp.put_array (v, internal_pos)
			internal_pos := internal_pos + v.count * {PLATFORM}.natural_8_bytes
		end

	put_natural_8 (v: NATURAL_8)
		do
			mp.put_natural_8_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.natural_8_bytes
		end

	put_integer_32 (v: INTEGER_32)
		do
			mp.put_integer_32_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_32_bytes
		end

	put_integer_8 (v: INTEGER_8)
		do
			mp.put_integer_8_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_8_bytes
		end

	put_integer_16 (v: INTEGER_16)
		do
			mp.put_integer_16_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_16_bytes
		end

	put_integer_64 (v: INTEGER_64)
		do
			mp.put_integer_64_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_64_bytes
		end

	put_pointer (v: POINTER)
		do
			mp.put_pointer (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.pointer_bytes
		end

end
