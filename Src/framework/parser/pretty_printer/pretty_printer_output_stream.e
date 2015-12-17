note
	description: "Output stream to produce prettified text."

class
	PRETTY_PRINTER_OUTPUT_STREAM

inherit
	LOCALIZED_PRINTER

create
	make_file,
	make_standard_output,
	make_string

feature {NONE} -- Creation

	make_file (f: FILE; e: ENCODING)
			-- Associate output with a file `f' in encoding `e'.
		require
			f_is_open_write: f.is_open_write
		do
			output := agent (s: READABLE_STRING_GENERAL; o: FILE; c: ENCODING)
				local
					u: UTF_CONVERTER
				do
					if attached c then
							-- Write in a given encoding.
						utf32.convert_to (c, s)
						if utf32.last_conversion_successful then
							o.put_string (utf32.last_converted_string_8)
						else
								-- Write in UTF-8 by default.
							o.put_string (u.utf_32_string_to_utf_8_string_8 (s))
						end
					else
							-- Write in UTF-8 by default.
						o.put_string (u.utf_32_string_to_utf_8_string_8 (s))
					end
				end
			(?, f, e)
			is_open_query := agent f.is_open_write
		end

	make_standard_output
			-- Associate output with standard output.
		do
			is_open_query := agent (io.output).is_open_write
			output := agent (s: READABLE_STRING_GENERAL)
				do
					localized_print (s)
				end
		end

	make_string (s: STRING_32)
			-- Associate output with a string `s'.
		do
			output := agent s.append_string_general (?)
			is_open_query := agent: BOOLEAN do Result := True end
		end

feature -- Status report

	is_open: BOOLEAN
			-- Is stream open for writing?
		do
			Result := is_open_query.item (Void)
		end

feature -- Output

	put_string (s: READABLE_STRING_GENERAL)
			-- Write string `s' to output.
		require
			is_open: is_open
		do
			output.call ([s])
		end

feature {NONE} -- Access

	output: PROCEDURE [READABLE_STRING_GENERAL]
			-- Procedure to write.

	is_open_query: PREDICATE
			-- Function to check stream status.

;note
	revision: "$Revision$"
	date: "$Date$"
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
