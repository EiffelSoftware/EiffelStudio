indexing
	description: "[
		Sorting algorithm for W_code and F_code directories. The C directories
		appear first and then the E directories.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DIRECTORY_SORTER

inherit
	DS_COMPARATOR [STRING]

feature -- Comparison

	less_than (u, v: STRING): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			if u.valid_index (1) and v.valid_index (1) then
				Result := u.item (1) = v.item (1)
				if Result then
						-- Same letter, we ensure that smaller strings
						-- are smaller than larger ones. If they have
						-- the same count, then we use the string comparison.
					if u.count = v.count then
						Result := u <= v
					else
						Result := u.count <= v.count
					end
				else
					Result := u.item (1) <= v.item (1)
				end
			else
				Result := u <= v
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
