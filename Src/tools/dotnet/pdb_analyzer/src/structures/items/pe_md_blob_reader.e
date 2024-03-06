note
	description: "Summary description for {PE_MD_BLOB_READER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_MD_BLOB_READER

inherit
	DEBUG_OUTPUT

feature {NONE} -- Initialization

	make (mp: MANAGED_POINTER)
		do
			pointer := mp
		end

feature -- Access

	pointer: MANAGED_POINTER

feature -- Status report

	debug_output: STRING_8
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "[" + (current_position + 1 - 1).out + "/" + pointer.count.out + "] "
			if not exhausted then
				Result.append ("0x" + pointer.read_natural_8_le (current_position - 1).to_hex_string)
			end
			Result.append (": " + dump)
		end

	dump: STRING_8
		local
			i,n: INTEGER
			mp: MANAGED_POINTER
		do
			mp := pointer
			from
				i := 0
				n := pointer.count
				create Result.make (n * 3)
			until
				i >= n
			loop
				if not Result.is_empty then
					Result.append_character ('-')
				end
				Result.append (mp.read_natural_8 (i).to_hex_string)
				i := i + 1
			end
		end

feature -- Traversal

	current_position: INTEGER

	current_byte: NATURAL_8
		do
			if not exhausted then
				Result := pointer.read_natural_8_le (current_position)
			end
		end

	exhausted: BOOLEAN
		do
			Result := current_position >= pointer.count
		end

	reset_position
		do
			current_position := 0
		end

	forward_position (nb: INTEGER)
		require
			nb >= 0
		do
			current_position := current_position + nb
		end

	rewind_position (nb: INTEGER)
		require
			nb > 0
		do
			current_position := current_position - nb
		end

	read_integer_8_le: INTEGER_8
		require
			not exhausted
		do
			Result := pointer.read_integer_8_le (current_position)
			forward_position (1)
		end

	read_integer_16_le: INTEGER_16
		require
			not exhausted
		do
			Result := pointer.read_integer_16_le (current_position)
			forward_position ({PLATFORM}.integer_16_bytes)
		end

	read_integer_32_le: INTEGER_32
		require
			not exhausted
		do
			Result := pointer.read_integer_32_le (current_position)
			forward_position ({PLATFORM}.integer_32_bytes)
		end

	read_natural_8_le: NATURAL_8
		require
			not exhausted
		do
			Result := pointer.read_natural_8_le (current_position)
			forward_position ({PLATFORM}.natural_8_bytes)
		end

	read_natural_16_le: NATURAL_16
		require
			not exhausted
		do
			Result := pointer.read_natural_16_le (current_position)
			forward_position ({PLATFORM}.natural_16_bytes)
		end

	read_natural_32_le: NATURAL_32
		require
			not exhausted
		do
			Result := pointer.read_natural_32_le (current_position)
			forward_position ({PLATFORM}.natural_32_bytes)
		end

feature -- Implementation

	uncompressed_value: INTEGER_32
		local
			cl: CELL [INTEGER_32]
		do
			create cl.put (0)
			Result := uncompressed_data (pointer, current_position, cl)
			forward_position (cl.item)
		end

	uncompressed_signed_value: INTEGER_32
		local
			cl: CELL [INTEGER_32]
		do
			create cl.put (0)
			Result := uncompressed_signed_data (pointer, current_position, cl)
			forward_position (cl.item)
		end

feature {NONE} -- Implementation		

	uncompressed_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		do
			Result := uncompressed_unsigned_data (v, pos, nb_bytes)
		ensure
			class
		end

	uncompressed_unsigned_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		local
			i1, i2, i3, i4: NATURAL_32
			res: NATURAL_32
			l_bytes_count: INTEGER
		do
			--| See II.23.2 Blobs and signatures (https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf)
			i1 := v.read_natural_8 (pos + 0)
			if i1 <= 0x7F then
				res := i1
				l_bytes_count := 1
			else
				i2 := v.read_natural_8 (pos + 1)
				res := (i1 |<< 8)
						+ i2
						- 0x0000_8000
				if res <= 0x3FFF then
					l_bytes_count := 2
					-- ok
				else
					i3 := v.read_natural_8 (pos + 2)
					i4 := v.read_natural_8 (pos + 3)
					l_bytes_count := 4

					res := (i1 |<< 24).to_natural_32
							+ (i2 |<< 16).to_natural_32
							+ (i3 |<< 8).to_natural_32
							+ (i4).to_natural_32
							- 0xC000_0000
				end
			end
			if nb_bytes /= Void then
				nb_bytes.replace (l_bytes_count)
			end
			Result := res.to_integer_32
		ensure
			class
		end

	uncompressed_signed_data (v: MANAGED_POINTER; pos: INTEGER; nb_bytes: detachable CELL [INTEGER_32]): INTEGER_32
		do
			--| See II.23.2 Blobs and signatures (https://www.ecma-international.org/wp-content/uploads/ECMA-335_6th_edition_june_2012.pdf)
			-- FIXME, signed data is not encoded the same way !!!
			check implemented: False end
			Result := uncompressed_data (v, pos, nb_bytes)
		ensure
			class
		end

end
