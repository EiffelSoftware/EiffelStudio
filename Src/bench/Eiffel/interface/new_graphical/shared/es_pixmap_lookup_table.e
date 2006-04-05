indexing
	description: "Hash table used for querying pixmap coordinates in matrix"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_PIXMAP_LOOKUP_TABLE

inherit
	HASH_TABLE [INTEGER, INTEGER]

create
	make_with_values

feature {NONE} -- Initialization

	make_with_values (a_columns, a_rows: INTEGER) is
			-- Create lookup table to for matrix pixmap retrieval.
		require
			columns_valid: a_columns > 0
			rows_valid: a_rows > 0
		do
			make (a_columns * a_rows)
			columns := a_columns
			rows := a_rows
		ensure
			columns_set: columns = a_columns
			rows_set: rows = a_rows
		end

feature -- Insert

	add_pixmap (a_column, a_row, a_constant: INTEGER) is
		require
			valid_column: a_column > 0 and then a_column <= columns
			valid_row: a_row > 0 and then a_row <= rows
		do
			put (columns * (a_row - 1) + a_column, a_constant)
		end

feature -- Access

	columns: INTEGER
		-- Number of columns used for lookup.

	rows: INTEGER;
		-- Number of rows used for lookup.	

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
