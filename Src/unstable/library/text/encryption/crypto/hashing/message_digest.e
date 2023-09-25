note
	description: "[
					This class provides applications the functionality of a message digest algorithm, 
					such as MD5 or SHA. Message digests are secure one-way hash functions that take 
					arbitrary-sized data and output a fixed-length hash value.
				]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MESSAGE_DIGEST

feature -- Access

	digest_as_string: STRING_8
			-- Hexadecimal string representation of Current digest.
		do
			Result := digest_as_hexadecimal_string
		end

	digest_as_hexadecimal_string: STRING_8
			-- Hexadecimal string representation of Current digest.
		local
			l_digest: like digest
			index, l_upper: INTEGER
		do
			l_digest := digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.append (l_digest [index].to_hex_string)
				index := index + 1
			end
		end

	digest_as_byte_string: STRING_8
			-- Byte array string representation of Current digest.
		local
			l_digest: like digest
			index, l_upper: INTEGER
		do
			l_digest := digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.extend (l_digest [index].to_character_8)
				index := index + 1
			end
		end

	digest: SPECIAL [NATURAL_8]
			-- Final digest
		deferred
		end

	digest_count: INTEGER
			-- Length in bytes of the digest
		deferred
		end

	block_size: INTEGER
			-- Block size in bytes
		deferred
		end

feature -- Element Change

	reset
			-- Reset current diggest for further use.
		deferred
		end

	update_from_byte (a_byte: NATURAL_8)
			-- Append byte.
		deferred
		end

	update_from_bytes (a_bytes: SPECIAL [NATURAL_8])
			-- Append bytes.
		local
			i, l_upper: INTEGER
		do
			from
				i := 0
				l_upper := a_bytes.upper
			until
				i > l_upper
			loop
				update_from_byte (a_bytes [i])
				i := i + 1
			end
		end

	update_from_hexadecimal_string (a_string: READABLE_STRING_8)
			-- Append bytes from hexadecimal string `a_string'.
		require
			hexadecimal_format: a_string.count \\ 2 = 0
		local
			i, l_upper: INTEGER
			c1,c2: CHARACTER_8
			n: NATURAL_32
		do
			from
				i := 1
				l_upper := a_string.count
			until
				i + 1 > l_upper
			loop
				c1 := a_string[i].as_lower
				inspect c1
				when '0' .. '9' then
					n := c1.natural_32_code - ('0').natural_32_code
				when 'a' .. 'f' then
					n := 10 + c1.natural_32_code - ('a').natural_32_code
				else
					-- Error, not an hexa!					
				end
				n := n |<< 4
				c2 := a_string[i + 1].as_lower
				inspect c2
				when '0' .. '9' then
					n := n + c2.natural_32_code - ('0').natural_32_code
				when 'a' .. 'f' then
					n := n + 10 + c2.natural_32_code - ('a').natural_32_code
				else
					-- Error, not an hexa!					
				end
				update_from_byte (n.to_natural_8) -- a_string.code (i).as_natural_8)
				i := i + 2
			end
		end

	update_from_bytes_string (a_string: READABLE_STRING_8)
			-- Append bytes from bytes coded in string `a_string'.
			-- note: see READABLE_STRING_8 as an array of CHARACTER_8, i.e NATURAL_8.
		local
			i, l_upper: INTEGER
		do
			from
				i := 1
				l_upper := a_string.count
			until
				i > l_upper
			loop
				update_from_byte (a_string.code (i).as_natural_8)
				i := i + 1
			end
		end

	update_from_string (a_string: READABLE_STRING_8)
			-- Append bytes from bytes coded in string `a_string'.
			-- note: see READABLE_STRING_8 as an array of CHARACTER_8, i.e NATURAL_8.
		do
			update_from_bytes_string (a_string)
		end

	update_from_iterator (a_it: ITERATION_CURSOR [NATURAL_8])
			-- Append bytes from iteration cursor.
		do
			from
			until
				a_it.after
			loop
				update_from_byte (a_it.item)
				a_it.forth
			end
		end

	update_from_io_medium (a_io_medium: IO_MEDIUM)
			-- Append bytes from io medium
		local
			done: BOOLEAN
		do
			from
			until
				done or not a_io_medium.readable
			loop
				a_io_medium.read_natural_8
				if a_io_medium.bytes_read > 0 then
					update_from_byte (a_io_medium.last_natural_8)
				else
					check has_byte_read: False end
					done := True
				end
			end
		end

feature {NONE} -- Implementation

	byte_count: NATURAL_64
			-- Byte count

	bit_count: NATURAL_64
			-- Bit count
		do
			Result := byte_count |<< 3
		end

	message_pad
			-- Pad with zero until 64bit is left in current block.
		local
			pad_bytes: INTEGER_32
		do
			update_from_byte (0b1000_0000)
			from
				pad_bytes := (56 - (byte_count \\ 64)).to_integer_32
				if pad_bytes < 0 then
					pad_bytes := pad_bytes + 64
				end
			until
				pad_bytes = 0
			loop
				update_from_byte (0)
				pad_bytes := pad_bytes - 1
			end
		end

	finish
			-- Finish updating, get ready to process the last block.
		local
			length: NATURAL_64
		do
			length := bit_count
			message_pad
			process_length (length)
		end

	process_length (length: NATURAL_64)
			-- Update length into the buffer.
		do
			update_from_byte ((length).to_natural_8)
			update_from_byte ((length |>> 8).to_natural_8)
			update_from_byte ((length |>> 16).to_natural_8)
			update_from_byte ((length |>> 24).to_natural_8)
			update_from_byte ((length |>> 32).to_natural_8)
			update_from_byte ((length |>> 40).to_natural_8)
			update_from_byte ((length |>> 48).to_natural_8)
			update_from_byte ((length |>> 56).to_natural_8)
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
