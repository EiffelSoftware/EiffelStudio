note
	description: "Collection of string processing functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_UTILITY

feature {NONE} -- Lookup

	key_name (string: READABLE_STRING_32; start_index, end_index: INTEGER; keys: ITERABLE [READABLE_STRING_GENERAL]): detachable READABLE_STRING_32
			-- A key from `keys' (if any) starting at `start_index' and ending at `end_index' of a string `string'.
		require
			valid_start_index: string.valid_index (start_index)
			valid_end_index: string.valid_index (end_index)
			valid_start_index_end_index: start_index <= end_index
		local
			n: INTEGER
		do
			n := end_index + 1 - start_index
			across
				keys as c
			until
				attached Result
			loop
				if
					c.count = n and then
					c.same_characters (string, start_index, end_index, 1)
				then
					Result := c.as_string_32
				end
			end
		ensure
			valid_key: attached Result implies across keys as c some c.same_string (Result)  end
		end

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
