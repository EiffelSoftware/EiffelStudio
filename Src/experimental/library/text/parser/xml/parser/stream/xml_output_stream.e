note
	description: "Summary description for {XML_OUTPUT_STREAM}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XML_OUTPUT_STREAM

feature -- Status report

	is_open_write: BOOLEAN
			-- Can items be write into output stream?
		deferred
		end

feature -- Output character

	put_code (c: NATURAL_32)
		require
			is_open_write: is_open_write
		do
			if c.is_valid_character_8_code then
				put_character_8 (c.to_character_8)
			else
				put_character_32 (c.to_character_32)
			end
		end

	put_character_8 (c: CHARACTER_8)
		require
			is_open_write: is_open_write
		deferred
		end

	put_character_32 (c: CHARACTER_32)
		require
			is_open_write: is_open_write
		deferred
		end

feature -- Output string		

	put_string_8 (a_string: READABLE_STRING_8)
			-- Write `a_string' to output stream.
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
		deferred
		end

	put_string_general (s: READABLE_STRING_GENERAL)
			-- Write `a_string_8' to ouput stream
		require
			is_open_write: is_open_write
			a_string_not_void: s /= Void
		do
			if attached {READABLE_STRING_8} s as s8 then
				put_string_8 (s8)
			elseif attached {READABLE_STRING_32} s as s32 then
				put_string_32 (s32)
			else
					-- should not occurs
				check is_either_string_8_or_string_32: False end
				put_string_32 (s.as_string_32)
			end
		end

	put_string_32 (a_string_32: READABLE_STRING_32)
			-- Write `a_string_32' to ouput stream
		require
			is_open_write: is_open_write
			a_string_not_void: a_string_32 /= Void
		deferred
		end

feature -- Output escaped string

	put_string_general_escaped (s: READABLE_STRING_GENERAL)
			-- Write escaped `a_string_8' to ouput stream
		require
			is_open_write: is_open_write
			a_string_not_void: s /= Void
		do
			if attached {READABLE_STRING_8} s as s8 then
				put_string_8_escaped (s8)
			elseif attached {READABLE_STRING_32} s as s32 then
				put_string_32_escaped (s32)
			else
					-- should not occurs
				check is_either_string_8_or_string_32: False end
				put_string_32_escaped (s.as_string_32)
			end
		end

	put_string_8_escaped (a_string_8: READABLE_STRING_8)
			-- Write escaped `a_string_32' to ouput stream
		require
			is_open_write: is_open_write
			a_string_not_void: a_string_8 /= Void
		do
			put_string_8 (xml_escaped_string (a_string_8))
		end

	put_string_32_escaped (a_string_32: READABLE_STRING_32)
			-- Write escaped `a_string_32' to ouput stream
		require
			is_open_write: is_open_write
			a_string_not_void: a_string_32 /= Void
		do
			put_string_32 (xml_escaped_unicode_string (a_string_32))
		end

	put_substring_general (a_string: READABLE_STRING_GENERAL; s, e: INTEGER)
			-- Write substring of `a_string' between indexes
			-- `s' and `e' to output stream.
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
			s_large_enough: s >= 1
			e_small_enough: e <= a_string.count
			valid_interval: s <= e + 1
		do
			if s <= e then
				put_string_general (a_string.substring (s, e))
			end
		end

	put_substring_8 (a_string: READABLE_STRING_8; s, e: INTEGER)
			-- Write substring of `a_string' between indexes
			-- `s' and `e' to output stream.
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
			s_large_enough: s >= 1
			e_small_enough: e <= a_string.count
			valid_interval: s <= e + 1
		do
			if s <= e then
				put_string_8 (a_string.substring (s, e))
			end
		end

	put_substring_32 (a_string: READABLE_STRING_32; s, e: INTEGER)
			-- Write substring of `a_string' between indexes
			-- `s' and `e' to output stream.
		require
			is_open_write: is_open_write
			a_string_not_void: a_string /= Void
			s_large_enough: s >= 1
			e_small_enough: e <= a_string.count
			valid_interval: s <= e + 1
		do
			if s <= e then
				put_string_32 (a_string.substring (s, e))
			end
		end

feature -- Output others		

	put_integer (i: INTEGER)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|(-?[1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_integer_64 (i)
		end

	put_integer_8 (i: INTEGER_8)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|(-?[1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_integer_64 (i)
		end

	put_integer_16 (i: INTEGER_16)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|(-?[1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_integer_64 (i)
		end

	put_integer_32 (i: INTEGER_32)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|(-?[1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_integer_64 (i)
		end

	put_integer_64 (i: INTEGER_64)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|(-?[1-9][0-9]*)
		require
			is_open_write: is_open_write
		local
			k, j: INTEGER_64
		do
			if i = 0 then
				put_character_8 ('0')
			elseif i < 0 then
				put_character_8 ('-')
					-- Avoid overflow.
				k := -(i + 1)
				j := k // 10
				inspect k \\ 10
				when 0 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('1')
				when 1 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('2')
				when 2 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('3')
				when 3 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('4')
				when 4 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('5')
				when 5 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('6')
				when 6 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('7')
				when 7 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('8')
				when 8 then
					if j /= 0 then
						put_integer_64 (j)
					end
					put_character_8 ('9')
				when 9 then
					put_integer_64 (j + 1)
					put_character_8 ('0')
				end
			else
				k := i
				j := k // 10
				if j /= 0 then
					put_integer_64 (j)
				end
				inspect k \\ 10
				when 0 then
					put_character_8 ('0')
				when 1 then
					put_character_8 ('1')
				when 2 then
					put_character_8 ('2')
				when 3 then
					put_character_8 ('3')
				when 4 then
					put_character_8 ('4')
				when 5 then
					put_character_8 ('5')
				when 6 then
					put_character_8 ('6')
				when 7 then
					put_character_8 ('7')
				when 8 then
					put_character_8 ('8')
				when 9 then
					put_character_8 ('9')
				end
			end
		end

	put_natural_8 (i: NATURAL_8)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|([1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_natural_64 (i)
		end

	put_natural_16 (i: NATURAL_16)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|([1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_natural_64 (i)
		end

	put_natural_32 (i: NATURAL_32)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|([1-9][0-9]*)
		require
			is_open_write: is_open_write
		do
			put_natural_64 (i)
		end

	put_natural_64 (i: NATURAL_64)
			-- Write decimal representation
			-- of `i' to output stream.
			-- Regexp: 0|([1-9][0-9]*)
		require
			is_open_write: is_open_write
		local
			k, j: NATURAL_64
		do
			if i = 0 then
				put_character_8 ('0')
			else
				k := i
				j := k // 10
				if j /= 0 then
					put_natural_64 (j)
				end
				inspect k \\ 10
				when 0 then
					put_character_8 ('0')
				when 1 then
					put_character_8 ('1')
				when 2 then
					put_character_8 ('2')
				when 3 then
					put_character_8 ('3')
				when 4 then
					put_character_8 ('4')
				when 5 then
					put_character_8 ('5')
				when 6 then
					put_character_8 ('6')
				when 7 then
					put_character_8 ('7')
				when 8 then
					put_character_8 ('8')
				when 9 then
					put_character_8 ('9')
				end
			end
		end

	put_boolean (b: BOOLEAN)
			-- Write "True" to output stream if
			-- `b' is true, "False" otherwise.
		require
			is_open_write: is_open_write
		do
			if b then
				put_string_8 (True_constant)
			else
				put_string_8 (False_constant)
			end
		end

feature -- Output content of input stream

	append (a_input_stream: XML_INPUT_STREAM)
			-- Read items of `a_input_stream' until the end
			-- of input is reached, and write these items to
			-- current output stream.
		do
			from
				if not a_input_stream.end_of_input then
					a_input_stream.read_character_code
				end
			until
				a_input_stream.end_of_input
			loop
				put_code (a_input_stream.last_character_code)
				a_input_stream.read_character_code
			end
		end

feature -- Basic operations

	flush
			-- Flush buffered data to disk.
		require
			is_open_write: is_open_write
		deferred
		end

feature {NONE} -- Implementation

	xml_escaped_string (s: READABLE_STRING_GENERAL): STRING_8
		do
			Result := xml_utilities.escaped_xml (s)
		end

	xml_escaped_unicode_string (s: READABLE_STRING_32): STRING_32
		do
			Result := xml_utilities.escaped_unicode_xml (s)
		end

	xml_utilities: XML_UTILITIES
		once
			create Result
		end

	True_constant: STRING = "True"
			-- String representation of boolean value 'True'

	False_constant: STRING = "False"
			-- String representation of boolean value 'False'		

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
