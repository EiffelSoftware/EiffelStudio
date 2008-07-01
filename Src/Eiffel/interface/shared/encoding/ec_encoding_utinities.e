indexing
	description: "Ease encoding conversion and others."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_ENCODING_UTINITIES

inherit
	EC_ENCODINGS

	ENCODING_HELPER

feature -- Conversion

	convert_to_stream (a_string: STRING_32; a_encoding: ENCODING): STRING_8 is
			-- Convert `a_string' from UTF32 to `a_encoding'.
			-- Result stream representation.
		require
			a_string_not_void: a_string /= Void
		local
			l_encoding: ENCODING
		do
			l_encoding := a_encoding
			if l_encoding = Void then
				l_encoding := default_encoding
			end
			if not a_encoding.is_equal (utf32) then
				utf32.convert_to (a_encoding, a_string)
				Result := utf32.last_converted_stream
			end
			if Result = Void then
				Result := a_string.as_string_8
			end
		ensure
			Result_not_void: Result /= Void
		end

	utf8_to_utf32 (a_string: STRING_8): STRING_32 is
			-- Convert `a_string' from UTF-8 to UTF-32.
		require
			a_string_not_void: a_string /= Void
		do
			utf8.convert_to (utf32, a_string)
			if utf8.last_conversion_successful then
				Result := utf8.last_converted_string.as_string_32
			else
				Result := a_string.as_string_32
			end
		ensure
			a_string_not_void_implies_attached: Result /= Void
		end

	utf32_to_utf8 (a_string: STRING_32): STRING_8 is
			-- Convert `a_string' from UTF-32 to UTF-8.
		require
			a_string_not_void: a_string /= Void
		do
			utf32.convert_to (utf8, a_string)
			if utf32.last_conversion_successful then
				Result := utf32.last_converted_string.as_string_8
			else
				Result := a_string.as_string_8
			end
		ensure
			a_string_not_void_implies_attached: Result /= Void
		end

	utf32_to_utf16_stream (a_string: STRING_32): STRING_8 is
			-- Convert `a_string' from UTF-32 to UTF-16 stream.
		require
			a_string_not_void: a_string /= Void
		do
			utf32.convert_to (utf16, a_string)
			if utf32.last_conversion_successful then
				Result := utf32.last_converted_stream
			else
				Result := a_string.as_string_8
			end
		ensure
			a_string_not_void_implies_attached: Result /= Void
		end

	utf16_stream_to_utf32 (a_string: STRING_8): STRING_32 is
			-- Convert `a_string' from UTF-16 steam to UTF-32.
		require
			a_string_not_void: a_string /= Void
		local
			l_str: STRING_32
		do
			l_str := pointer_to_wide_string (a_string.area.base_address, a_string.count)
			utf16.convert_to (utf32, l_str)
			if utf8.last_conversion_successful then
				Result := utf8.last_converted_string.as_string_32
			else
				Result := a_string.as_string_32
			end
		ensure
			a_string_not_void_implies_attached: Result /= Void
		end

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
