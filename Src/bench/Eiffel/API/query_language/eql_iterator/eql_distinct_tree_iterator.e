indexing
	description: "Object that represents a distinct tree iterator in EQL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_DISTINCT_TREE_ITERATOR [G -> EQL_ITERABLE_ITEM]

inherit
	EQL_DISTINCT_ITERATOR [G]

	EQL_TREE_ITERATOR [G]
		redefine
			make,
			start,
			forth
		end

create
	make

feature{NONE} -- Initialization

	make (a_tree: like tree) is
			-- Initialize `tree' with `a_tree'.
		do
			create visited_nodes.make
			create returned_items.make
			returned_items.compare_objects
			Precursor (a_tree)
		end

feature -- Iteration

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
				returned_items.wipe_out
				visited_nodes.wipe_out
				visited_nodes.extend (current_node)
				returned_items.extend (item)
			else
				current_node := tree
				internal_after := True
			end
		end

	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		local
			l_index: INTEGER
			done: BOOLEAN
			l_node: like current_node
		do
			from
			until
				after or done
			loop
				l_index := child_stack.item + 1
				if l_index <= current_node.count then
					l_node := current_node.i_th (l_index)
					child_stack.replace (l_index)
					if not visited_nodes.has (l_node) then
								-- We only process un-visited nodes.
						child_stack.extend (0)
						current_node := current_node.i_th (l_index)
						parent_stack.extend (current_node)
						if not returned_items.has (current_node.data) then
								-- We only return items that are distinct.
							returned_items.extend (current_node.data)
							done := True
						end
					end
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

feature{NONE} -- Implementation

	visited_nodes: LINKED_LIST [EQL_TREE_NODE [G]]
			-- List of visited node

	returned_items: LINKED_LIST [G]
			-- List of returned item

invariant
	visited_nodes_not_void: visited_nodes /= Void
	returned_items_not_void: returned_items /= Void

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
