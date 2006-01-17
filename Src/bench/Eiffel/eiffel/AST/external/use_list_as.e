indexing
	description: "List of dependencies of external clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	USE_LIST_AS

inherit
	EIFFEL_LIST [ID_AS]
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make
	
create {USE_LIST_AS}
	make_filled

feature -- Array representaion

	array_representation: ARRAY [INTEGER] is
			-- Array representation of list of files required by external.
		local
			i: INTEGER
			l_names_heap: like Names_heap
		do
			from
				create Result.make (1, count)
				l_names_heap := Names_heap
				i := 1
				start
			until
				after
			loop
				l_names_heap.put (item)
				Result.put (l_names_heap.found_item, i)
				i := i + 1
				forth
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class USE_LIST_AS
