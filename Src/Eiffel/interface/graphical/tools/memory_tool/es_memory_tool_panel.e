indexing
	description: "[
		Tool descriptor for EiffelStudio's memory analyser tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_MEMORY_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_HORIZONTAL_SPLIT_AREA]
		redefine
			on_before_initialize,
			internal_recycle,
			create_right_tool_bar_items
		end

create {ES_MEMORY_TOOL}
	make

feature {NONE} -- Initialization

	on_before_initialize
			-- Use to perform additional creation initializations, before the UI has been created.
		do
			Precursor {ES_DOCKABLE_TOOL_PANEL}
		end

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: EV_HORIZONTAL_SPLIT_AREA) is
			-- Builds the tools user interface elements.
			-- Note: This function is called prior to showing the tool for the first time.
			--
			-- `a_widget': A widget to build the tool interface using.
		local
			l_col: EV_GRID_COLUMN
			l_box: EV_HORIZONTAL_BOX
		do
			create l_box

				-- Memory map grid
			create memory_map_grid
			memory_map_grid.set_column_count_to (3)
			l_col := memory_map_grid.column (object_column_index)
			l_col.set_title ("Object Type")

			l_col := memory_map_grid.column (count_column_index)
			l_col.set_title ("Count")
			l_col.set_width (80)

			l_col := memory_map_grid.column (delta_column_index)
			l_col.set_title ("Delta")
			l_col.set_width (50)

			memory_map_grid.enable_tree
			memory_map_grid.enable_auto_size_best_fit_column (object_column_index)
			memory_map_grid.enable_single_row_selection
			memory_map_grid.enable_selection_key_handling
			memory_map_grid.show_header
			memory_map_grid.hide_tree_node_connectors
			memory_map_grid.set_row_height (16)
			memory_map_grid.set_focused_selection_color (colors.grid_focus_selection_color)
			memory_map_grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			memory_map_grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			memory_map_grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)
			stone_director.bind (memory_map_grid)
			register_action (memory_map_grid.row_expand_actions, agent (a_row: EV_GRID_ROW) do execute_with_busy_cursor (agent on_row_expanded (a_row)) end)
			register_action (memory_map_grid.pointer_button_release_item_actions, agent (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM)
				do
					if a_button = {EV_POINTER_CONSTANTS}.right then
						show_item_context_menu (a_item, a_x - a_item.parent.virtual_x_position, (a_y + a_item.parent.header.height) - a_item.parent.virtual_y_position)
					end
				end)

			l_box.extend (memory_map_grid)

			create memory_stats_separator
			memory_stats_separator.set_background_color (colors.stock_colors.black)
			memory_stats_separator.set_minimum_width (1)
			l_box.extend (memory_stats_separator)
			l_box.disable_item_expand (memory_stats_separator)

			a_widget.extend (l_box)

				-- Memory stats
			create memory_stats_text
			memory_stats_text.set_minimum_width (300)
			memory_stats_text.set_font (preferences.editor_data.editor_font_preference.value)
			stone_director.bind (memory_stats_text)
			a_widget.extend (memory_stats_text)

			memory_stats_separator.hide
			memory_stats_text.hide

			create memory_update_timer
			register_action (memory_update_timer.actions, agent on_memory_update_timeout)

			create filter_update_timer
			register_action (filter_update_timer.actions, agent on_filter_update_timeout)
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				stone_director.unbind (memory_map_grid)
				stone_director.unbind (memory_stats_text)
				memory_update_timer.destroy
				filter_update_timer.destroy
			end
			Precursor {ES_DOCKABLE_TOOL_PANEL}
		ensure then
			memory_update_timer_destroyed: (old memory_update_timer) /= Void implies (old memory_update_timer).is_destroyed
		end

feature {NONE} -- Access

	memory_data: DS_ARRAYED_LIST [like row_data]
			-- Collection of analysed memory data

	last_map: HASH_TABLE [INTEGER, INTEGER]
			-- Last cached object count map from `calculate_memory_data'

	filter_match_expression: RX_PCRE_MATCHER is
			-- Regular expression used when filtering memory map result
		require
			is_filtering: is_filtering
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			Result := internal_filter_match_expression
			if Result = Void then
				create Result.make
				Result.compile (filter_combo.text)
				internal_filter_match_expression := Result
			end
		ensure
			result_attached: Result /= Void
			result_is_compiled: Result.is_compiled
			result_consistent: Result = filter_match_expression
		end

feature {NONE} -- Helpers

	frozen memory: MEMORY
			-- Shared access to a single instance of {MEMORY}
		require
			not_is_recycled: not is_recycled
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Status report

	is_gc_collecting: BOOLEAN
			-- Determines if the garbage collector is collecting
		require
			not_is_recycled: not is_recycled
		do
			Result := memory.collecting
		end

	is_filtering: BOOLEAN
			-- Indicates if the memory map should be filter
		require
			not_is_recycled: not is_recycled
		do
			Result := is_initialized and then not filter_combo.text.is_empty
		ensure
			result_implies_filter_combo_has_text: Result implies not filter_combo.text.is_empty
		end

feature {NONE} -- Query

	row_data (a_row: EV_GRID_ROW): TUPLE [name: STRING; instances: INTEGER; delta: INTEGER; id: INTEGER] is
			-- Retrieve a row's data
			--
			-- `a_row': Row to retrieve data for.
			-- `Result': The row data
		require
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
		do
			Result ?= a_row.data
		ensure
			result_name_attached: Result /= Void implies Result.name /= Void
			not_result_name_is_empty: Result /= Void implies not Result.name.is_empty
			result_id_positive: Result /= Void implies Result.id > 0
		end

	sorted_objects (a_table: HASH_TABLE [INTEGER, INTEGER]): DS_ARRAYED_LIST [INTEGER] is
			-- Sorts memory map by type name and returns a list of sorted associated type ids.
			--
			-- `a_table': Memory counter map table to sort.
			-- `Result': List of type id's sorted by their actual type name.
		local
			l_table: HASH_TABLE [INTEGER, STRING]
			l_internal: INTERNAL
			l_list: SORTED_TWO_WAY_LIST [STRING]
			l_name: STRING
		do
			create l_internal

			create l_table.make (a_table.count)
			create l_list.make
			create Result.make (a_table.count)
			from a_table.start until a_table.after loop
				l_name := l_internal.type_name_of_type (a_table.key_for_iteration)
				l_list.extend (l_name)
				l_table.put (a_table.key_for_iteration, l_name)
				a_table.forth
			end
			l_list.compare_objects
			l_list.sort

			from l_list.start until l_list.after loop
				Result.put_last (l_table.item (l_list.item))
				l_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	refresh_memory_map (a_enable_gc: BOOLEAN)
			-- Refreshes the memory map in the current state.
			--
			-- `a_enable_gc': True to enable to the GC if it is not activated; False to preserve the current GC active state.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if a_enable_gc and not is_gc_collecting then
					-- Ensure GC is enabled.
				disable_collection_button.disable_select
				on_toogle_collection
				check
					is_gc_collecting: is_gc_collecting
				end
			end

				-- Do update
			execute_with_busy_cursor (agent
				do
					clear_memory_grid

						-- Collect prior to mapping
					on_collect

						-- Calculate memory map data
					calculate_memory_data (False)
					populate_memory_grid
				end)
		end

	clear_memory_grid
			-- Removes all items from the memory grid
		local
			l_grid: like memory_map_grid
			l_count, i: INTEGER
		do
			l_grid := memory_map_grid
			l_count := l_grid.row_count
			from i := 1 until i > l_count loop
				l_grid.row (i).set_data (Void)
				i := i + 1
			end
			l_grid.remove_and_clear_all_rows
		ensure
			memory_map_grid_row_count_is_zero: memory_map_grid.row_count = 0
		end

	populate_memory_grid
			-- Populates the memory map grid with calculated contents
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			memory_data_attached: memory_data /= Void
			memory_map_grid_row_count_is_zero: memory_map_grid.row_count = 0
		local
			l_grid: like memory_map_grid
			l_data: DS_ARRAYED_LIST_CURSOR [like row_data]
			l_expression: like filter_match_expression
		do
			l_grid := memory_map_grid
			l_grid.set_row_count_to (memory_data.count)

			if is_filtering then
				l_expression := filter_match_expression
			end

			l_data := memory_data.new_cursor
			from l_data.start until l_data.after loop
				populate_memory_grid_row (l_grid.row (l_data.index), l_data.item, l_expression)
				l_data.forth
			end
		end

	populate_memory_grid_row (a_row: EV_GRID_ROW; a_data: like row_data; a_match_expression: like filter_match_expression) is
			-- Populates a row with a object type.
			--
			-- `a_row': The row to populate with type subrows.
			-- `a_match_expression': A regular expression to determine the row's default visibility
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			not_a_row_is_part_of_tree_structure: not a_row.is_part_of_tree_structure
			a_data_attached: a_data /= Void
			a_match_expression_is_compiled: a_match_expression /= Void implies a_match_expression.is_compiled
		local
			l_item: EV_GRID_LABEL_ITEM
			l_count: INTEGER
		do
			create l_item.make_with_text (a_data.name)
			a_row.set_item (object_column_index, l_item)

			l_count := a_data.instances
			create l_item.make_with_text (l_count.out)
			l_item.set_foreground_color (colors.stock_colors.dark_gray)
			a_row.set_item (count_column_index, l_item)

			l_count := a_data.delta
			if l_count /= 0 then
				create l_item.make_with_text (l_count.out)
				if l_count > 0 then
					l_item.set_foreground_color (colors.stock_colors.red)
				else
					l_item.set_foreground_color (colors.stock_colors.green)
				end
			else
				create l_item
			end
			a_row.set_item (delta_column_index, l_item)

			a_row.set_data (a_data)
			a_row.ensure_expandable

			if a_match_expression /= Void and then not a_match_expression.matches (a_data.name) then
				a_row.hide
			end
		ensure
			a_row_data_set: a_row.data = a_data
		end

	populate_memory_grid_type_subrows (a_row: EV_GRID_ROW) is
			-- Populates a row with type instances.
			--
			-- `a_row': The row to populate with type instance subrows.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			not_a_row_is_part_of_tree_structure: not a_row.is_part_of_tree_structure
			a_row_data_attached: a_row.data /= Void
		local
			l_row_data: like row_data
			l_grid: like memory_map_grid
			l_objects: ARRAYED_LIST [ANY]
			l_object: ANY
		do
			l_row_data := row_data (a_row)
			check
				l_row_data_attached: l_row_data /= Void
			end
			l_objects := memory.memory_map.item (l_row_data.id)
			if l_objects /= Void then
				l_grid := memory_map_grid
				l_grid.insert_new_rows_parented (l_objects.count, a_row.index + 1, a_row)
				from l_objects.start until l_objects.after loop
					l_object := l_objects.item
					populate_memory_grid_referer_row (a_row.subrow (l_objects.index), l_objects.index, l_object)
					l_objects.forth
				end
			end
		ensure
			a_row_data_attached: a_row.data /= Void
		end

	populate_memory_grid_referer_subrows (a_row: EV_GRID_ROW) is
			-- Populates a row with referring object (object is taken from the supplied row's user data) subrows.
			--
			-- `a_row': The row to populate with subrows.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_part_of_tree_structure: a_row.is_part_of_tree_structure
			a_row_data_attached: a_row.data /= Void
		local
			l_referers: SPECIAL [ANY]
			l_grid: like memory_map_grid
			l_subrow: EV_GRID_ROW
			l_count, i: INTEGER
			l_object: ANY
			l_offset: INTEGER
		do
			l_referers := memory.referers (a_row.data)
			if l_referers /= Void then
				l_count := l_referers.count
				l_grid := memory_map_grid

				from i := 1 until i > l_count  loop
					l_object := l_referers.item (i - 1)
					if a_row = l_object then
						l_offset := l_offset + 1
					end
					i := i + 1
				end
				if l_count - l_offset > 0 then
					l_grid.insert_new_rows_parented (l_count - l_offset, a_row.index + 1, a_row)

					l_offset := 0
					from i := 1 until i > l_count  loop
						l_object := l_referers.item (i - 1)

							-- Object description
						if a_row /= l_object then
							l_subrow := a_row.subrow (i - l_offset)
							populate_memory_grid_referer_row (l_subrow, i - l_offset, l_object)
						else
							l_offset := l_offset + 1
						end
						i := i + 1
					end
				end
			end
		ensure
			a_row_data_attached: a_row.data /= Void
		end

	populate_memory_grid_referer_row (a_row: EV_GRID_ROW; a_index: INTEGER; a_object: ANY) is
			-- Populates a row with the object information
			--
			-- `a_row': The row to populate, or repopulate.
			-- `a_index': The originating indexing for the row.
			-- `a_object': The object to extract data used populate the row.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_part_of_tree_structure: a_row.is_part_of_tree_structure
			a_index_positive: a_index > 0
			a_object_attached: a_object /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
			l_description: STRING
			l_recyclable: EB_RECYCLABLE
			l_color: EV_COLOR
		do
			create l_description.make (30)
			l_description.append_integer (a_index)
			l_description.append (once ": ")
			l_recyclable ?= a_object
			if l_recyclable /= Void then
				a_row.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (230, 230, 230))
				if l_recyclable.is_recycled then
					l_description.append (once "(Recycled) ")
					l_color := colors.stock_colors.dark_green
				else
					l_description.append (once "(Not Recycled) ")
					l_color := colors.stock_colors.red
				end
			else
				l_color := Void
			end
			if row_data (a_row.parent_row) = Void then
				l_description.append (a_object.generating_type)
			end

			create l_item.make_with_text (l_description)
			if l_color /= Void then
				a_row.set_foreground_color (l_color)
			end
			a_row.set_item (object_column_index, l_item)

			create l_item.make_with_text (($a_object).out)
			a_row.set_item (count_column_index, l_item)
			l_item.set_foreground_color (colors.stock_colors.dark_gray)

				-- Blank
			a_row.set_item (delta_column_index, create {EV_GRID_ITEM})

			a_row.ensure_expandable
			a_row.set_data (a_object)
		ensure
			a_row_data_set: a_row.data = a_object
			a_row_is_expandable: a_row.is_expandable
		end

	show_item_context_menu (a_item: EV_GRID_ITEM; a_x: INTEGER; a_y: INTEGER)
			-- Displays a memory map grid item's context menu.
			--
			-- `a_item': The item where the context menu should be display.
			-- `a_x': The x position of the context menu, relative to `memory_data_grid'.
			-- `a_y': The y position of the context menu, relative to `memory_data_grid'.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_item_attached: a_item /= Void
			not_a_item_is_destroyed: not a_item.is_destroyed
			a_x_non_negative: a_x >= 0
			a_y_non_negative: a_y >= 0
		local
			l_object: ANY
			l_recycleable: EB_RECYCLABLE
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
			l_data: like row_data
		do
			l_object ?= a_item.row.data

				-- Only allow recycling in objects that are not used by the tool.
			l_data ?= l_object
			if l_object /= Void and l_data = Void then
				create l_menu
				create l_menu_item.make_with_text_and_action ("Go to object", agent (a_object: ANY) do execute_with_busy_cursor (agent select_object (a_object)) end (l_object))
				l_menu.extend (l_menu_item)
				l_menu.extend (create {EV_MENU_SEPARATOR})
				create l_menu_item.make_with_text_and_action ("Free object",  agent (a_object: ANY) do execute_with_busy_cursor (agent free_object (a_object)) end (l_object))
				l_menu.extend (l_menu_item)

				l_recycleable ?= l_object
				if l_recycleable /= Void and then not l_recycleable.is_recycled then
						-- Add recycle option

					create l_menu_item.make_with_text_and_action ("Perform recycle",  agent (a_object: EB_RECYCLABLE) do execute_with_busy_cursor (agent recycle_object (a_object)) end (l_recycleable))
					l_menu.extend (l_menu_item)
				end

					-- Display menu
				l_menu.show_at (a_item.parent, a_x, a_y)

				l_menu.destroy
			end
		end

feature {NONE} -- Analysis

	calculate_memory_data (a_refresh: BOOLEAN) is
			-- Calculates and analyzes the memory data.
			--
			-- `a_refresh': Causes pre-existing data to be discarded.
		local
			l_map: HASH_TABLE [INTEGER, INTEGER]
			l_sorted_ids: like sorted_objects
			l_last_map: like last_map
			l_memory: like memory
			l_data: like memory_data
			l_name: STRING
			l_count, l_delta, l_id: INTEGER
			l_internal: INTERNAL
		do
			l_memory := memory

				-- Fetch map
			l_map := l_memory.memory_count_map
			if not a_refresh then
					-- If we are not refreshing then there is no need for the last map to be used
				l_last_map := last_map
			end

				-- Calculate memory object count
			create l_internal
			create l_data.make (l_map.count * 10)

			if l_last_map /= Void then
					-- Extend the map with the removed ids
				from l_last_map.start until l_last_map.after loop
					l_id := l_last_map.key_for_iteration
					if not l_map.has (l_id) then
						l_map.extend (0, l_id)
					end
					l_last_map.forth
				end
			end

			l_sorted_ids := sorted_objects (l_map)
			from l_sorted_ids.start until l_sorted_ids.after loop
				l_id := l_sorted_ids.item_for_iteration
				l_name := l_internal.type_name_of_type (l_id)
				l_count := l_map.item (l_id)

				if l_last_map /= Void then
					l_delta := l_count - l_last_map.item (l_id)
				else
					l_delta := l_count
				end

				l_data.force_last ([l_name, l_count, l_delta, l_id])
				l_sorted_ids.forth
			end
			last_map := l_map
			memory_data := l_data
		ensure
			memory_data_attached: memory_data /= Void
			last_map_attached: last_map /= Void
		end

	memory_stat (a_bytes: INTEGER): STRING_32
			-- Retrieves a memory stat for the number of bytes
			--
			-- `a_bytes': Number of bytes to retrieve a string statistic for.
			-- `Result': A string representation of `a_bytes'.
		local
			l_bytes: NATURAL
			l_usage: REAL
			l_stat: STRING_32
		do
			l_bytes := a_bytes.to_natural_32
			if l_bytes > stat_gb_threshold then
				l_usage := l_bytes / 1073741824
				l_stat := once "GB"
			elseif l_bytes > stat_mb_threshold then
				l_usage := l_bytes / 1048576
				l_stat := once "MB"
			elseif l_bytes > stat_kb_threshold then
				l_usage := l_bytes / 1024
				l_stat := once "KB"
			else
				l_usage := l_bytes
				l_stat := once "Bytes"
			end
			create Result.make (20)
			Result.append_real (l_usage)
			Result.append_character (' ')
			Result.append (l_stat)
		end

	stat_kb_threshold: NATURAL = 4096
	stat_mb_threshold: NATURAL = 2097152
	stat_gb_threshold: NATURAL = 2147483648

feature {NONE} -- User interface elements

	disable_collection_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Toggle automatic GC collection button

	collect_button: SD_TOOL_BAR_BUTTON
		-- Force GC collection button

	refresh_button: SD_TOOL_BAR_BUTTON
		-- Refresh memory map button

	filter_combo: EV_COMBO_BOX
			-- Filter box for memory map filtering

	show_memory_usage_button: SD_TOOL_BAR_TOGGLE_BUTTON
		-- Show/hide memory usage button

	memory_map_grid: ES_GRID
			-- Grid used to display memory map information

	memory_stats_text: EV_TEXT
			-- Text widget displaying memory usage info

	memory_stats_separator: EV_CELL
			-- Box used to contain memory stats, used for setting visibility

	memory_update_timer: EV_TIMEOUT
			-- Timer used to update memory usage stats

	filter_update_timer: EV_TIMEOUT
			-- Timer used to update filtered view of the memory data

feature {NONE} -- Action handlers

	on_toogle_collection
			-- Called when the user selects to enable/disable GC collection
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if disable_collection_button.is_selected then
				on_collect
				memory.collection_off
			else
				memory.collection_on
			end
		ensure
			is_gc_collecting_matches_disable_collection_button_state: disable_collection_button.is_selected = not is_gc_collecting
		end

	on_collect
			-- Called when the user requests the GC performs a collection
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			l_collecting: like is_gc_collecting
		do
			l_collecting := is_gc_collecting
			if not l_collecting then
				memory.collection_on
			end
			memory.full_collect
			memory.full_coalesce
			memory.full_collect
			if not l_collecting then
				memory.collection_off
			end
		ensure
			is_gc_collecting_unchanged: is_gc_collecting = old is_gc_collecting
		end

	on_refresh_memory_map
			-- Called when the user request a refresh of the mapped memory
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			l_warning: ES_WARNING_PROMPT
			l_buttons: ES_DIALOG_BUTTONS
		do
			if not is_gc_collecting then
				create l_buttons
				create l_warning.make (
					"The garbage collector is not collecting. Attempting to refresh the memory map with the GC running may causes the system to expend its memory.",
					l_buttons.yes_no_cancel_buttons,
					l_buttons.no_button,
					l_buttons.no_button,
					l_buttons.cancel_button)
				l_warning.set_button_text (l_buttons.yes_button, "Continue (No GC)")
				l_warning.set_button_action (l_buttons.yes_button, agent refresh_memory_map (False))
				l_warning.set_button_text (l_buttons.no_button, "Continue (With GC)")
				l_warning.set_button_action (l_buttons.no_button, agent refresh_memory_map (True))
				l_warning.show_on_active_window
			else
				refresh_memory_map (False)
			end
		end

	on_toggle_memory_stats
			-- Call when user toggles showing of memory stats.
			-- Note: Connected to `show_memory_usage_button'
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if show_memory_usage_button.is_selected then
				memory_stats_separator.show
				memory_stats_text.show
				on_memory_update_timeout
				memory_update_timer.set_interval (memory_update_timer_interval)
			else
				memory_stats_separator.hide
				memory_stats_text.hide
				memory_update_timer.set_interval (0)
			end
		end

	on_memory_update_timeout
			-- Call when the memory update timer times out.
			-- Note: Connected to `memory_update_timer'.
		require
			not_is_recycled: not is_recycled
			is_initialized: is_initialized
		local
			l_eiffel_info: MEM_INFO
			l_c_info: MEM_INFO
			l_all_info: MEM_INFO
			l_content: STRING
		do
			if memory_stats_text.is_displayed then
					-- Preform collection
				on_collect

					-- Fetch stats
				l_eiffel_info := memory.memory_statistics ({MEM_CONST}.eiffel_memory)
				l_c_info := memory.memory_statistics ({MEM_CONST}.c_memory)
				l_all_info := memory.memory_statistics ({MEM_CONST}.total_memory)

					-- Create report
				create l_content.make (1024)
				l_content.append ("Eiffel Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ("Total    : " + memory_stat (l_eiffel_info.total) + "%N")
				l_content.append ("Used     : " + memory_stat (l_eiffel_info.used) + "%N")
				l_content.append ("Overhead : " + memory_stat (l_eiffel_info.overhead) + "%N")
				l_content.append ("Available: " + memory_stat (l_eiffel_info.free) + "%N")
				l_content.append ("---------------------------------%N%N")

				l_content.append ("C Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ("Total    : " + memory_stat (l_c_info.total) + "%N")
				l_content.append ("Used     : " + memory_stat (l_c_info.used) + "%N")
				l_content.append ("Overhead : " + memory_stat (l_c_info.overhead) + "%N")
				l_content.append ("Available: " + memory_stat (l_c_info.free) + "%N")
				l_content.append ("---------------------------------%N%N")

				l_content.append ("Total Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ("Total    : " + memory_stat (l_all_info.total) + "%N")
				l_content.append ("Used     : " + memory_stat (l_all_info.used) + "%N")
				l_content.append ("Overhead : " + memory_stat (l_all_info.overhead) + "%N")
				l_content.append ("Available: " + memory_stat (l_all_info.free) + "%N")
				l_content.append ("---------------------------------")

				ev_application.do_once_on_idle (agent memory_stats_text.set_text (l_content))
			end
		end

	on_filter_changed
			-- Called when the filter combo box text changes.
			-- Note: Connected to `filter_combo'.
		do
			filter_update_timer.set_interval (0)
			filter_update_timer.set_interval (filter_update_timer_interval)
		end

	on_filter_update_timeout
			-- Call when the filter update timer expires.
			-- Note: connected to `on_filter_update_timer'
		require
			not_is_recycled: not is_recycled
			is_initialized: is_initialized
		local
			l_grid: like memory_map_grid
			l_row: EV_GRID_ROW
			l_data: like row_data
			l_count, i: INTEGER
			l_regex: like filter_match_expression
		do
				-- Wipe out cached expression
			internal_filter_match_expression := Void

				-- Show/hide applicable rows
			l_grid := memory_map_grid
			l_count := l_grid.row_count
			if l_count >= 0 then
				if is_filtering then
					l_regex := filter_match_expression
				end

				from i := 1 until i > l_count loop
					l_row := l_grid.row (i)
					if not l_row.is_part_of_tree_structure then
						l_data ?= l_row.data
						check
							l_data_attached: l_data /= Void
						end
						if l_regex = Void or else l_regex.matches (l_data.name) then
							l_row.show
						else
							l_row.hide
						end
					end
					i := i + l_row.subrow_count_recursive + 1
				end
			end

			filter_update_timer.set_interval (0)
		ensure
			filter_update_timer_reset: filter_update_timer.interval = 0
		end

	on_row_expanded (a_row: EV_GRID_ROW)
			-- Called when a row is expanded on the memory map grid
		require
			not_is_recycled: not is_recycled
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_memory_map_parent: a_row.parent = memory_map_grid
		do
			if a_row.subrow_count = 0 then
				if a_row.is_part_of_tree_structure then
					populate_memory_grid_referer_subrows (a_row)
				else
					populate_memory_grid_type_subrows (a_row)
				end
			end
		end

feature {NONE} -- Memory pruning

	select_object (a_object: ANY) is
			-- Navigates to a object in the grid strcuture.
			--
			-- `a_object': An object to navigate too.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_grid: EV_GRID
			l_count, i: INTEGER
			l_row: EV_GRID_ROW
			l_object_row: EV_GRID_ROW
			l_type_name: STRING
			l_data: like row_data
			l_stop: BOOLEAN
		do
			l_type_name := a_object.generating_type

				-- Attempt to locate type row
			l_grid := memory_map_grid
			l_count := l_grid.row_count
			from i := 1 until i > l_count or l_stop loop
				l_row := l_grid.row (i)
				l_data := row_data (l_row)
				l_stop := l_data /= Void and then l_data.name.is_equal (l_type_name)
				if not l_stop then
					i := i + l_row.subrow_count_recursive + 1
				end
			end

			if l_stop then
				check
					l_row_attached: l_row /= Void
				end
					-- Expand row to populate sub items
				l_row.expand
				on_row_expanded (l_row)
				if not l_row.is_show_requested then
						-- Ensure the row is always shown, because the filter might hide it.
					l_row.show
				end

					-- Attempt to locate object
				l_stop := False
				l_count := l_row.subrow_count
				from i := 1 until i > l_count or l_stop loop
					l_object_row := l_row.subrow (i)
					l_stop := l_object_row.data = a_object
					i := i + 1
				end

				if l_stop then
					check
						l_object_row_attached: l_object_row /= Void
					end
						-- Perform selection
					l_grid.selected_rows.do_all (agent (a_row: EV_GRID_ROW) do a_row.disable_select end)
					l_object_row.enable_select
					l_object_row.ensure_visible
				end
			end
		end

	free_object (a_object: ANY) is
			-- Release an object.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_name: STRING
			l_address: STRING
			l_warning: ES_WARNING_PROMPT
			l_grid: like memory_map_grid
			l_count, i: INTEGER
			l_row: EV_GRID_ROW
		do
			if a_object /= Current and a_object /= tool_descriptor and a_object /= develop_window then
				l_name := a_object.generating_type
				l_address := ($a_object).out
				create l_warning.make_standard_with_cancel ("Freeing an object can harm this running application%NAre you sure you want to free " + l_name + "(" + l_address + ")?")
				l_warning.show_on_active_window

				if l_warning.dialog_result = l_warning.dialog_buttons.ok_button then
						-- Hide all associated objects
					l_grid := memory_map_grid
					from i := 1; l_count := l_grid.row_count until i> l_count loop
						l_row := l_grid.row (i)
						if l_row.data = a_object then
							l_row.hide
							l_row.set_data (Void)
						end
						i := i + 1
					end
					memory.free (a_object)
				end

				l_warning.recycle
			else
				prompts.show_error_prompt ("This object cannot be removed as it's in use by the " + tool_title.as_string_32 + " tool.", Void, Void)
			end
		end

	recycle_object (a_object: EB_RECYCLABLE) is
			-- Recycled an object
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_index: INTEGER
			l_count, i: INTEGER
			l_subrow_count, j: INTEGER
			l_row: EV_GRID_ROW
			l_parent_row: EV_GRID_ROW
			l_grid: like memory_map_grid
		do
			if a_object /= Current and a_object /= tool_descriptor and a_object /= develop_window then
				a_object.recycle

					-- Redraw all items currently displaying a representation of `a_object'
				l_grid := memory_map_grid
				from i := 1; l_count := l_grid.row_count until i > l_count loop
					l_row := l_grid.row (i)

					if l_row.data = a_object then
							-- Attempt to row item index
						l_index := 0
						l_parent_row := l_row.parent_row
						from j := 1; l_subrow_count := l_parent_row.subrow_count until j > l_subrow_count or l_index > 0 loop
							if l_parent_row.subrow (j) = l_row then
								l_index := j
							end
							j := j + 1
						end
						check
							l_index_positive: l_index > 0
						end
							-- Repopulate the row with the new info.
						populate_memory_grid_referer_row (l_row, l_index, a_object)
					end

					i := i + 1
				end
			else
				prompts.show_error_prompt ("This object cannot be recycled as it's in use by the " + tool_title.as_string_32 + " tool.", Void, Void)
			end
		ensure
			a_object_is_recycled: a_object.is_recycled
		end

feature {NONE} -- Factory

	create_widget: EV_HORIZONTAL_SPLIT_AREA
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in `build_tool_interface'
		do
			create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
			create Result.make (4)

			create refresh_button.make
			refresh_button.set_text ("Refresh")
			refresh_button.set_tooltip ("Refreshes the view to display the current system memory state.")
			register_action (refresh_button.select_actions, agent on_refresh_memory_map)
			Result.put_last (refresh_button)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create collect_button.make
			collect_button.set_text ("Collect")
			collect_button.set_tooltip ("Forces a GC collection.")
			register_action (collect_button.select_actions, agent do execute_with_busy_cursor (agent on_collect) end)
			Result.put_last (collect_button)

			create disable_collection_button.make
			disable_collection_button.set_text ("Surpress GC")
			disable_collection_button.set_tooltip ("Enables/Disables the GC.")
			if not is_gc_collecting then
				disable_collection_button.enable_select
			end
			register_action (disable_collection_button.select_actions, agent do execute_with_busy_cursor (agent on_toogle_collection) end)
			Result.put_last (disable_collection_button)
		ensure then
			result_attached: Result /= Void
		end

	create_right_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_label: EV_LABEL
			l_widget: SD_TOOL_BAR_WIDGET_ITEM
			l_box: EV_HORIZONTAL_BOX
		do
			create Result.make (3)

			create l_box
			l_box.set_padding (6)
			create l_label.make_with_text ("Type filter:")
			l_box.extend (l_label)

			create filter_combo
			filter_combo.set_minimum_width (200)
			filter_combo.set_tooltip ("Enter a regular expression to filter the mapped list of types.")
			filter_combo.set_text ("^ES_GROUP_TOOL")
			register_action (filter_combo.change_actions, agent on_filter_changed)
			l_box.extend (filter_combo)
			l_box.disable_item_expand (filter_combo)

			create l_widget.make (l_box)
			l_widget.set_name ("memory filter")

			Result.put_last (l_widget)
			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create show_memory_usage_button.make
			show_memory_usage_button.set_text ("Show Stats")
			show_memory_usage_button.set_tooltip ("Show/hide memory statistical information.")
			register_action (show_memory_usage_button.select_actions, agent on_toggle_memory_stats)
			Result.put_last (show_memory_usage_button)

		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	memory_update_timer_interval: INTEGER = 500
	filter_update_timer_interval: INTEGER = 500
	object_column_index: INTEGER = 1
	count_column_index: INTEGER = 2
	delta_column_index: INTEGER = 3

feature {NONE} -- Internal implementation cache

	internal_filter_match_expression: like filter_match_expression
			-- Cached version of `filter_match_expression'
			-- Note: do not use direcly!

invariant
	disable_collection_button_attached: is_initialized and not is_recycled implies disable_collection_button /= Void
	collect_button_attached: is_initialized and not is_recycled implies collect_button /= Void
	refresh_button_attached: is_initialized and not is_recycled implies refresh_button /= Void
	filter_combo_attached: is_initialized and not is_recycled implies filter_combo /= Void
	show_memory_usage_button_attached: is_initialized and not is_recycled implies show_memory_usage_button /= Void
	memory_map_grid_attached: is_initialized and not is_recycled implies memory_map_grid /= Void
	memory_stats_text_attached: is_initialized and not is_recycled implies memory_stats_text /= Void
	memory_stats_separator_attached: is_initialized and not is_recycled implies memory_stats_separator /= Void
	memory_update_timer_attached: is_initialized and not is_recycled implies memory_update_timer /= Void
	filter_update_timer_attached: is_initialized and not is_recycled implies filter_update_timer /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
