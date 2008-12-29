note
	description: "Facilities to read and write UTF-8 encoded strings"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UTF8_READER_WRITER

inherit
	ANY

	UC_IMPORTED_UTF8_ROUTINES
		export
			{NONE} all
		end

feature -- Reading Wrappers

	file_read_string_32_with_length (a_file: FILE; n_bytes: INTEGER): STRING_32
			-- Read `n_bytes' from `a_file' and interpret them as the UTF-8 encoding of a string
		require
			file_open_readable: a_file.is_open_read
			n_non_negative: n_bytes >= 0
		local
			l_pointer: MANAGED_POINTER
		do
			if n_bytes = 0 then
				Result := ""
			else
				create l_pointer.make (n_bytes)
				a_file.read_to_managed_pointer (l_pointer, 0, n_bytes)
				Result := special_natural_8_to_string_32 (l_pointer.read_array (0, n_bytes).to_special)
			end
		ensure
			result_not_void: Result /= Void
		end

	array_natural_8_to_string_32 (a_array: ARRAY[NATURAL_8]): STRING_32
			-- Read from an array of `NATURAL_8' and return a `STRING_32'
		require
			array_not_void: a_array /= Void
		do
			Result := special_natural_8_to_string_32(a_array.to_special)
		ensure
			result_not_void: Result /= Void
		end

feature -- Reading

	special_natural_8_to_string_32 (a_special: SPECIAL[NATURAL_8]): STRING_32
			-- Read from a special of natural_8 and return a string32
			-- `a_special' should be a sequence of bytes representing an UTF-8 encoded string
			-- This function also interprets 5 and 6-bytes characters, which are not part
			-- of the UFT-8 standard.
		require
			special_not_void: a_special /= Void
		local
			i, ch_len: INTEGER
			l_ch: CHARACTER
			code: NATURAL_32
		do
			create Result.make_empty
			from
				i := a_special.lower
				ch_len := 0 -- this is the number of bytes missing to complete the current character
			variant
				a_special.count - i + 1
			until
				i > a_special.upper
			loop
				l_ch := a_special.item (i).to_character_8
				if ch_len > 0 then
						-- we are in the middle of a multi-byte char
					ch_len := ch_len - 1 -- one byte fewer to decode
					code := code | ( l_ch.natural_32_code.bit_and (63) |<< (6*ch_len) )
					if ch_len <= 0 then
							-- this was last byte
						Result.append_character (code.to_character_32)
						code := 0
					end
				elseif utf8.is_encoded_first_byte (l_ch) then
					ch_len := utf8.encoded_byte_count (l_ch)
					if ch_len = 1 then
							-- this is an ascii character
						Result.append_character (l_ch.to_character_32)
					else
							-- first byte of a multibyte character
						code := l_ch.natural_32_code & ({NATURAL_8}.max_value.bit_shift_right (ch_len).as_natural_32) |<< (6*(ch_len-1))
					end
					ch_len := ch_len - 1
				else
						-- something was wrong in the bytes sequence
						-- just discard the character
					ch_len := 0
					code := 0
				end
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Writing

	file_write_string_32 (a_file: FILE; a_string: STRING_32)
		-- Write `a_string' to `a_file' at current position using UTF-8 encoding
		-- This function also writes 5 and 6-bytes characters, which are not part of the UTF-8 standard
	require
		file_open_writeable: a_file.is_open_write
		string_not_void: a_string /= Void
	local
		ch_len, i: INTEGER
		l_byte: NATURAL_8
		l_code: NATURAL_32
	do
		from
			i := 1
		until
			i > a_string.count
		loop
			l_code := a_string.item (i).natural_32_code
			ch_len := utf8.code_byte_count (l_code.to_integer_32)
			if ch_len = 1 then
				a_file.put_natural_8 (l_code.as_natural_8)
			else
				l_byte := ((0xFC).to_natural_8 |>> (6-ch_len)) |<< (6-ch_len) -- prepare length encoding
				ch_len := ch_len - 1
				l_byte := l_byte | ( l_code |>> (ch_len*6) ).to_natural_8 -- first byte of the character
				a_file.put_natural_8 (l_byte)
				from
				variant
					ch_len+1
				until
					ch_len <= 0
				loop
						-- following bytes
					ch_len := ch_len - 1
					l_byte := (0x80).to_natural_8 | (l_code |>> (ch_len*6) & 0x3F).to_natural_8
					a_file.put_natural_8 (l_byte)
				end
			--	i := i + 1
			end
			i := i + 1
		end
	end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
