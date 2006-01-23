indexing
	description: "[
		Objects that permit comparison of EV_MULTI_COLUMN_LIST_ROW based on
		`text' of a paticular item.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTI_COLUMN_LIST_ROW_STRING_COMPARATOR
	
inherit
	KL_PART_COMPARATOR [EV_MULTI_COLUMN_LIST_ROW]
	
feature -- Status Setting
	
	set_sort_column (a_column: INTEGER) is
			-- Use column `a_column' for search comparison.
		do
			sort_column := a_column
		end

feature -- Measurement

	less_than (u, v: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN is
			-- Is `u' considered less than `v'?
		do
			Result := u.i_th (sort_column) < v.i_th (sort_column)
		end
		
feature -- Access

	sort_column: INTEGER;
		-- Column on which sorting is performed.

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


end -- class MULTI_COLUMN_LIST_ROW_STRING_COMPARATOR