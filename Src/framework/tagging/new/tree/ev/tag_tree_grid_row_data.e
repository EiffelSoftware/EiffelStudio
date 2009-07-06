note
	description: "Summary description for {TAG_TREE_GRID_ROW_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_GRID_ROW_DATA [G -> TAG_ITEM]

inherit
	TAG_TREE_GRID_NODE_CONTAINER [G]
		redefine
			rebuild
		end

create
	make

feature {NONE} -- Implementation

	make (a_tree: like sparse_tree; a_node: like node; a_row: like row)
		require
			a_tree_attached: a_tree /= Void
			a_node_attached: a_node /= Void
			a_row_attached: a_row /= Void
		do
			sparse_tree := a_tree
			node := a_node
			row := a_row
			row.set_data (Current)
			if not node.is_leaf then
				row.ensure_expandable
				if sparse_tree.is_node_expanded (node) then
					row.expand
				end
			end
		end

feature -- Access

	sparse_tree: TAG_TREE_GRID [G]
			-- <Precursor>

	node: TAG_TREE_NODE [G]
			-- <Precursor>

	row: EV_GRID_ROW
			-- Row which's data points to `Current'

feature {NONE} -- Access

	grid: EV_GRID
		do
			Result := row.parent
		end

	new_row_start_index: INTEGER
			-- <Precursor>
		do
			Result := row.index + 1
		end

feature -- Status report

	is_connected: BOOLEAN
			-- <Precursor>
		do
			Result := node.is_active
		end

feature -- Status setting

	rebuild
			-- <Precursor>
		local
			l_expanded: BOOLEAN
		do
			l_expanded := row.is_expanded

			Precursor

			if l_expanded and not row.is_expanded then
				row.expand
			end
		end


feature {NONE} -- Query

	is_valid_index (a_pos: INTEGER): BOOLEAN
		do
			if a_pos > 0 and a_pos <= grid.row_count + 1 then
				Result := a_pos > row.index and
				          a_pos <= row.index + row.subrow_count_recursive + 1 and
				          (a_pos < row.index + row.subrow_count_recursive implies
				           grid.row (a_pos).parent_row = row)
			end
		end

feature {NONE} -- Implementation

	insert_new_row (a_pos: INTEGER)
		do
			grid.insert_new_row_parented (a_pos, row)
		end

invariant
	row_attached: row /= Void
	node_attached: node /= Void
	row_contains_current: row.data = Current

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
