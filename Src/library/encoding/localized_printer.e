note
	description: "Print Unicode into the console if possible."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALIZED_PRINTER

inherit
	ANY

	SYSTEM_ENCODINGS
		export
			{NONE} all
		end

feature -- Output

	localized_print (a_str: READABLE_STRING_GENERAL)
			-- Print `a_str' as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		do
			if a_str /= Void then
				if attached utf32_to_console_encoding (console_encoding, a_str) as l_string then
					io.put_string (l_string)
				else
					io.put_string (a_str.as_string_8)
				end
			end
		end

	localized_print_error (a_str: READABLE_STRING_GENERAL)
			-- Print an error, `a_str', as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		do
			if a_str /= Void then
				if attached utf32_to_console_encoding (console_encoding, a_str) as l_string then
					io.error.put_string (l_string)
				else
					io.error.put_string (a_str.as_string_8)
				end
			end
		end

feature -- Conversion

	utf32_to_console_encoding (a_console_encoding: ENCODING; a_str: READABLE_STRING_GENERAL): STRING_8
			-- Convert `a_str' to console encoding if possible.
			-- `a_str' is taken as a UTF-32 string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		local
			l_result: detachable STRING_8
		do
			utf32.convert_to (a_console_encoding, a_str)
			if utf32.last_conversion_successful then
				l_result := utf32.last_converted_string_8
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert UTF-32 to UTF-8 first, then convert UTF-8 to `a_console_encoding'.
				utf32.convert_to (utf8, a_str)
				if utf32.last_conversion_successful then
					if not utf8.is_equal (a_console_encoding) then
						l_result := utf32.last_converted_string_8
						utf8.convert_to (a_console_encoding, l_result)
						if utf8.last_conversion_successful then
							l_result := utf8.last_converted_string_8
						end
					else
						l_result := utf32.last_converted_string_8
					end
				end
				if l_result = Void then
					l_result := a_str.as_string_8
				end
			end
			Result := l_result
		end

	console_encoding_to_utf32 (a_console_encoding: ENCODING; a_str: READABLE_STRING_GENERAL): STRING_32
			-- Convert `a_str' to UTF-32 if possible.
			-- `a_str' is taken as a console encoding string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		local
			l_result: detachable STRING_32
		do
			a_console_encoding.convert_to (utf32, a_str)
			if a_console_encoding.last_conversion_successful then
				l_result := a_console_encoding.last_converted_string_32
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert `a_console_encoding' to UTF-8 first, then convert UTF-8 to UTF-32.
				if not utf8.is_equal (a_console_encoding) then
					a_console_encoding.convert_to (utf8, a_str)
					if a_console_encoding.last_conversion_successful then
						l_result := a_console_encoding.last_converted_string_32
						utf8.convert_to (utf32, l_result)
						if utf8.last_conversion_successful then
							l_result := utf8.last_converted_string_32
						end
					end
				else
					utf8.convert_to (utf32, a_str)
					if utf8.last_conversion_successful then
						l_result := utf8.last_converted_string_32
					end
				end
				if l_result = Void then
					l_result := a_str.as_string_32
				end
			end
			Result := l_result
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
