indexing
	description: "Object that represents an iterator for single scope in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SINGLE_SCOPE_ITERATOR [G -> EQL_SINGLE_SCOPE]

inherit
	EQL_SCOPE_ITERATOR [G]
		redefine
			is_empty
		end

	EQL_DISTINCT_ITERATOR [G]

create
	make

feature{NONE} -- Implementation

	make (a_scope: G) is
			-- Initialize current iterator for `a_scope'.
		require
			a_scope_not_void: a_scope /= Void
		do
			scope := a_scope
			internal_index := 1
		ensure
			scope_set: scope = a_scope
		end

feature -- Status reporting

	is_empty: BOOLEAN is False
			-- Is there no element?

	item: G is
			-- Item at current position
		do
			Result := scope
		end

	index: INTEGER is
			-- Index of current position
		do
			Result := internal_index
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		do
			Result := internal_index = 2
		end

feature -- Iteration

	start is
			-- Move to first position if any.
		do
			internal_index := 1
		end

	finish is
			-- Move to last position.
		do
			internal_index := 1
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			internal_index := internal_index + 1
		end

feature -- Fail fast status

	valid_status: BOOLEAN is
			-- Is the structure to be iterated in a valid status?
			-- e.g. It has not been changed after current iterator `start'.
		do
			Result := True
		end

feature -- Distinct list

	distinct_list: LIST [G] is
			-- List containing only distinct EQL_RESULT_ITEMs
		do
			create {LINKED_LIST[G]}Result.make
			Result.compare_objects
			Result.extend (scope)
		end

feature{NONE} -- Implementation

	internal_index: INTEGER
			-- Internal index

	scope: G
			-- Structure to iterate

invariant
	scope_not_void: scope /= Void
	internal_index_positive: internal_index > 0

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
