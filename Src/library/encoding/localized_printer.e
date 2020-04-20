note
	description: "Print Unicode into the console if possible."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCALIZED_PRINTER

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
