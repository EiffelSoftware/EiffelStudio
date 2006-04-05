indexing

	description: 
		"Cells containing two items."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	
	CELL2 [G, H]

inherit

	CELL [G]
		rename
			item as item1,
			put as put1,
			replace as replace1
		end

create

	make

feature -- Initialization

	make (v: like item1; u: like item2) is
			-- Make `v' and `u' the cell's items.
		do
			item1 := v;
			item2 := u
		ensure
			item1_inserted: item1 = v;
			item2_inserted: item2 = u
		end;

feature -- Access

	item2: H;
			-- Second item of the cell

feature -- Element change

	put2, replace2 (u: like item2) is
			-- Make `u' the second cell's item.
		do
			item2 := u
		ensure
			item2_inserted: item2 = u
		end;

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

end -- class CELL2
