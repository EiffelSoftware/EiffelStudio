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
			l_box: EV_HORIZONTAL_BOX
			l_col: EV_GRID_COLUMN
			l_separator: EV_CELL
		do
			create l_box

				-- Memory map grid
			create memory_map_grid
			memory_map_grid.set_column_count_to (3)
			l_col := memory_map_grid.column (object_column_index)
			l_col.set_title ("Object Type")

			l_col := memory_map_grid.column (count_column_index)
			l_col.set_title ("Count")
			l_col.set_width (50)

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
			register_action (memory_map_grid.row_collapse_actions, agent on_row_collapsed)
			l_box.extend (memory_map_grid)

			create l_separator
			l_separator.set_background_color (colors.stock_colors.black)
			l_separator.set_minimum_width (1)
			l_box.extend (l_separator)
			l_box.disable_item_expand (l_separator)

			a_widget.extend (l_box)

				-- Memory stats
			create memory_stats_text
			memory_stats_text.set_minimum_width (300)
			memory_stats_text.set_font (preferences.editor_data.editor_font_preference.value)
			memory_stats_text.hide
			stone_director.bind (memory_stats_text)
			a_widget.extend (memory_stats_text)
			--a_widget.disable_item_expand (memory_stats_text)

			create memory_update_timer
			register_action (memory_update_timer.actions, agent on_memory_update_timeout)
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle tool.
		do
			if is_initialized then
				stone_director.unbind (memory_map_grid)
				memory_map_grid := Void

				stone_director.unbind (memory_stats_text)
				memory_stats_text := Void

				memory_update_timer.destroy
				memory_update_timer := Void
			end
			if memory_data /= Void then
				memory_data.wipe_out
				memory_data := Void
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

feature {NONE} -- Query

	row_data (a_row: EV_GRID_ROW): TUPLE [name: STRING; instances: INTEGER; delta: INTEGER; id: INTEGER] is
			-- Retrieve a row's data
			--
			-- `a_row': Row to retrieve data for.
			-- `Result': The row data
		require
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_is_part_of_tree_structure: a_row.is_part_of_tree_structure
		do
			Result ?= a_row.data
		ensure
			result_attached: Result /= Void
			result_name_attached: Result.name /= Void
			not_result_name_is_empty: not Result.name.is_empty
			result_id_positive: Result.id > 0
		end

	sorted_objects (a_table: HASH_TABLE [INTEGER, INTEGER]): DS_ARRAYED_LIST [INTEGER] is
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
						-- Collect prior to mapping
					on_collect

						-- Calculate memory map data
					calculate_memory_data (False)
					populate_memory_grid
				end)
		end

	populate_memory_grid
			-- Populates the memory map grid with calculated contents
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			memory_data_attached: memory_data /= Void
		local
			l_grid: like memory_map_grid
			l_data: DS_ARRAYED_LIST_CURSOR [like row_data]
		do
			l_grid := memory_map_grid
			l_grid.remove_and_clear_all_rows
			l_grid.set_row_count_to (memory_data.count)

			l_data := memory_data.new_cursor
			from l_data.start until l_data.after loop
				populate_memory_grid_row (l_grid.row (l_data.index), l_data.item)
				l_data.forth
			end
		end

	populate_memory_grid_row (a_row: EV_GRID_ROW; a_data: like row_data)
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			not_a_row_is_part_of_tree_structure: not a_row.is_part_of_tree_structure
			a_data_attached: a_data /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
			l_count: INTEGER
		do
			create l_item.make_with_text (a_data.name)
			a_row.set_item (object_column_index, l_item)

			l_count := a_data.instances
			if l_count > 0 then
				create l_item.make_with_text (l_count.out)
				l_item.set_foreground_color (colors.stock_colors.dark_gray)
			else
				create l_item
			end
			a_row.set_item (count_column_index, l_item)

			l_count := a_data.delta
			if l_count > 0 then
				create l_item.make_with_text (l_count.out)
				l_item.set_foreground_color (colors.stock_colors.red)
			else
				create l_item
			end
			a_row.set_item (delta_column_index, l_item)

			a_row.set_data (a_data)
			a_row.ensure_expandable
		ensure
			a_row_data_set: a_row.data = a_data
		end

	populate_memory_grid_type_subrows (a_row: EV_GRID_ROW) is
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			not_a_row_is_part_of_tree_structure: not a_row.is_part_of_tree_structure
			a_row_data_attached: a_row.data /= Void
		local
			l_item: EV_GRID_LABEL_ITEM
			l_row_data: like row_data
			l_grid: like memory_map_grid
			l_objects: ARRAYED_LIST [ANY]
			l_subrow: EV_GRID_ROW
			l_object: ANY
			l_recyclable: EB_RECYCLABLE
			l_description: STRING
			l_color: EV_COLOR
		do
			l_row_data ?= a_row.data
			check
				l_row_data_attached: l_row_data /= Void
			end
			l_objects := memory.memory_map.item (l_row_data.id)
			if l_objects /= Void then
				l_grid := memory_map_grid
				l_grid.insert_new_rows_parented (l_objects.count, a_row.index + 1, a_row)
				from l_objects.start until l_objects.after loop
					l_object := l_objects.item
					l_subrow := a_row.subrow (l_objects.index)

						-- Object description
					l_recyclable ?= l_object
					create l_description.make (15)
					l_description.append_integer (l_objects.index)
					if l_recyclable /= Void then
						l_subrow.set_background_color (colors.grid_disabled_item_text_color)
						if l_recyclable.is_recycled then
							l_description.append (once " (Recycled)")
							l_color := colors.stock_colors.green
						else
							l_description.append (once " (Not Recycled)")
							l_color := colors.stock_colors.red
						end
					else
						l_color := Void
					end
					create l_item.make_with_text (l_description)
					if l_color /= Void then
						l_subrow.set_foreground_color (l_color)
					end
					l_subrow.set_item (object_column_index, l_item)

						-- Address
					create l_item.make_with_text (($l_object).out)
					l_item.set_foreground_color (colors.stock_colors.dark_gray)
					l_subrow.set_item (count_column_index, l_item)

						-- Blank
					l_subrow.set_item (delta_column_index, create {EV_GRID_ITEM})

					l_subrow.ensure_expandable
					l_subrow.set_data (l_object)

					l_objects.forth
				end
			end
		ensure
			a_row_data_attached: a_row.data /= Void
		end

	populate_memory_grid_referer_subrows (a_row: EV_GRID_ROW) is
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
			l_item: EV_GRID_LABEL_ITEM
			l_internal: INTERNAL
			l_count, i: INTEGER
			l_description: STRING
			l_object: ANY
			l_recyclable: EB_RECYCLABLE
			l_color: EV_COLOR
			l_offset: INTEGER
		do
			l_referers := memory.referers (a_row.data)
			if l_referers /= Void then
				l_count := l_referers.count
				l_grid := memory_map_grid
				l_grid.insert_new_rows_parented (l_count, a_row.index + 1, a_row)

				create l_internal
				from i := 1 until i > l_count  loop
					l_object := l_referers.item (i - 1)
					l_subrow := a_row.subrow (i - l_offset)

						-- Object description
					if a_row /= l_object then
						create l_description.make (30)
						l_description.append_integer (i - l_offset)
						l_description.append (once ": ")
						l_recyclable ?= l_object
						if l_recyclable /= Void then
							l_subrow.set_background_color (colors.grid_disabled_item_text_color)
							if l_recyclable.is_recycled then
								l_description.append (once "(Recycled) ")
								l_color := colors.stock_colors.green
							else
								l_description.append (once "(Not Recycled) ")
								l_color := colors.stock_colors.red
							end
						else
							l_color := Void
						end
						l_description.append (l_internal.type_name (l_object))

						create l_item.make_with_text (l_description)
						if l_color /= Void then
							l_subrow.set_foreground_color (l_color)
						end
						l_subrow.set_item (object_column_index, l_item)

						create l_item.make_with_text (($l_object).out)
						l_subrow.set_item (count_column_index, l_item)
						l_item.set_foreground_color (colors.stock_colors.dark_gray)

							-- Blank
						l_subrow.set_item (delta_column_index, create {EV_GRID_ITEM})

						l_subrow.ensure_expandable
						l_subrow.set_data (l_object)
					else
						l_offset := l_offset + 1
					end
					i := i + 1
				end
				if l_offset > 0 then
					from until l_offset = 0 loop
						a_row.remove_subrow (l_grid.row (a_row.index + a_row.subrow_count_recursive))
						l_offset := l_offset - 1
					end
				end
			end
		ensure
			a_row_data_attached: a_row.data /= Void
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
			l_sorted_ids := sorted_objects (l_map)
			from l_sorted_ids.start until l_sorted_ids.after loop
				l_id := l_sorted_ids.item_for_iteration
				l_name := l_internal.type_name_of_type (l_id)
				l_count := l_map.item (l_id)

				if l_last_map /= Void then
					l_delta := l_count - l_last_map.item (l_id)
					l_last_map.remove (l_id)
				else
					l_delta := l_count
				end

				l_data.force_last ([l_name, l_count, l_delta, l_id])
				l_sorted_ids.forth
			end
--			from l_map.start until l_map.after loop
--				l_id := l_map.key_for_iteration
--				l_name := l_internal.type_name_of_type (l_id)
--				l_count := l_map.item_for_iteration

--				if l_last_map /= Void then
--					l_delta := l_count - l_last_map.item (l_id)
--					l_last_map.remove (l_id)
--				else
--					l_delta := l_count
--				end

--				l_data.force_last ([l_name, l_count, l_delta, l_id])
--				l_map.forth
--			end

			if l_last_map /= Void and then not l_last_map.is_empty then
					-- Add removed objects from last calculation (negative deltas with count of 0)
				check
					not_a_refresh: not a_refresh
				end
				from l_last_map.start until l_last_map.after loop
					l_id := l_last_map.key_for_iteration
					l_name := l_internal.type_name_of_type (l_id)
					l_data.force_last ([l_name, 0, - l_last_map.item_for_iteration, l_id])
					l_last_map.forth
				end
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

	memory_update_timer: EV_TIMEOUT
			-- Timer used to update memory usage stats

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
				memory_stats_text.show
				on_memory_update_timeout
				memory_update_timer.set_interval (memory_update_timer_interval)
			else
				memory_stats_text.hide
				memory_update_timer.set_interval (0)
			end
		end

	on_memory_update_timeout
			-- Call when the memory update timer times out
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

	on_row_expanded (a_row: EV_GRID_ROW)
			-- Called when a row is expanded on the memory map grid
		require
			not_is_recycled: not is_recycled
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_memory_map_parent: a_row.parent = memory_map_grid
		do
			if a_row.is_part_of_tree_structure then
				populate_memory_grid_referer_subrows (a_row)
			else
				populate_memory_grid_type_subrows (a_row)
			end
		end

	on_row_collapsed (a_row: EV_GRID_ROW) is
			-- Called when a row is collapsed
		require
			not_is_recycled: not is_recycled
			is_initialized: is_initialized
			a_row_attached: a_row /= Void
			not_a_row_is_destroyed: not a_row.is_destroyed
			a_row_has_memory_map_parent: a_row.parent = memory_map_grid
		local
			l_count: INTEGER
			l_row: EV_GRID_ROW
		do
				-- Remove all sub rows
			from l_count := a_row.subrow_count until l_count = 0 loop
				l_row := a_row.subrow (a_row.subrow_count)
				if l_row.is_expandable and then l_row.is_expanded then
					l_row.collapse
				end
				l_row.set_data (Void)
				l_count := l_count - 1
			end
			memory_map_grid.remove_rows (a_row.index + 1, a_row.index + a_row.subrow_count_recursive)
			a_row.ensure_expandable
		ensure
			a_row_has_nosub_rows: a_row.subrow_count = 0
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
		do
			create Result.make (4)

			create l_label.make_with_text ("Filter ")
			create l_widget.make (l_label)
			Result.put_last (l_widget)

			create filter_combo
			filter_combo.set_minimum_width (200)
			filter_combo.set_minimum_height (20)
			create l_widget.make (filter_combo)
			Result.put_last (l_widget)

			Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)

			create show_memory_usage_button.make
			show_memory_usage_button.set_text ("Show Stats")
			register_action (show_memory_usage_button.select_actions, agent on_toggle_memory_stats)
			Result.put_last (show_memory_usage_button)

		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	memory_update_timer_interval: INTEGER = 500
	object_column_index: INTEGER = 1
	count_column_index: INTEGER = 2
	delta_column_index: INTEGER = 3

invariant
	memory_update_timer_attached: is_initialized and not is_recycled implies memory_update_timer /= Void
	memory_stats_text_attached: is_initialized and not is_recycled implies memory_stats_text /= Void
	memory_data_contains_attached_items: memory_data /= Void implies not memory_data.has (Void)
	disable_collection_button_attached: is_initialized and not is_recycled implies disable_collection_button /= Void
	collect_button_attached: is_initialized and not is_recycled implies collect_button /= Void
	refresh_button_attached: is_initialized and not is_recycled implies refresh_button /= Void
	filter_combo_attached: is_initialized and not is_recycled implies filter_combo /= Void
	show_memory_usage_button_attached: is_initialized and not is_recycled implies show_memory_usage_button /= Void

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
