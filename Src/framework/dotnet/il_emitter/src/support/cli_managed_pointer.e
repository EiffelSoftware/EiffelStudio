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
			position := 0
		end

feature -- Access

	managed_pointer: MANAGED_POINTER
		do
			Result := mp
		end

	count: INTEGER
		do
			Result := mp.count
		end

	position: INTEGER
			-- Current insertion position
			-- At the end, `position` should be the same as `mp.count`

feature -- Status report

	is_valid_position: BOOLEAN
			-- Has `position` a valid value ?
		do
			Result := position <= mp.count
		end

feature {NONE} -- Implementation

	mp: MANAGED_POINTER

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
				mp.put_natural_8_le (v, position + i)
				i := i + 1
			end
			position := position + nb
		end

	put_character (c: CHARACTER_8)
		do
			mp.put_character (c, position)
			position := position + 1
		end

	put_natural_8_array (v: ARRAY [NATURAL_8])
		do
			mp.put_array (v, position)
			position := position + v.count * {PLATFORM}.natural_8_bytes
		end

	put_natural_8 (v: NATURAL_8)
		do
			mp.put_natural_8_le (v, position)
			position := position + {PLATFORM}.natural_8_bytes
		end

	put_natural_32 (v: NATURAL_32)
		do
			mp.put_natural_32_le (v, position)
			position := position + {PLATFORM}.natural_32_bytes
		end

	put_integer_32 (v: INTEGER_32)
		do
			mp.put_integer_32_le (v, position)
			position := position + {PLATFORM}.integer_32_bytes
		end

	put_integer_8 (v: INTEGER_8)
		do
			mp.put_integer_8_le (v, position)
			position := position + {PLATFORM}.integer_8_bytes
		end

	put_integer_16 (v: INTEGER_16)
		do
			mp.put_integer_16_le (v, position)
			position := position + {PLATFORM}.integer_16_bytes
		end

	put_pointer (v: POINTER)
		do
			mp.put_pointer (v, position)
			position := position + {PLATFORM}.pointer_bytes
		end

feature -- Debug purpose

	to_bytes_string (nb: INTEGER): STRING_8
		local
			n8: NATURAL_8
			i: INTEGER
		do
			if nb > 0 then
				create Result.make (nb * 3)

				across
					managed_pointer.read_array (0, nb) as ic
				loop
					n8 := ic.item
					Result.append (n8.to_hex_string)
					i := i + 1
					if i > 0 and i \\ 8 = 0 then
						Result.append_character ('%N')
					else
						Result.append_character (' ')
					end
				end
			else
				create Result.make (0)
			end
		end

invariant
	is_valid_position: position <= count

end
