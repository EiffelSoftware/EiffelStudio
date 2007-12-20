indexing
	description: "Shared reference to unique instance of NAMES_HEAP"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_NAMES_HEAP

feature -- Access

	names_heap: NAMES_HEAP is
			-- Unique instance of NAMES_HEAP.
		do
			Result := names_heap_cell.item
		ensure
			Result_not_void: Result /= Void
		end

	set_names_heap (a_heap: like names_heap) is
			-- Set `names_heap' with `a_heap'.
		require
			a_heap_not_void: a_heap /= Void
		do
			names_heap_cell.put (a_heap)
		ensure
			names_heap_set: names_heap = a_heap
		end

feature {NONE} -- Implementation

	names_heap_cell: CELL [NAMES_HEAP] is
			-- Storage for `names_heap'.
		once
			create Result.put (create {NAMES_HEAP}.make)
		ensure
			names_heap_cell_not_void: Result /= Void
			names_heap_not_void: Result.item /= Void
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

end -- class SHARED_NAMES_HEAP
