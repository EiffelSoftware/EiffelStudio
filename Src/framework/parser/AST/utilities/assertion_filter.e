indexing
	description: "Object that filter out incomplete tagged assertions from a given tagged list"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASSERTION_FILTER

feature -- Filter

	filter_tagged_list (a_list: EIFFEL_LIST [TAGGED_AS]): EIFFEL_LIST [TAGGED_AS] is
			-- Filter out all incomplete tagged assertions (in form of "tag:")
			-- from `a_list', and return a list that only contains complete tagged assertions.
		do
			if a_list = Void or else a_list.is_empty then
				Result := Void
			else
				create Result.make (a_list.count)
				from
					a_list.start
				until
					a_list.after
				loop
					if a_list.item.is_complete then
						Result.extend (a_list.item)
					end
					a_list.forth
				end
				if Result.is_empty then
					Result := Void
				end
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
