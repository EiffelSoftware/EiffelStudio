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

	localized_print (a_str: detachable READABLE_STRING_GENERAL)
			-- Print `a_str' as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		do
			if a_str /= Void then
				if attached {READABLE_STRING_8} a_str as s8 then
					io.put_string (s8)
				else
					io.put_string_32 (a_str.to_string_32)
				end
			end
		end

	localized_print_error (a_str: detachable READABLE_STRING_GENERAL)
			-- Print an error, `a_str', as localized encoding.
			-- `a_str' is taken as a UTF-32 string.
		do
			if a_str /= Void then
				if attached {READABLE_STRING_8} a_str as s8 then
					io.error.put_string (s8)
				else
					io.error.put_string_32 (a_str.to_string_32)
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
		do
			utf32.convert_to (a_console_encoding, a_str)
			if utf32.last_conversion_successful then
				Result := utf32.last_converted_string_8
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert UTF-32 to UTF-8 first, then convert UTF-8 to `a_console_encoding'.
				utf32.convert_to (utf8, a_str)
				if utf32.last_conversion_successful then
					Result := utf32.last_converted_string_8
					if utf8 /~ a_console_encoding then
						utf8.convert_to (a_console_encoding, Result)
						if utf8.last_conversion_successful then
							Result := utf8.last_converted_string_8
						end
					end
				end
				if not attached Result then
					Result :=
						if a_str.is_valid_as_string_8 then
								-- Use original string.
							a_str.to_string_8
						else
								-- Fallback to UTF-8.
							{UTF_CONVERTER}.string_32_to_utf_8_string_8
								(if attached {READABLE_STRING_32} a_str as s then
									s
								else
									a_str.as_string_32
								end)
						end
				end
			end
		end

	console_encoding_to_utf32 (a_console_encoding: ENCODING; a_str: READABLE_STRING_GENERAL): STRING_32
			-- Convert `a_str' to UTF-32 if possible.
			-- `a_str' is taken as a console encoding string.
		require
			a_console_encoding_not_void: a_console_encoding /= Void
			a_str_not_void: a_str /= Void
		do
			a_console_encoding.convert_to (utf32, a_str)
			if a_console_encoding.last_conversion_successful then
				Result := a_console_encoding.last_converted_string_32
			else
					-- This is a hack, since some OSes don't support convertion from/to UTF-32 to `a_console_encoding'.
					-- We convert `a_console_encoding' to UTF-8 first, then convert UTF-8 to UTF-32.
				if utf8 ~ a_console_encoding then
					utf8.convert_to (utf32, a_str)
					if utf8.last_conversion_successful then
						Result := utf8.last_converted_string_32
					end
				else
					a_console_encoding.convert_to (utf8, a_str)
					if a_console_encoding.last_conversion_successful then
						Result := a_console_encoding.last_converted_string_32
						utf8.convert_to (utf32, Result)
						if utf8.last_conversion_successful then
							Result := utf8.last_converted_string_32
						end
					end
				end
				if not attached Result then
					Result := a_str.as_string_32
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
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
