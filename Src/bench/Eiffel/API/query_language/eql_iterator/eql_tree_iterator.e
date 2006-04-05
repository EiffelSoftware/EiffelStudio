indexing
	description: "Object that represents a tree iterator for an EQL tree result"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_TREE_ITERATOR [G -> EQL_ITERABLE_ITEM]

inherit
	EQL_ITERATOR [G]

create
	make

feature{NONE} -- Initialization

	make (a_tree: like tree) is
			-- Initialize `tree' with `a_tree'.
		do
			tree := a_tree
			create child_stack.make (10)
			create parent_stack.make (10)
			start
		ensure
			tree_set: tree = a_tree
		end

feature -- Status reporting

	item: G is
			-- Item at current position
		do
			Result := current_node.data
		end

	node_item: like tree is
			-- Tree node at current position
		require
			not_off: not off
			status_valid: valid_status
		do
			Result := current_node
		end

	is_empty: BOOLEAN is
			-- Is there no element?
		do
			Result := tree.count = 0
		end

	after: BOOLEAN is
			-- Is there no valid position to the right of current one,
			-- or has the structure that is being iterated been changed since `start'?
		do
			Result := internal_after or (not valid_status)
		end

	index: INTEGER is
			-- Index of current position
		do
			Result := internal_index
		end

feature -- Cursor movement

	start is
			-- Move to first position if any.
		do
			internal_index := 1
			if tree.count > 0 then
				current_node := tree.first
				child_stack.wipe_out
				child_stack.extend (1)
				child_stack.extend (0)
				parent_stack.wipe_out
				parent_stack.extend (tree)
				parent_stack.extend (current_node)
				expected_modification_count := tree.modification_count
				internal_after := False
			else
				current_node := tree
				internal_after := True
			end
		end

	finish is
			-- Move to last position.
		local
			l_child_stack: like child_stack
			l_node: like current_node
			l_index: INTEGER
			done: BOOLEAN
		do
			from
				start
			until
				done
			loop
					-- Save status temporarily.
				l_child_stack := child_stack.twin
				l_node := current_node
				l_index := internal_index
				forth
				if after then
						-- Last element found, restore status.
					child_stack := l_child_stack.twin
					internal_index := l_index
					current_node := l_node
					done := True
				end
			end
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		local
			l_index: INTEGER
			done: BOOLEAN
		do
			from
			until
				after or done
			loop
				l_index := child_stack.item + 1
				if l_index <= current_node.count then
					child_stack.replace (l_index)
					child_stack.extend (0)
					current_node := current_node.i_th (l_index)
					parent_stack.extend (current_node)
					done := True
				else
					parent_stack.remove
					child_stack.remove
					if parent_stack.is_empty then
						current_node := tree
						internal_after := True
					else
						current_node := parent_stack.item
					end
				end
			end
			internal_index := internal_index + 1
		end

feature -- Distinct list

	distinct_list: LIST [G] is
			-- List containing only distinct EQL_RESULT_ITEMs
		local
			l_index: INTEGER
		do
			create {LINKED_LIST[G]}Result.make
			Result.compare_objects
			l_index := internal_index
			from
				start
			until
				after
			loop
				if not Result.has (current_node.data) then
					Result.extend (current_node.data)
				end
				forth
			end
				-- Back to original position.
			from
				start
			until
				index = l_index
			loop
				forth
			end
		end

feature -- Fail fast status

	valid_status: BOOLEAN is
			-- Is the structure to be iterated in a valid status?
			-- e.g. It has not been changed after current iterator `start'.
		do
			Result := tree.modification_count = expected_modification_count
		end

feature{NONE} -- Implementation

	current_node: like tree
			-- Internal node to indicate current node at position

	child_stack: ARRAYED_STACK [INTEGER]
			-- Child internal_index stack used to iterate

	parent_stack: ARRAYED_STACK [like tree]
			-- Internal stack to store parent iteration history

	expected_modification_count: NATURAL_64
			-- Modification count of `tree' when current iterator `start'.

	internal_index: INTEGER
			-- Internal index

	internal_after: BOOLEAN
			-- Internal flag to indicate `after'

	tree: EQL_TREE_NODE [G]
			-- Tree result to be iterated throught
invariant
	tree_not_void: tree /= Void
	parent_stack_not_void: parent_stack /= Void
	child_index_stack_not_void: child_stack /= Void

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
