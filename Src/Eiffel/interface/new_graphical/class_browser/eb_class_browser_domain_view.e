indexing
	description: "Class browser viewer to display result of a query language domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_DOMAIN_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
		redefine
			data,
			update,
			internal_recycle
		end

	EB_CONSTANTS
		undefine
			is_equal,
			copy,
			default_create
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER
		undefine
			is_equal,
			copy,
			default_create
		end

	QL_SHARED_NAMES
		undefine
			is_equal,
			copy,
			default_create
		end

	EB_STONE_UTILITY
		undefine
			is_equal,
			copy,
			default_create
		end

	SHARED_BENCH_NAMES
		undefine
			is_equal,
			copy,
			default_create
		end

create
	make

feature -- Access

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Widget of a control bar through which, certain control can be performed upon current view
			-- Every view can provide a customized control bar. Normally a tool bar is placed in this area
			-- through which behavior (such as tooltip display) of current view can be changed.
		do
		end

	data: QL_DOMAIN
			-- Data

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip be displayed?
		do
		end

	should_headers_be_shown: BOOLEAN
			-- Should headers of `grid' be shown?

feature{NONE} -- Actions

	on_expand_all_level is
			-- Action to be performed to recursively expand all selected rows.
		do
		end

	on_collapse_all_level is
			-- Action to be performed to recursively collapse all selected rows.
		do
		end

	on_expand_one_level is
			-- Action to be performed to expand all selected rows.
		do
		end

	on_collapse_one_level is
			-- Action to be performed to collapse all selected rows.
		do
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when `a_key' is pressed
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
		end

feature -- Refresh

	refresh is
			-- Refresh.
		do
			fill_rows
		end

	update (a_observable: QL_OBSERVABLE; a_data: ANY) is
			-- Notification from `a_observable' indicating that `a_data' changed.
		require else
			a_observable_can_be_void: a_observable = Void
		do
			data ?= a_data
			if data = Void then
				value ?= a_data
			end
			is_up_to_date := False
			set_should_headers_be_shown (data /= Void or else value /= Void)
			if data = Void and then value = Void then
				create {QL_CLASS_DOMAIN}data.make
			end
			update_view
		end

feature -- Setting

	set_should_headers_be_shown (b: BOOLEAN) is
			-- Set `should_headers_be_shown' with `b'.
		do
			should_headers_be_shown := b
		ensure
			should_headers_be_shown_set: should_headers_be_shown = b
		end

feature{NONE} -- Implementation/Data

	item_to_put_in_editor: EV_GRID_ITEM is
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		do
			Result := item_to_put_in_editor_for_single_item_grid
		end

	domain: DS_LINKED_LIST [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			-- Domain to be displayed in Current

	editor_token_grid_support: EB_EDITOR_TOKEN_GRID_SUPPORT
			-- Supports editor token grid

	item_function (x, y: INTEGER): EV_GRID_ITEM is
			-- Grid item at position (`x', `y').
		require
			x_positive: x > 0 and x <= content.count
			y_positive: y > 0
		do
			if domain /= Void then
				if y <= domain.count then
					Result := content.i_th (x).item (y)
					if Result = Void then
						read_content (y)
						Result := content.i_th (x).item (y)
					end
				end
			end
		end

	row_background_color (y: INTEGER): EV_COLOR is
			-- Background color for items in row indexed by `y'
		local
			l_last_item: EB_GRID_QL_ITEM
			l_current_item: EB_GRID_QL_ITEM
			l_last_sorted_column: INTEGER
		do
			l_last_sorted_column := last_sorted_column
			if l_last_sorted_column = 0 then
					-- If no sort has been applied
				Result := grid.background_color
			else
					-- If sort has been applied.
				if y = 1 then
					Result := odd_row_background_color
				else
					check y > 1 end
					l_last_item ?= content.i_th (l_last_sorted_column).item (y - 1)
					l_current_item ?= content.i_th (l_last_sorted_column).item (y)
					if l_last_item = Void then
						Result := odd_row_background_color
					elseif l_current_item = Void then
						Result := l_last_item.background_color
						if Result = Void then
							Result := odd_row_background_color
						end
					else
						if l_last_item.image.is_equal (l_current_item.image) then
							Result := l_last_item.background_color
						else
								-- Alternate row background here.
							Result := next_row_background_color (l_last_item.background_color)
						end
					end
				end
			end
		ensure
			result_attached: Result /= Void
		end

	next_row_background_color (a_color: EV_COLOR): EV_COLOR is
			-- Alternative row background color according to `a_color'
		local
			l_odd_color: like odd_row_background_color
		do
			l_odd_color := odd_row_background_color
			if a_color = Void then
				Result := l_odd_color
			else
				if a_color.is_equal (l_odd_color) then
					Result := even_row_background_color
				else
					Result := l_odd_color
				end
			end
		ensure
			result_attached: Result /= Void
		end

	content: ARRAYED_LIST [HASH_TABLE [EV_GRID_ITEM, INTEGER]]
			-- Content of `domain'
			-- Key of the inner hash table is row index, value is the grid item.

	read_content (y: INTEGER) is
			-- Generate grid item from `domain'. `y' is the starting row.
			-- `cache_row_count' items will be generated every time.
		require
			domain_attached: domain /= Void
			y_valid: y > 0 and y <= domain.count
		local
			i, j: INTEGER
			l_content: DS_LIST [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			l_tbl: HASH_TABLE [EV_GRID_ITEM, INTEGER]
		do
			from
				i := y
				j := (i + cache_row_count).min (domain.count)
				l_tbl := content.i_th (1)
				l_content := domain
				l_content.go_i_th (i)
			until
				i > j
			loop
				if not l_tbl.has (i) then
					generate_grid_item (i, l_content.item_for_iteration)
				end
				l_content.forth
				i := i + 1
			end
		end

	cache_row_count: INTEGER is 50
			-- Cache row count

	domain_type_name (a_domain: QL_DOMAIN): STRING_GENERAL is
			-- Type name of `a_domain'
		require
			a_domain_attached: a_domain /= Void
		do
			if a_domain.is_target_domain then
				Result := metric_names.l_target_unit
			elseif a_domain.is_group_domain then
				Result := metric_names.l_group_unit
			elseif a_domain.is_class_domain then
				Result := metric_names.l_class_unit
			elseif a_domain.is_generic_domain then
				Result := metric_names.l_generic_unit
			elseif a_domain.is_feature_domain then
				Result := metric_names.l_feature_unit
			elseif a_domain.is_argument_domain then
				Result := metric_names.l_argument_unit
			elseif a_domain.is_local_domain then
				Result := metric_names.l_local_unit
			elseif a_domain.is_assertion_domain then
				Result := metric_names.l_assertion_unit
			elseif a_domain.is_line_domain then
				Result := metric_names.l_line_unit
			elseif a_domain.is_quantity_domain then
				Result := ""
			end
		ensure
			good_result: Result /= Void and then not Result.is_empty
		end

	odd_row_background_color: EV_COLOR is
			-- Background color for odd rows
		do
			Result := preferences.class_browser_data.odd_row_background_color
		ensure
			result_attached: Result /= Void
		end

	even_row_background_color: EV_COLOR is
			-- Background color for even rows
		do
			Result := preferences.class_browser_data.even_row_background_color
		ensure
			result_attached: Result /= Void
		end

	dynamic_grid_item_function (a_column, a_row: INTEGER): EV_GRID_ITEM is
			-- Grid item at position (`a_column', `a_row')
		do
			Result := grid.item (a_column, a_row)
			if Result = Void then
				Result := item_function (a_column, a_row)
			end
		end

	invisible_items: DS_LINKED_LIST [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			-- List of invisible result rows

	last_comparator: AGENT_LIST_COMPARATOR [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			-- Last comparator

feature{NONE} -- Implementation

	provide_result is
			-- Provide result displayed in Current view.
		do
			set_all_path_retrieved (False)
			content.i_th (1).wipe_out
			content.i_th (2).wipe_out
			bind_grid
			if is_column_sortable (last_sorted_column) then
				disable_auto_sort_order_change
				enable_force_multi_column_sorting
				sort (0, 0, 1, 0, 0, 0, 0, 0, last_sorted_column)
				disable_force_multi_column_sorting
				enable_auto_sort_order_change
			else
				fill_rows
			end
		end

	fill_rows is
			-- Fill rows with `data'.
		do
			content.i_th (1).wipe_out
			content.i_th (2).wipe_out
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			if domain /= Void then
				grid.set_row_count_to (domain.count)
			end
			grid.refresh_now
		end

	bind_grid is
			-- Bind grid.
		local
			l_content: LIST [QL_ITEM]
			l_domain: like domain
			a_domain: like data
			l_item: QL_ITEM
			l_empty_path: STRING_32
		do
			l_empty_path := ""
			grid.set_row_height (default_row_height)
			a_domain := data
			if a_domain /= Void then
				if should_headers_be_shown then
					grid.column (1).set_title (interface_names.first_character_as_upper (domain_type_name (a_domain)))
					grid.column (2).set_title (interface_names.l_location)
				else
					grid.column (1).set_title ("")
					grid.column (2).set_title ("")
				end
				create domain.make
				l_domain := domain
				from
					l_content := a_domain.content
					l_content.start
				until
					l_content.after
				loop
					l_item := l_content.item
					l_domain.force_last ([l_item, l_empty_path])
					l_content.forth
				end
			else
				grid.column (1).set_title ("")
				domain := Void
			end
			try_auto_resize_grid (<<[300, 500, 1]>>, False)
		end

	build_grid is
			-- Build `grid'.
		do
			create content.make (2)
			content.extend (create {HASH_TABLE [EV_GRID_ITEM, INTEGER]}.make (100))
			content.extend (create {HASH_TABLE [EV_GRID_ITEM, INTEGER]}.make (100))
			create invisible_items.make

				-- Setup sortable `grid'.
			create grid
			grid.enable_multiple_item_selection
			grid.enable_selection_on_single_button_click
			grid.set_column_count_to (2)
			grid.set_row_count_to (100)
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent item_function)
			grid.key_press_actions.extend (agent on_key_pressed)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end

				-- Setup `editor_token_grid_support'.
			create editor_token_grid_support.make_with_grid (grid)
			editor_token_grid_support.enable_grid_item_pnd_support
			editor_token_grid_support.color_or_font_change_actions.extend (agent on_color_or_font_changed)
			editor_token_grid_support.synchronize_color_or_font_change_with_editor
			editor_token_grid_support.synchronize_scroll_behavior_with_editor
			editor_token_grid_support.enable_ctrl_right_click_to_open_new_window

			set_grid_item_function (agent dynamic_grid_item_function)

				-- Setup copy & paste function.
			set_item_text_function (agent text_of_grid_item)
			set_select_all_action (agent select_all)
			enable_copy
			disable_use_fixed_fonts
		end

	build_sortable_and_searchable is
			-- Build sortable and searchable facilities
		local
			l_item_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			l_path_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
		do
			old_make (grid)
			create l_item_sort_info.make (agent item_order_tester, ascending_order)
			create l_path_sort_info.make (agent path_order_tester, ascending_order)
			l_item_sort_info.enable_auto_indicator
			l_path_sort_info.enable_auto_indicator

			set_sort_action (agent sort_agent)
			set_sort_info (1, l_item_sort_info)
			set_sort_info (2, l_path_sort_info)
			set_ensure_visible_action (agent ensure_item_visible)
			enable_auto_sort_order_change

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
			enable_direct_start_search
		end

	generate_grid_item (a_y: INTEGER; a_item: TUPLE [ql_item: QL_ITEM; item_path: STRING_32]) is
			-- Generate grid items for row `a_y' from `a_item'.
		require
			domain_attached: domain /= Void
			a_y_valid: a_y > 0 and a_y <= domain.count
			a_item_attached: a_item /= Void
		local
			l_item: EB_GRID_QL_ITEM
			l_path_item: EB_GRID_QL_ITEM
			l_row_background_color: EV_COLOR
			l_ql_item: QL_ITEM
			l_fixed_fonts: like label_font_table
			l_domain: like domain
			l_line_height: INTEGER
		do
			l_ql_item := a_item.ql_item
			create l_item.make (l_ql_item, 1, a_y, False)
			create l_path_item.make (l_ql_item, 2, a_y, True)
			l_domain := domain
			if l_domain.item (a_y).item_path.is_empty then
				l_domain.replace ([a_item.ql_item, l_path_item.image], a_y)
			end
			if is_fixed_fonts_used then
				l_fixed_fonts := label_font_table
				l_line_height := label_font_height
				l_item.set_overriden_fonts (l_fixed_fonts, l_line_height)
				l_path_item.set_overriden_fonts (l_fixed_fonts, l_line_height)
			end

			l_item.set_stone (stone_from_ql_item (l_ql_item))
			if l_ql_item.parent /= Void then
				l_path_item.set_stone (stone_from_ql_item (l_ql_item.parent))
			end

			content.i_th (1).force (l_item, a_y)
			content.i_th (2).force (l_path_item, a_y)

			l_row_background_color := row_background_color (a_y)
			l_item.set_background_color (l_row_background_color)
			l_path_item.set_background_color (l_row_background_color)
		end

	ensure_item_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure that `a_item' is visible.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		local
			l_grid_item: EB_GRID_QL_ITEM
			l_grid: like grid
		do
			l_grid_item ?= a_item.grid_item
			l_grid := grid

			if l_grid_item /= Void and then not l_grid_item.is_destroyed and then l_grid_item.is_parented then
			else
				l_grid_item ?= item_function (a_item.column_index, a_item.row_index)
				l_grid.set_item (a_item.column_index, a_item.row_index, l_grid_item)
			end
			if l_grid_item /= Void then
				l_grid.remove_selection
				l_grid_item.ensure_visible
				if a_selected then
					l_grid_item.row.enable_select
				end
			end
		end

	select_all is
			-- Action to be performed to select all items in `grid'					
		do
			select_all_in_dynamic_grid (grid, agent item_function, Void)
		end

feature{NONE} -- Implementation/Sorting

	all_path_retrieved: BOOLEAN
			-- Have all path information for `domain' been retrieved?

	set_all_path_retrieved (b: BOOLEAN) is
			-- Set `all_path_retrieved' with `b'.
		do
			all_path_retrieved := b
		ensure
			all_path_retrieved_set: all_path_retrieved = b
		end

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]) is
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
		local
			l_tbl: HASH_TABLE [EV_GRID_ITEM, INTEGER]
			l_index, l_count: INTEGER
			l_domain: like domain
			l_printer: EB_QUERY_LANGUAGE_PRINTER_VISITOR
			l_output: EB_QUERY_LANGUAGE_TEXT_OUTPUT
			l_item: TUPLE [ql_item: QL_ITEM; item_path: STRING_32]
		do
			if not all_path_retrieved then
					-- Retrieve all missing path information.
				l_domain := domain
				if l_domain /= Void and then not l_domain.is_empty then
					l_tbl := content.i_th (2)
					from
						l_index := 1
						l_count := l_domain.count
						l_domain.start

						create l_printer.make
						create l_output.make
						l_printer.set_output (l_output)
						l_printer.set_is_folder_displayed (True)
					until
						l_index > l_count
					loop
						if not l_tbl.has (l_index) then
							l_item := l_domain.item_for_iteration
							l_printer.wipe_out_output
							l_printer.process_path (l_item.ql_item, False, True, True, False)
							l_domain.replace_at ([l_item.ql_item, l_output.last_output])
						end
						l_domain.forth
						l_index := l_index + 1
					end
				end
				set_all_path_retrieved (True)
			end
			last_comparator := a_comparator
			sort_domain (a_comparator)
			fill_rows
		end

	sort_domain (a_comparator: AGENT_LIST_COMPARATOR [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]) is
			-- Sort `domain' using `a_comparator'.
		require
			a_comparator_attached: a_comparator /= Void
		local
			l_sorter: DS_QUICK_SORTER [TUPLE [ql_item: QL_ITEM; item_path: STRING_32]]
			l_domain: like domain
		do
			l_domain := domain
			if l_domain /= Void then
				create l_sorter.make (a_comparator)
				l_sorter.sort (l_domain)
			end
		end

	item_order_tester (a_item, b_item: TUPLE [ql_item: QL_ITEM; item_path: STRING_32]; a_order: INTEGER): BOOLEAN
			-- Order tester for `a_item' and `b_item' using item name
		require
			a_item_attached: a_item /= Void
			b_item_attached: b_item /= Void
		do
			if a_order = ascending_order then
				Result := a_item.ql_item.name < b_item.ql_item.name
			else
				Result := a_item.ql_item.name > b_item.ql_item.name
			end
		end

	path_order_tester (a_item, b_item: TUPLE [ql_item: QL_ITEM; item_path: STRING_32]; a_order: INTEGER): BOOLEAN
			-- Order tester for `a_item' and `b_item' using item path
		require
			a_item_attached: a_item /= Void
			b_item_attached: b_item /= Void
		do
			if a_order = ascending_order then
				Result := a_item.item_path < b_item.item_path
			else
				Result := a_item.item_path > b_item.item_path
			end
		end

feature{NONE} -- Recycle

	internal_recycle is
			-- Recycle.
		do
			Precursor
			editor_token_grid_support.desynchronize_color_or_font_change_with_editor
			editor_token_grid_support.desynchronize_scroll_behavior_with_editor
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

