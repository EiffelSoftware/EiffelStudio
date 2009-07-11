note
	description: "Summary description for {TAG_TREE_GRID}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TAG_TREE_GRID [G -> TAG_ITEM]

inherit
	TAG_SPARSE_TREE [G]
		rename
			make as make_tree,
			make_default as make_default_tree
		redefine
			connect,
			disconnect,
			finish_update,
			on_node_remove
		end

	TAG_TREE_GRID_NODE_CONTAINER [G]
		rename
			node as grid_node
		redefine
			child_table
		end

	TAG_SHARED_EQUALITY_TESTER

create
	make, make_default

feature {NONE} -- Initialization

	make (a_filter: like filter; a_layout: like layout)
			-- Initialize `Current'
			--
			-- `a_filter': Filter determining `root_nodes'.
			-- `a_layout': Layout specifying items in grid.
		require
			an_updater_attached: a_filter /= Void
		do
			make_tree (a_filter)

			layout := a_layout

			create child_table.make_default
			child_table.set_key_equality_tester (equality_tester)
			create expanded_nodes.make
			create internal_selected_nodes.make_default
			create node_selected_actions
			create node_deselected_actions

			initialize
			set_disconnected
		end

	make_default
			-- Initialize `Current' with default `filter' and `layout'.
		do
			make (create {TAG_DEFAULT_FILTER [G]},
			      create {TAG_TREE_GRID_LAYOUT [G]}.make)
		end

	initialize
			-- Initialize `grid'.
		local
			l_grid: like grid
			l_widget: like widget
		do
			l_grid := create_grid
			grid := l_grid

				-- Operational
			l_grid.enable_tree
			l_grid.enable_partial_dynamic_content

				-- Events
			l_grid.row_select_actions.extend (agent on_select_row)
			l_grid.row_deselect_actions.extend (agent on_deselect_row)
			l_grid.row_expand_actions.extend (agent on_row_expand)
			l_grid.row_collapse_actions.extend (agent on_row_collapse)
			l_grid.set_dynamic_content_function (agent computed_grid_item)

				-- Appearance
			l_grid.hide_tree_node_connectors

			l_widget := create_widget
			l_widget.extend (l_grid)
			widget := l_widget
		end

	initialize_layout
			-- Initialize layout in `grid'
		local
			l_layout: like layout
			l_grid: like grid
			i, l_count: INTEGER
			l_header: BOOLEAN
			l_column: EV_GRID_COLUMN
		do
			l_layout := layout
			l_grid := grid
			l_grid.wipe_out

			if l_layout.has_header then
				l_grid.show_header
				l_header := True
			else
				l_grid.hide_header
			end
			l_count := l_layout.column_count
			l_grid.set_column_count_to (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_column := l_grid.column (i)
				l_layout.populate_header_item (l_column.header_item, Current)
				l_column.set_width (l_layout.column_width (i))
				i := i + 1
			end
		end

feature -- Access

	widget: EV_BOX
			-- Widget containing grid

	selected_nodes: DS_HASH_SET [like common_parent]
			-- Nodes for which row is selected
		do
			Result := internal_selected_nodes.twin
		end

feature {NONE} -- Access

	grid: EV_GRID
			-- Grid visualizing tree nodes through rows

	layout: TAG_TREE_GRID_LAYOUT [G]
			-- Layout specifying items in `grid'

	computed_grid_item (a_col_index, a_row_index: INTEGER): detachable EV_GRID_ITEM
			-- Computed grid item at given location
			--
			-- `a_col_index': Column index of requested item.
			-- `a_row_index': Row index of requested item.
			-- `Result': Newly computed grid item for column and row index.
		local
			l_row: EV_GRID_ROW
		do
			l_row := grid.row (a_row_index)
			if attached {TAG_TREE_GRID_ROW_DATA [G]} l_row.data as l_data then
				Result := layout.new_item (a_col_index, Current, l_data.node)
			end
		end

	expanded_nodes: DS_LINKED_LIST [like common_parent]
			-- List containing nodes for which the row is expanded

	internal_selected_nodes: DS_HASH_SET [like common_parent]
			-- Set of nodes which are currently selected in `grid'

	sparse_tree: TAG_TREE_GRID [G]
			-- <Precursor>
		do
			Result := Current
		end

	grid_node: TAG_TREE_NODE [G]
			-- Node which `Current' represents.
		do
			if hide_outside_nodes then
				Result := common_parent
				if not Result.is_root then
					Result := Result.parent
				end
			else
				Result := tree.root_node
			end
		end

	child_of_node (a_node: like common_parent): detachable TAG_TREE_GRID_NODE_CONTAINER [G]
			-- Row in `grid' representing node.
			--
			-- `a_node': Node for which child should be returned.
			-- `Result': Child pointing to row which currently displays `a_node', Void if path to row has
			--           not been evaluated or `a_node' was not added yet.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
			a_node_has_row: is_node_in_grid (a_node)
		local
			l_formatter: TAG_FORMATTER
			l_root_tag, l_node_tag: STRING
			l_token, l_suffix: STRING
		do
			l_formatter := tree.formatter
			l_root_tag := grid_node.tag
			l_node_tag := a_node.tag
			check root_is_prefix: l_formatter.is_prefix (l_root_tag, l_node_tag) end
			from
				l_suffix := l_formatter.suffix (l_root_tag, l_node_tag)
				Result := Current
			until
				l_suffix.is_empty or Result = Void
			loop
				if Result.is_evaluated then
					l_token := l_formatter.first_token (l_suffix)
					if Result.has_child_with_token (l_token) then
						Result := Result.child_with_token (l_token)
						l_suffix := l_formatter.suffix (l_token, l_suffix)
					else
						Result := Void
					end
				else
					Result := Void
				end
			end
		ensure
			result_valid: attached Result implies Result.node = a_node
		end

	child_table: DS_HASH_TABLE [like new_child, READABLE_STRING_GENERAL]
			-- <Precursor>

	new_row_start_index: INTEGER
			-- <Precursor>
		do
			Result := 1
		end

	timer: detachable EV_TIMEOUT
			-- Timer for redrawing items in `grid'

feature -- Status report

	hide_outside_nodes: BOOLEAN
			-- Are nodes for which `is_inside_node' and `is_parent_node' returns False shown in grid?

feature -- Status setting

	connect (a_tree: like tree)
			-- <Precursor>
		do
			initialize_layout
			Precursor (a_tree)
		end

	disconnect
			-- <Precursor>
		do
			child_table.wipe_out
					-- TODO: uncomment following line (commented for testing reasons)
			--expanded_nodes.wipe_out
			set_disconnected
			Precursor
		end

	set_hide_outside_nodes (a_hide_outside_nodes: like hide_outside_nodes)
			-- Set `hide_outside_nodes'.
		require
			not_connected: not is_connected
		do
			hide_outside_nodes := a_hide_outside_nodes
		ensure
			hide_outside_nodes_set: hide_outside_nodes = a_hide_outside_nodes
		end

	set_update_timer (an_interval: INTEGER_32)
			-- Define interval (in seconds) on how often the visible items in `grid' should be updated.
			--
			-- Note: An internal of 0 disables the update.
		local
			l_timer: like timer
		do
			if attached timer as l_t then
				l_timer := l_t
				l_timer.set_interval (0)
			else
				create l_timer
			end
			l_timer.actions.extend (agent on_timer_elapse)
			l_timer.set_interval (an_interval * 1_000)
			timer := l_timer
		end

feature {TAG_SPARSE_TREE_FILTER} -- Status setting

	finish_update
			-- <Precursor>
		local
			l_shown: BOOLEAN
			l_parent: detachable like common_parent
			l_child: like child_of_node
		do
			if attached last_modified_node as l_node then
				l_shown := is_node_in_grid (l_node)
				if has_common_parent_changed or l_node = grid_node then
					l_child := Current
				elseif not l_node.is_root then
					l_parent := l_node.parent
					if is_node_in_grid (l_parent) then
						l_child := child_of_node (l_parent)
					end
				end
				if attached l_child and then l_child.is_evaluated then
					if attached l_parent then
							-- Check if it sufficient to simply add/remove `l_node'
						if l_shown then
							if not l_child.has_child_with_token (l_node.token) then
								l_child.add_child (l_node)
								l_child := Void
							else
								l_child := l_child.child_with_token (l_node.token)
							end
						else
							if l_child.has_child_with_token (l_node.token) then
								l_child.remove_child (l_node)
							end
							l_child := Void
						end
					end

					if attached l_child and then l_child.is_evaluated then
						l_child.rebuild
					end
				end
			end

			Precursor
		end

feature {NONE} -- Status setting

	set_disconnected
		do
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			grid.insert_new_row (1)
			grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("Disconnected"))
		end

feature {TAG_TREE_GRID_NODE_CONTAINER} -- Query

	is_node_in_grid (a_node: like common_parent): BOOLEAN
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		local
			l_root: like grid_node
		do
			if a_node /= removed_node then
				if hide_outside_nodes then
					if is_inside_node (a_node) then
						Result := True
					elseif is_parent_node (a_node) then
						l_root := grid_node
						Result := l_root = a_node or l_root.is_parent_of (a_node)
					end
				else
					Result := True
				end
			end
		end

	is_node_expanded (a_node: like common_parent): BOOLEAN
			-- Should row for given node be expanded?
			--
			-- `a_node': A node.
			-- `Result': True if row displaying `a_node' should be shown expanded, False otherwise.
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			a_node_active: a_node.is_active
			a_node_valid: a_node.tree = tree
		do
			Result := expanded_nodes.has (a_node)
		end


feature {NONE} -- Query

	is_valid_index (a_pos: INTEGER): BOOLEAN
		do
			if a_pos > 0 and a_pos <= grid.row_count + 1 then
				Result := a_pos <= grid.row_count implies grid.row (a_pos).parent_row = Void
			end
		end

feature -- Events

	node_selected_actions: ACTION_SEQUENCE [TUPLE [like common_parent]]
			-- Events called when a item is selected in `widget'

	node_deselected_actions: ACTION_SEQUENCE [TUPLE [like common_parent]]
			-- Events called when an item is deselected in `widget'

feature {NONE} -- Events

	on_select_row (a_row: EV_GRID_ROW)
			-- Called when row is selected.
		do
			if attached {like new_child} a_row.data as l_data then
				internal_selected_nodes.force (l_data.node)
				node_selected_actions.call ([l_data.node])
			end
		end

	on_deselect_row (a_row: EV_GRID_ROW)
			-- Called when row is deselected.
		do
			if attached {like new_child} a_row.data as l_data then
				internal_selected_nodes.remove (l_data.node)
				node_deselected_actions.call ([l_data.node])
			end
		end

	on_row_expand (a_row: EV_GRID_ROW)
			-- Evaluate row if it has not been done yet and add node to `expanded_nodes'.
		local
			l_nodes: like expanded_nodes
		do
			if attached {like new_child} a_row.data as l_child then
				if not l_child.is_evaluated then
					l_child.evaluate
				end
				l_nodes := expanded_nodes
				l_nodes.delete (l_child.node)
				if l_nodes.count = max_expanded_nodes_count then
					l_nodes.remove_last
				end
				l_nodes.force_first (l_child.node)
			end
		end

	on_row_collapse (a_row: EV_GRID_ROW)
		do
			if attached {like new_child} a_row.data as l_child then
				expanded_nodes.delete (l_child.node)
			end
		end

	on_node_remove (a_tree: TAG_TREE [G]; a_node: TAG_TREE_NODE [G])
			-- <Precursor>
		local
			l_cursor: DS_LINKED_LIST_CURSOR [like common_parent]
			l_current: like common_parent
		do
			from
				l_cursor := expanded_nodes.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_current := l_cursor.item
				if a_node = l_current or a_node.is_parent_of (l_current) then
					l_cursor.remove
				else
					l_cursor.forth
				end
			end
			Precursor (a_tree, a_node)
		end

	on_timer_elapse
			-- Called when timer reached timeout.
		local
			l_timer: like timer
			l_interval: INTEGER
		do
			redraw_items
			l_timer := timer
			check timer_attached: l_timer /= Void end
			l_interval := l_timer.interval
			l_timer.set_interval (0)
			l_timer.set_interval (l_interval)
		end

feature {NONE} -- Implementation

	insert_new_row (a_pos: INTEGER)
			-- <Precursor>
		do
			grid.insert_new_row (a_pos)
		end

	redraw_items
			-- Redraw all visible items in `grid'
		local
			l_list: ARRAYED_LIST [INTEGER]
			l_row: EV_GRID_ROW
			l_selected: BOOLEAN
		do
			if grid.is_displayed then
				from
					l_list := grid.visible_row_indexes
					l_list.start
				until
					l_list.after
				loop
					l_row := grid.row (l_list.item_for_iteration)
					l_selected := l_row.is_selected
					l_row.clear
					l_row.redraw
					if l_selected then
						l_row.enable_select
					end
					l_list.forth
				end
			end
		end

feature {NONE} -- Factory

	create_grid: like grid
			-- Create new grid.
		do
			create Result
			Result.enable_tree
		end

	create_widget: like widget
			-- Create new widget.
		do
			create {EV_VERTICAL_BOX} Result
		end

feature {NONE} -- Constants

	max_expanded_nodes_count: INTEGER = 40
			-- Maximum number of expanded nodes being stored

invariant
	grid_attached: grid /= Void
	grid_is_tree: grid.is_tree_enabled
	child_table_attached: child_table /= Void

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
