indexing
	description: "object that represents just a coordinate"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_EMPTY_COORDINATED_ITEM

inherit
	EVS_GRID_COORDINATED
		redefine
			row_index,
			column_index,
			is_column_index_available,
			is_row_index_available
		end

create
	make

feature{NONE} -- Initialization

	make (a_column, a_row: INTEGER) is
			-- Initialize `column_index' with `a_column' and
			-- `row_index' with `a_row'.
		do
			column_index := a_column
			row_index := a_row
		ensure
			column_index_set :column_index = a_column
			row_index_set: row_index = a_row
		end

feature -- Position

	column_index: INTEGER
			-- Index of column

	row_index: INTEGER
			-- Index of row

feature -- Status report

	is_column_index_available: BOOLEAN is True
			-- Is `column_index' available?

	is_row_index_available: BOOLEAN is True;
			-- Is `row_index' available?

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
