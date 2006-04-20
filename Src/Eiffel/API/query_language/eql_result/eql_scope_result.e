indexing
	description: "Object that represents a scope result from an EQL query"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_SCOPE_RESULT [G -> EQL_SOFTWARE_SINGLE_SCOPE]

inherit
	EQL_RESULT [G]
		redefine
			itr, distinct_itr
		end

	EQL_COMPOSITE_SCOPE
		undefine
			is_equal,
			copy
		end

create
	make

feature -- Iterator

	itr: EQL_SCOPE_RESULT_ITERATOR [G] is
			-- Iterator for current
		do
			create Result.make (Current)
		end

	distinct_itr: EQL_DISTINCT_SCOPE_RESULT_ITERATOR [G] is
			-- Distinct iterator
		do
			create Result.make (Current)
		end

feature -- Replication

	replicate_with_criterion (a_criterion: EQL_CRITERION): like Current is
			-- Replicate Current: only items that satisfy `a_criterion' will be replicated.
		require
			a_criterion_not_void: a_criterion /= Void
		local
			l_node: EQL_TREE_NODE [G]
			l_index: INTEGER
		do
			create Result.make
			l_index := index
			from
				start
			until
				after
			loop
				l_node := filtered_node (item, a_criterion, Result)
				if l_node /= Void then
					Result.extend (l_node)
				end
				forth
			end
			go_i_th (l_index)
		ensure
			Result_not_void: Result /= Void
		end

feature{NONE} -- Implementation

	filtered_node (a_node: EQL_TREE_NODE [G]; a_criterion: EQL_CRITERION; a_root: like Current): EQL_TREE_NODE [G] is
			-- A tree node containing items in `a_node' which satisfy `a_criterion'.
			-- Returned node has `a_root' as its new `root_node'.
		require
			a_node_not_void: a_node /= Void
			a_criterion_not_void: a_criterion /= Void
			a_root_not_void: a_root /= Void
		local
			l_node: EQL_TREE_NODE [G]
			l_index: INTEGER
		do
			if a_criterion.evaluate (a_node.data.context) then
				create Result.make_with_data (a_root, a_node.data)
				if not a_node.is_empty then
					l_index := a_node.index
					from
						a_node.start
					until
						a_node.after
					loop
						l_node := filtered_node (a_node.item, a_criterion, a_root)
						if l_node /= Void  then
							Result.extend (l_node)
						end
						a_node.forth
					end
					a_node.go_i_th (l_index)
				end
			end
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
