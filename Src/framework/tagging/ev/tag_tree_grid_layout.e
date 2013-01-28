note
	description: "Summary description for {TAG_TREE_GRID_LAYOUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_GRID_LAYOUT [G -> TAG_ITEM]

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current' with default values.
		do
			column_count := 1
		end

feature -- Access

	column_count: INTEGER
			-- Number of columns to be shown in grid

	column_width (a_column: like column_count): INTEGER
			-- Default width of column with given index
			--
			-- `a_column': Index of column for which default width should be returned.
		require
			valid_column: a_column > 0 and a_column <= column_count
		do
			Result := 150
		ensure
			result_not_negative: Result >= 0
		end

feature -- Status report

	has_header: BOOLEAN
			-- Should grid header be shown?

feature -- Factory

	populate_header_item (an_item: EV_GRID_HEADER_ITEM; a_grid: TAG_TREE_GRID [G])
			-- Populate header item.
			--
			-- Note: the idea is that `Current' should create the item, however this is not supported for
			--       {EV_GRID_HEADER_ITEM} so it is passed as an argument. `Current' should must not keep
			--       any reference of `an_item' or the corresponding {EV_GRID}.
			--
			-- `an_item': Header item to be populated.
			-- `a_grid': Grid displaying header.
		require
			an_item_attached: an_item /= Void
			a_grid_attached: a_grid /= Void
			has_header: has_header
			an_item_column_valid: an_item.column.index <= column_count
		do

		end

	new_item (a_column: like column_count; a_grid: TAG_TREE_GRID [G]; a_node: TAG_TREE_NODE [G]): detachable EV_GRID_ITEM
			-- Create new grid item for column with given index and tree node.
			--
			-- Note: can return Void if empty item should be shown in grid.
			--
			-- `a_column': Index of column for which item should be created.
			-- `a_node': Node representing current row.
			-- `Result': New grid item.
		require
			a_grid_attached: a_grid /= Void
			a_node_attached: a_node /= Void
			valid_column: a_column > 0 and a_column <= column_count
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
		local
			l_label: EV_GRID_LABEL_ITEM
		do
			if a_column = 1 then
				create l_label
				if not a_grid.is_inside_node (a_node) and not a_grid.is_parent_node (a_node) then
					l_label.set_foreground_color (colors.gray)
				end
				l_label.set_text (token_text (a_node, a_node = a_grid.common_parent and a_grid.hide_outside_nodes))
				Result := l_label
			end
		end

feature {NONE} -- Implementations

	token_text (a_node: TAG_TREE_NODE [G]; a_append_parents: BOOLEAN): STRING_32
			-- Text representing given node. If `a_append_parents' is true, text will also contain tokens
			-- of parents node, separated by "/".
		require
			a_node_attached: a_node /= Void
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
		local
			l_parent: TAG_TREE_NODE [G]
		do
			l_parent := a_node.parent
			if l_parent.is_root or not a_append_parents then
				create Result.make (100)
			else
				Result := token_text (l_parent, a_append_parents)
				Result.append_character ('/')
			end


			Result.append_string (a_node.token)
		end

	colors: EV_STOCK_COLORS
			-- EV colors to be used by `Current'.
		once
			create Result
		end

invariant
	column_count_positive: column_count > 0

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
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
