indexing
	description: "Object that represents an EQL query"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_QUERY

feature -- Execution

	execute (a_scope: EQL_SCOPE) is
			-- Execute current query over `a_scope' and with `null_criterion'.
			-- If successful, store result in `last_result'.
		require
			a_scope_not_void: a_scope /= Void
		do
			execute_with_criterion (a_scope, null_criterion)
		end

	execute_with_criterion (a_scope: EQL_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute current query over `a_scope' and with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_itr: EQL_ITERATOR [EQL_SINGLE_SCOPE]
		do
			create last_result.make
			l_itr := a_scope.distinct_itr
			from
				l_itr.start
			until
				l_itr.after
			loop
				if l_itr.item /= Void then
					execute_over_single_scope (l_itr.item, a_criterion)
				end
				l_itr.forth
			end
		end

feature -- Result

	last_result: EQL_RESULT [EQL_RESULT_ITEM]
			-- Last result

feature -- Null criterion

	null_criterion: EQL_NULL_CRITERION is
			-- Null criterion which is always satisfied
		once
			create Result
		end

feature -- Status reporting

	executable (a_single_scope: EQL_SINGLE_SCOPE): BOOLEAN is
			-- Is current query exectuable over `a_single_scope'?
		require
			a_single_scope_not_void: a_single_scope /= Void
		do
			Result := True
		end

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		require
			a_single_scope_not_void: a_single_scope /= Void
			a_criterion_not_void: a_criterion /= Void
			last_result_not_void: last_result /= Void
			executable: executable (a_single_scope)
		deferred
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
