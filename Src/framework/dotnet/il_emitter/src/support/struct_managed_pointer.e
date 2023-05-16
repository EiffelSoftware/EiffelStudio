note
	description: "[
			Build C struct memory taking care of padding and alignment.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	STRUCT_MANAGED_POINTER

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
			align
			Result := mp
		end

feature {NONE} -- Implementation

	mp: MANAGED_POINTER

	internal_pos: INTEGER

	align
		local
			i, pad: INTEGER
		do
			pad := mp.count - internal_pos
			from
				i := 1
			until
				i > pad
			loop
				mp.put_natural_8_le (0, internal_pos + i - 1)
				i := i + 1
			end
			internal_pos := internal_pos + pad -- Padding
		ensure
			internal_pos = mp.count
		end

	padding (a_byte_size: INTEGER): INTEGER
		do
			Result := internal_pos \\ a_byte_size
			if Result /= 0 then
				Result := a_byte_size - Result
			end
		end

	put_padding_for (a_byte_size: INTEGER)
		local
			i, pad: INTEGER
		do
			pad := padding (a_byte_size)
			if pad > 0 then
				from
					i := 1
				until
					i > pad
				loop
					mp.put_natural_8_le (0, internal_pos + i - 1)
					i := i + 1
				end
				internal_pos := internal_pos + pad -- Padding
			end
		end

feature -- Change

	put_inner_struct (a_bytes: ARRAY [NATURAL_8]; a_struct_alignment: INTEGER)
		do
			put_padding_for (a_struct_alignment)
			mp.put_array (a_bytes, internal_pos)
			internal_pos := internal_pos + a_bytes.count
		end

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
-- Useless, as it is one byte:
--			put_padding_for ({PLATFORM}.character_8_bytes)
			mp.put_character (c, internal_pos)
			internal_pos := internal_pos + 1
		end

	put_characters (v: ARRAY [CHARACTER_8])
		do
			across
				v as c
			loop
				put_character (c)
			end
		end

	put_natural_8_array (v: ARRAY [NATURAL_8])
		do
-- Useless, as it is one byte:
--			put_padding_for ({PLATFORM}.natural_8_bytes)
			mp.put_array (v, internal_pos)
			internal_pos := internal_pos + v.count * {PLATFORM}.natural_8_bytes
		end

	put_natural_8 (v: NATURAL_8)
		do
-- Useless, as it is one byte:
--			put_padding_for ({PLATFORM}.natural_8_bytes)
			mp.put_natural_8_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.natural_8_bytes
		end

	put_integer_32 (v: INTEGER_32)
		do
			put_padding_for ({PLATFORM}.integer_32_bytes)
			mp.put_integer_32_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_32_bytes
		end

	put_integer_8 (v: INTEGER_8)
		do
			put_padding_for ({PLATFORM}.integer_8_bytes)
			mp.put_integer_8_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_8_bytes
		end

	put_integer_16 (v: INTEGER_16)
		do
			put_padding_for ({PLATFORM}.integer_16_bytes)
			mp.put_integer_16_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_16_bytes
		end

	put_integer_64 (v: INTEGER_64)
		do
			put_padding_for ({PLATFORM}.integer_64_bytes)
			mp.put_integer_64_le (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.integer_64_bytes
		end

	put_pointer (v: POINTER)
		do
			put_padding_for ({PLATFORM}.pointer_bytes)
			mp.put_pointer (v, internal_pos)
			internal_pos := internal_pos + {PLATFORM}.pointer_bytes
		end

end
