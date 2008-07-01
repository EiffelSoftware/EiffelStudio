indexing
	description: "Object that represents a dependency row in dependency view"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_DEPENDENCY_ROW

inherit
	EB_CLASS_BROWSER_GRID_ROW
		redefine
			browser
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		end

	EB_SHARED_EDITOR_TOKEN_UTILITY

	QL_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_item: like item; a_row_node: like row_node; a_row_type: INTEGER; a_browser: EB_CLASS_BROWSER_DEPENDENCY_VIEW) is
			-- Initialize `item' with `a_item', `row_node' with `a_row_node', `row_type' with `a_row_type'  and `browser' with `a_browser'.
		require
			a_row_type_valid: is_row_type_valid (a_row_type)
			a_item_valid: a_item /= Void
			a_row_node_valid: a_row_node /= Void
			a_browser_attached: a_browser /= Void
		do
			set_item (a_item)
			set_row_node (a_row_node)
			set_row_type (a_row_type)
			set_browser (a_browser)
			set_should_current_row_be_displayed (True)
			create grid_item_internal
			create image.make (20)
			create {LINKED_LIST [EDITOR_TOKEN]}base_text.make
			generate_base_text_and_image
		end

feature -- Access

	item: QL_ITEM
			-- Item to be displayed in current row

	row_node: EB_TREE_NODE [EB_CLASS_BROWSER_DEPENDENCY_ROW]
			-- Row node where current belongs

	base_text: LIST [EDITOR_TOKEN]
			-- Base text of Current row

	image: STRING_32
			-- Image of current row used in grid search

	grid_item: EB_GRID_EDITOR_TOKEN_ITEM is
			-- Grid item to be displayed
		local
			l_text: LIST [EDITOR_TOKEN]
		do
			if not is_up_to_date then
				set_is_up_to_date (True)
				l_text := base_text.twin
				l_text.append (number_tokens)
				grid_item_internal.set_text_with_tokens (l_text)
			end
			Result := grid_item_internal
		ensure
			result_attached: Result /= Void
		end

	feature_list: DS_LIST [QL_FEATURE]
			-- Feature list to be displayed in another column

	row_type: INTEGER
			-- Type of current row
			-- Row type indicates

	row_count: INTEGER
			-- Row count which should be displayed after row text

	browser: EB_CLASS_BROWSER_DEPENDENCY_VIEW
			-- Browser in which Current row is displayed

feature -- Status report

	should_path_be_displayed: BOOLEAN is
			-- Should path of `item' be displayed?
		do
			Result := item.is_group
		end

	is_expanded: BOOLEAN
			-- Is current row expanded?

	has_been_expanded: BOOLEAN
			-- Has current row been expanded?

	is_lazy_expandable: BOOLEAN is
			-- Is current row able for lazy expandable?
			-- Used to indicate that subrows of current row is to be inserted later when
			-- current row is expanded for the first time because the retrieval of the subrows are
			-- time consuming.
		do
			Result := row_type = referencer_class_row_type
		end

	should_current_row_be_displayed: BOOLEAN
			-- Should current row be displayed?
			-- Default: True

	is_row_type_valid (a_row_type: INTEGER): BOOLEAN is
			-- Is `a_row_type' a valid row type?
		do
			Result := a_row_type = group_row_type or else
					  a_row_type = folder_row_type or else
					  a_row_type = referencer_class_row_type or else
					  a_row_type = referenced_class_row_type or else
					  a_row_type = feature_row_type
		end

feature -- Constants

	group_row_type: INTEGER is 1
	folder_row_type: INTEGER is 2
	referenced_class_row_type: INTEGER is 3
	referencer_class_row_type: INTEGER is 4
	feature_row_type: INTEGER is 5
			-- Different row types

feature -- Setting

	set_item (a_item: like item) is
			-- Set `item' with `a_item'.
		do
			item := a_item
		ensure
			item_set: item = a_item
		end

	set_row_node (a_row_node: like row_node) is
			-- Set `row_node' with `a_row_node'.
		do
			row_node := a_row_node
		ensure
			row_node_set: row_node = a_row_node
		end

	set_is_expanded (a_expanded: BOOLEAN) is
			-- Set `is_expanded' with `a_expanded'.
		do
			is_expanded := a_expanded
			if not has_been_expanded and then a_expanded then
				has_been_expanded := True
			end
		ensure
			is_expanded_set: is_expanded = a_expanded
		end

	set_feature_list (a_feature_list: like feature_list) is
			-- Set `feature_list' with `a_feature_list'.
		require
			current_is_feature_row: row_type = feature_row_type
		do
			feature_list := a_feature_list
		ensure
			feature_list_set: feature_list = a_feature_list
		end

	set_should_current_row_be_displayed (b: BOOLEAN) is
			-- Set `should_current_row_be_dispalyed' with `b'.
		do
			should_current_row_be_displayed := b
		ensure
			should_current_row_be_displayed_set: should_current_row_be_displayed = b
		end

	set_row_type (a_row_type: INTEGER) is
			-- Set `row_type' with `a_row_type'.
		require
			a_row_type_valid: is_row_type_valid (a_row_type)
		do
			row_type := a_row_type
		ensure
			row_type_set: row_type = a_row_type
		end

feature -- Grid binding

	bind_row (a_row: EV_GRID_ROW; a_column: INTEGER) is
			-- Bind current in `a_row' at `a_column'.
		require
			a_row_attached: a_row /= Void
			a_column_valid: a_column > 0
		do
			a_row.clear
			a_row.set_data (Current)
			a_row.set_item (a_column, grid_item)
				-- Bind rows related to callers/callees.
			if feature_list /= Void then
				bind_feature_list_rows (a_row, a_column + 1)
			end
			set_grid_row (a_row)
		end

	bind_feature_list_rows (a_parent_row: EV_GRID_ROW; a_column: INTEGER) is
			-- Bind callers/callees rows as subrows of `a_parent_row'.
			-- Binded rows will start their first item at `a_column'-th column.
		require
			a_parent_row_attached: a_parent_row /= Void
			a_column_positive: a_column > 0
			feature_list_valid: feature_list /= Void and then not feature_list.is_empty
		local
			l_cursor: DS_LIST_CURSOR  [QL_FEATURE]
			l_style: like feature_name_style
			l_grid_row: EV_GRID_ROW
			l_row_index: INTEGER
			l_row: EB_CLASS_BROWSER_CALLER_CALLEE_ROW
			l_for_caller: BOOLEAN
			l_feature: QL_FEATURE
		do
			l_for_caller := browser.is_displaying_clients
			l_style := feature_name_style
			l_cursor := feature_list.new_cursor
			a_parent_row.insert_subrows (feature_list.count, 1)
			check item.is_feature end
			l_feature ?= item

			from
				l_cursor.start
				l_row_index := 1
			until
				l_cursor.after
			loop
				l_grid_row := a_parent_row.subrow (l_row_index)
				create l_row.make (browser, l_cursor.item, l_feature, {EB_CLASS_BROWSER_CALLER_CALLEE_ROW}.feature_name_row, l_for_caller)
				l_row.bind_row (l_grid_row, a_column, True)
				l_cursor.forth
				l_row_index := l_row_index + 1
			end
		end

	refresh_row is
			-- Refresh current row.
		require
			is_binded: is_binded_to_grid
		local
			l_column: INTEGER
		do
			l_column := grid_item.column.index
			bind_row (grid_row, l_column)
		end

	set_row_count (a_row_count: INTEGER) is
			-- Set `row_count' with `a_row_count'.
		do
			if row_count /= a_row_count then
				set_is_up_to_date (False)
				row_count := a_row_count
			end
		ensure
			row_count_set: row_count = a_row_count
			is_up_to_date_set: ((a_row_count /= old row_count) implies not is_up_to_date) and then
							   ((a_row_count = old row_count) implies (is_up_to_date = old is_up_to_date))
		end

feature{NONE} -- Implementation

	class_style: EB_CLASS_EDITOR_TOKEN_STYLE is
			-- Style to generate text for class
		once
			create Result
			Result.enable_just_name
		ensure
			result_attached: Result /= Void
		end

	feature_style: EB_FEATURE_EDITOR_TOKEN_STYLE is
			-- Feature style
		once
			create Result
			Result.disable_class
			Result.disable_comment
			Result.disable_return_type
			Result.disable_value_for_constant
			Result.disable_use_overload_name
			Result.disable_argument
		ensure
			result_attached: Result /= Void
		end

	grid_item_internal: like grid_item
			-- Implementation of `grid_item'.

	item_path_style: EB_PATH_EDITOR_TOKEN_STYLE is
			-- Path style
		once
			create Result
			Result.disable_target
			Result.enable_indirect_parent
			Result.enable_parent
			Result.enable_self
			Result.token_output.set_class_style (class_style)
			Result.token_output.set_feature_style (feature_style)
		ensure
			result_attached: Result /= Void
		end

	path_grid_item_text (a_class: QL_CLASS; a_allow_empty: BOOLEAN; a_stop_on_target: BOOLEAN; a_force_complete: BOOLEAN): LIST [EDITOR_TOKEN] is
			-- Editor token representations of path of `a_class' used in grid item.
			-- If `a_class' is used in cluster, display "folder.folder.folder"
			-- If `a_class' is used in library, display "cluster.cluster.folder.folder.folder"
			-- If `a_allow_empty' is True, folder part of the part can be empty, otherwise at least "." is displayed as folder part.
			-- If `a_stop_on_target' is True, stope path searching when we meet a target.
			-- If `a_force_complete' is True, always find group/cluster part of path instead of only folder part.
		require
			a_class_attached: a_class /= Void
		local
			l_path_style: like class_path_style
			l_dot: EDITOR_TOKEN_TEXT
			l_path: LIST [EDITOR_TOKEN]
		do
			create {LINKED_LIST [EDITOR_TOKEN]} Result.make
			l_path_style := class_path_style
			l_path_style.set_item (a_class)
			l_path := l_path_style.text

			if a_class.conf_class.group.is_used_in_library then
				if l_path.count > 2 then
					l_path.start
					l_path.remove
					l_path.remove
				end
			else
				if l_path.count = 1 then
					l_path.wipe_out
				end
			end
			Result.append (l_path)

			if Result.is_empty then
				create l_dot.make (".")
				l_dot.set_pebble (create {CLUSTER_STONE}.make (a_class.conf_class.group))
				Result.extend (l_dot)
			end
		ensure
			result_attached: Result /= Void
		end

	path_tooltip_text (a_class: QL_CLASS): LIST [EDITOR_TOKEN] is
			-- Tooltip to display path of `a_class'.
		require
			a_class_attached: a_class /= Void
		local
			l_style: like full_class_path_style
		do
			l_style := full_class_path_style
			l_style.set_item (a_class)
			create {LINKED_LIST [EDITOR_TOKEN]} Result.make
			Result.append (l_style.text)
		end

	full_class_path_style: EB_PATH_EDITOR_TOKEN_STYLE is
			-- Full class path style including (group, folder, class)
		once
			create Result
			Result.disable_self
			Result.enable_parent
			Result.enable_indirect_parent
			Result.disable_target
			Result.set_is_folder_displayed (True)
		ensure
			result_attached: Result /= Void
		end

	class_path_style: EB_PATH_EDITOR_TOKEN_STYLE is
			-- Path style
		once
			create Result
			Result.enable_self
			Result.enable_parent
			Result.enable_indirect_parent
			Result.disable_target
			Result.set_is_folder_displayed (True)
			Result.set_is_class_displayed (False)
		ensure
			result_attached: Result /= Void
		end

	number_tokens: LIST [EDITOR_TOKEN] is
			-- Editor tokens representing a children number of `row_node'
		local
			l_str: STRING
			l_count: INTEGER
			l_writer: like token_writer
		do
			create l_str.make (8)
			l_count := row_count
			if l_count > 0 then
				l_writer := token_writer
				l_writer.new_line
				l_writer.add (ti_space)
				l_writer.add (ti_l_parenthesis)
				l_writer.process_number_text (l_count.out)
				l_writer.add (ti_r_parenthesis)
				Result := l_writer.last_line.content
			else
				create {LINKED_LIST [EDITOR_TOKEN]} Result.make
			end
		ensure
			result_attached: Result /= Void
		end

	generate_base_text_and_image is
			-- Generate `base_text' and `image'.
		local
			l_path_style: like item_path_style
			l_class: QL_CLASS
			l_text: like base_text
			l_image: STRING_32
			l_tooltip: EB_EDITOR_TOKEN_TOOLTIP
			l_grid_item_internal: like grid_item_internal
		do
			l_grid_item_internal := grid_item_internal
			inspect
				row_type
			when folder_row_type then
						-- For folder row
				l_class ?= item
				check l_class /= Void end
				base_text.append (path_grid_item_text (l_class, False, True, False))
				l_grid_item_internal.set_pixmap (pixmap_from_group_path (l_class.class_c.group, l_class.class_i.path))
			else
					-- For rows other than folder row
				l_path_style := item_path_style
				if should_path_be_displayed then
					l_path_style.enable_indirect_parent
					l_path_style.enable_parent
				else
					l_path_style.disable_indirect_parent
					l_path_style.disable_parent
				end
				if item.is_invariant_feature then
					l_path_style.token_output.set_feature_style (feature_with_written_class_style)
				elseif item.is_real_feature then
					l_path_style.token_output.set_feature_style (feature_name_style)
				end
				l_path_style.set_item (item)
				l_path_style.set_is_folder_displayed (False)
				base_text.append (l_path_style.text)
				grid_item_internal.set_pixmap (pixmap_for_query_lanaguage_item (item))

						-- For referencer class row, we setup a tooltip to display path of that class.
				if row_type = referencer_class_row_type then
					l_class ?= item
					check l_class /= Void end
					l_tooltip := new_general_tooltip (l_grid_item_internal, agent: BOOLEAN do Result := browser.should_tooltip_be_displayed end)
					l_tooltip.before_display_actions.extend (agent setup_general_tooltip (agent path_tooltip_text (l_class), l_tooltip))
					l_grid_item_internal.set_general_tooltip (l_tooltip)
				end
			end

				-- Setup image for grid search.
			from
				l_text := base_text
				l_image := image
				l_text.start
			until
				l_text.after
			loop
				l_image.append (l_text.item.wide_image)
				l_text.forth
			end
			l_grid_item_internal.set_image (l_image)
		end

	is_up_to_date: BOOLEAN
			-- Is status of Current row up-to-date?

	set_is_up_to_date (b: BOOLEAN) is
			-- Set `is_up_to_date' with `b'.
		do
			is_up_to_date := b
		ensure
			is_up_to_date_set: is_up_to_date = b
		end

feature{EB_CLASS_BROWSER_DEPENDENCY_VIEW} -- Stone

	set_grid_item_stone is
			-- Set stone for `item' into `grid_item'.
		local
			l_item: like item
			l_class: QL_CLASS
			l_feature: QL_REAL_FEATURE
			l_group: QL_GROUP
			l_stone: STONE
		do
			if row_type /= folder_row_type then
				l_item := item
				if l_item.is_class then
					l_class ?= l_item
					l_stone := class_stone (l_class.class_c)
				elseif l_item.is_real_feature then
					l_feature ?= l_item
					l_stone := feature_stone (l_feature.e_feature)
				elseif l_item.is_group then
					l_group ?= l_item
					l_stone := cluster_stone (l_group.group)
				end
				grid_item_internal.set_stone (l_stone)
			end
		end

	is_stone_set: BOOLEAN
			-- Is stone set into `grid_item'?

	set_is_stone_set (b: BOOLEAN) is
			-- Set `is_stone_set' with `b'.
		do
			is_stone_set := b
		ensure
			is_stone_set: is_stone_set = b
		end

invariant
	item_attached: item /= Void
	row_node_attached: row_node /= Void
	row_type_valid: is_row_type_valid (row_type)
	image_attached: image /= Void
	grid_item_internal_attached: grid_item_internal /= Void
	base_text_attached: base_text /= Void

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
