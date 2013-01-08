note
	description: "Routines for use by classes that need to print eiffel strings and characters in the context of debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_CHARACTER_ROUTINES

inherit
	CHARACTER_ROUTINES
		redefine
			char32_to_string_32
		end

feature {NONE} -- Implementation

	char32_to_string_32 (char: CHARACTER_32; a_result: detachable STRING_32; for_string: BOOLEAN): STRING_32
			-- <Precursor>
			-- In addition, escape the `{UTF_CONVERTER}.escaped_character' character used for {PATH} and related
		do
			Result := Precursor (char, a_result, for_string)
			if char = {UTF_CONVERTER}.escape_character then
					-- Escape the `escape_character' so that it is displayed as is.
				Result.append_character (char)
			end
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
