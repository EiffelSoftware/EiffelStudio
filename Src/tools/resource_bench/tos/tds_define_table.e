indexing
	description: "To store the `#define' data"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_DEFINE_TABLE

feature -- Access

	define_table: HASH_TABLE [COUPLE, STRING] is
			-- Contain the define name and the define value.
		do
			Result := define_table_cell.item
		end

feature -- Element change

	set_define_table (a_define_table: HASH_TABLE [COUPLE, STRING]) is
			-- Set `define_table' to `a_define_table'.
		require
			a_define_table_not_void: a_define_table /= Void
		do
			define_table_cell.put (a_define_table)
		ensure
			define_table_set: define_table = a_define_table
		end

feature {NONE} -- Implementation

	define_table_cell: CELL [HASH_TABLE [COUPLE, STRING]] is
			-- The current `define_table'.
		once
			!!Result.put (Void)
		ensure
			result_not_void: Result /= Void
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
end -- class TDS_DEFINE_TABLE
