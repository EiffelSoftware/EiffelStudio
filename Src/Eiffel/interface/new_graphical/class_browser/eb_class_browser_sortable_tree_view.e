note
	description: "Sortable tree view used in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_CLASS_BROWSER_SORTABLE_TREE_VIEW [G]

inherit
	EB_CLASS_BROWSER_GRID_VIEW [G]

feature -- Access

	rows: EB_TREE_NODE [like row_type]
			-- Rows to be displayed in Current view
			-- Rows to be displayed in Current browser
		do
			if rows_internal = Void then
				create rows_internal
			end
			Result := rows_internal
		ensure
			result_attached: Result /= Void
		end

	rows_internal: like rows
			-- Implementation of `rows'

	levels_column_table: HASH_TABLE [LINEAR [INTEGER], INTEGER]
			-- Column to levels mapper indexed by column index.
			-- In a tree grid, several levels can be binded into one column, for example:

			-- Column 1      |
			-- + item1       |
			--    |          |
			--    +-- item2  |
			--
			-- item1 and item2 belong to different levels, but they are both binded in column 1, so when
			-- a sorting column 1, these two levels should be both sorted.
			-- `levels_column_table' is used to store which levels are binded in a certain level.
			-- the above example will yield ({1, 2}, 1) pair, in which, {1, 2} is level index, the last 1 is column index.
		do
			if levels_column_table_internal = Void then
				create levels_column_table_internal.make (5)
			end
			Result := levels_column_table_internal
		ensure
			result_attached: Result /= Void
		end

	level_starting_column_index: ARRAYED_LIST [INTEGER]
			-- Starting column index of levels indexed by level index.
		do
			if level_starting_column_index_internal = Void then
				create level_starting_column_index_internal.make (5)
			end
			Result := level_starting_column_index_internal
		end

	selected_rows: LIST [EV_GRID_ROW]
			-- Selected rows in `grid'.
			-- If empty, put the first row in `grid' in result.
		do
			Result := grid.selected_rows
			if Result.is_empty and then grid.row_count > 0 then
				create {ARRAYED_LIST [EV_GRID_ROW]}Result.make (1)
				Result.extend (grid.row (1))
			end
		end

feature{NONE} -- Actions

	on_grid_focus_in
			-- Action to be performed when `grid' gets focus
		do
			if is_tree_node_highlight_enabled then
				highlight_tree_on_grid_focus_change
			end
		end

	on_grid_focus_out
			-- Action to be performed when `grid' loses focus
		do
			if is_tree_node_highlight_enabled then
				highlight_tree_on_grid_focus_change
			end
		end

	on_key_pressed (a_key: EV_KEY)
			-- Action to be performed when some key is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
		end

	on_expand_all_level
			-- Action to be performed to recursively expand all selected rows.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent expand_row_recursively)
		end

	on_collapse_all_level
			-- Action to be performed to recursively collapse all selected rows.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent collapse_row_recursively)
		end

	on_expand_one_level
			-- Action to be performed to expand all selected rows.
		local
			l_selected_rows: like selected_rows
			l_row: EV_GRID_ROW
			l_done: BOOLEAN
		do
			l_selected_rows := selected_rows
			if l_selected_rows.count = 1 then
				l_row := l_selected_rows.first
				if not l_row.is_expandable or else l_row.is_expanded then
					go_to_first_child (l_row)
					l_done := True
				end
			end
			if not l_done then
				processed_rows.wipe_out
				do_all_in_rows (selected_rows, agent expand_row)
			end
		end

	on_collapse_one_level
			-- Action to be performed to collapse all selected rows.
		local
			l_selected_rows: like selected_rows
			l_row: EV_GRID_ROW
			l_done: BOOLEAN
		do
			l_selected_rows := selected_rows
			if l_selected_rows.count = 1 then
				l_row := l_selected_rows.first
				if not l_row.is_expandable or else not l_row.is_expanded then
					go_to_parent (l_row)
					l_done := True
				end
			end
			if not l_done then
				processed_rows.wipe_out
				do_all_in_rows (l_selected_rows, agent collapse_row_normal)
			end
		end

	on_collapse_one_level_partly
			-- Action to be performed to collapse on level but leave the first level of child rows open.
		do
			processed_rows.wipe_out
			do_all_in_rows (selected_rows, agent collapse_row)
		end

feature{NONE} -- Sorting

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [like row_type])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
		local
			l_array: LINEAR [INTEGER]
			l_levels_column_table: like levels_column_table
		do
			l_levels_column_table := levels_column_table
			from
				a_column_list.start
			until
				a_column_list.after
			loop
				l_array := l_levels_column_table.item (a_column_list.item)
				check l_array /= Void end
					-- Sort every level binded in a column respectively.
				l_array.do_all (agent sort_level (rows, ?, 1, a_comparator, a_column_list.item))
				a_column_list.forth
			end
			bind_grid
		end

	sort_level (a_level: EB_TREE_NODE [like row_type]; a_level_index: INTEGER; a_current_level: INTEGER; a_comparator: AGENT_LIST_COMPARATOR [like row_type]; a_column_index: INTEGER)
			-- Sort row level whose level index is specified by `a_level_index' starting from level `a_level' indexed by `a_level'.
			-- `a_comparator' is used to decide row orders.
		require
			a_level_attached: a_level /= Void
			a_comparator_attached: a_comparator /= Void
		local
			l_children: DS_LIST [EB_TREE_NODE [like row_type]]
			l_sorter: DS_QUICK_SORTER [EB_TREE_NODE [like row_type]]
			l_comparater: AGENT_LIST_COMPARATOR [like row_type]
			l_agent: AGENT_BASED_EQUALITY_TESTER [EB_TREE_NODE [like row_type]]
		do
			if a_current_level < a_level_index then
				from
					l_children := a_level.children
					l_children.start
				until
					l_children.after
				loop
					sort_level (l_children.item_for_iteration, a_level_index, a_current_level + 1, a_comparator, a_column_index)
					l_children.forth
				end
			else
				l_comparater := a_comparator.new_agent_list_comparator (<<a_column_index>>)
				create l_agent.make (agent tree_node_tester (?, ?, l_comparater))
				create l_sorter.make (l_agent)
				l_sorter.sort (a_level.children)
			end
		end

	tree_node_tester (a_node, b_node: EB_TREE_NODE [like row_type]; a_comparator: KL_PART_COMPARATOR [like row_type]): BOOLEAN
			-- Tester to decide order of `a_node' and `b_node' according to comparator `a_comparator'.
		require
			a_node_attached: a_node /= Void
			b_node_attached: b_node /= Void
			a_comparator_attached: a_comparator /= Void
		do
			Result := a_comparator.less_than (a_node.data, b_node.data)
		end

feature{NONE} -- Implementation

	row_type: G
			-- Row anchor type

	level_starting_column_index_internal: like level_starting_column_index
			-- Implementation of `level_starting_column_index'

	levels_column_table_internal: like levels_column_table;
			-- Implementation of `levels_column_table'

note
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
