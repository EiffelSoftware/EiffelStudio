indexing
	description: "Semantic information for constructs of the resource script language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TABLE_OF_SYMBOLS

feature -- Access

	tds: TABLE_OF_SYMBOLS_STRUCTURE is
			-- Informations about the analyzed resource script file.
		do
			Result := tds_cell.item
		end

feature -- Element change

	set_tds (a_tds: TABLE_OF_SYMBOLS_STRUCTURE) is
			-- Set the current `tds' to `a_tds'.
		require
			tds_not_void: a_tds /= Void
		do
			tds_cell.put (a_tds)
		ensure
			tds_set: tds = a_tds
		end

	erase_tds is
			-- Remove the element of `tds_cell'.
		do
			tds_cell.put (Void)
		end

feature {NONE} -- Implementation

	tds_cell: CELL [TABLE_OF_SYMBOLS_STRUCTURE] is
			-- The current `tds'.
		once
			create Result.put (Void)
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
end -- TABLE_OF_SYMBOLS

