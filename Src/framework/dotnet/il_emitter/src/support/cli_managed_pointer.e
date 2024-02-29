note
	description: "[
			Build binary in memory.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CLI_MANAGED_POINTER

create
	make,
	make_from_pointer,
	make_from_managed_pointer

convert
	managed_pointer: {MANAGED_POINTER}

feature {NONE} -- Initialization

	make (a_size: INTEGER)
			-- Initialize `Current'.
		do
			create mp.make (a_size)
			position := 0
		end

	make_from_pointer (p: POINTER; n: INTEGER)
		do
			create mp.make_from_pointer (p, n)
			position := n + 1
		end

	make_from_managed_pointer (p: MANAGED_POINTER)
		do
			mp := p
			position := mp.count + 1
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

	put_integer_64 (v: INTEGER_64)
		do
			mp.put_integer_64_le (v, position)
			position := position + {PLATFORM}.integer_64_bytes
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

	to_bytes_string (len: INTEGER): STRING_8
		local
			n: INTEGER
			n8: NATURAL_8
			i: INTEGER
		do
			if len = 0 then
				n := 0
			else
				if len < 0 then
						-- -1: mean the whole pointer.
					n := position + len + 1
				else
					n := len
				end
			end
			if n <= 0 then
				create Result.make (0)
			else
				create Result.make (n * 3)
				across
					mp.read_array (0, n) as ic
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
			end
		end

invariant
	is_valid_position: position <= count

end
