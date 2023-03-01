note
	description: "[
		Tool descriptor for EiffelStudio's memory analyser tool.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_MEMORY_TOOL_PANEL

inherit
	ES_DOCKABLE_TOOL_PANEL [EV_HORIZONTAL_SPLIT_AREA]
		redefine
			on_after_initialized,
			internal_recycle,
			create_right_tool_bar_items
		end

	ES_HELP_CONTEXT
		export
			{NONE} all
		redefine
			help_provider,
			help_context_section
		end

create {ES_MEMORY_TOOL}
	make

feature {NONE} -- Initialization

	on_after_initialized
			-- Use to perform additional creation initializations, after the UI has been created.
		do
			Precursor

				-- Set up column sorting
			enable_sorting_on_columns (<<memory_map_grid.column (object_column_index), memory_map_grid.column (count_column_index), memory_map_grid.column (delta_column_index)>>)

				-- Bind redirecting pick and drop actions
			stone_director.bind (memory_stats_text, Current)
			stone_director.bind (memory_map_grid, Current)

				-- Set button states based on session data
			if attached develop_window_session_data as w_session_data then
				if attached {BOOLEAN_REF} w_session_data.value_or_default (show_memory_usage_session_id, False) as b_ref and then b_ref.item then
					show_memory_usage_button.enable_select
					on_toggle_memory_stats
				end

				if attached {BOOLEAN_REF} w_session_data.value_or_default (show_deltas_only_session_id, True) as b_ref and then b_ref.item then
					show_deltas_button.enable_select
					on_toogle_show_deltas
				end

				if attached {READABLE_STRING_GENERAL} w_session_data.value (filter_session_id) as l_filter then
					filter_combo.set_text (l_filter)
					on_filter_changed
				end
			end
		end

feature {NONE} -- User interface initialization

	build_tool_interface (a_widget: EV_HORIZONTAL_SPLIT_AREA)
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
--			memory_map_grid.set_row_height (16)
			memory_map_grid.set_focused_selection_color (colors.grid_focus_selection_color)
			memory_map_grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			memory_map_grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			memory_map_grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)
			register_action (memory_map_grid.pointer_button_release_item_actions, agent (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM)
				do
					if a_item /= Void and a_button = {EV_POINTER_CONSTANTS}.right then
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
			a_widget.enable_item_expand (l_box)

				-- Memory stats
			create memory_stats_text
			memory_stats_text.set_minimum_width (300)
			memory_stats_text.set_font (preferences.editor_data.editor_font_preference.value)
			a_widget.extend (memory_stats_text)
			a_widget.disable_item_expand (memory_stats_text)

			memory_stats_separator.hide
			memory_stats_text.hide

			create memory_update_timer
			register_action (memory_update_timer.actions, agent on_memory_update_timeout)

			create filter_update_timer
			register_action (filter_update_timer.actions, agent on_filter_update_timeout)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- Recycle tool.
		do
			if is_initialized then
				memory_update_timer.destroy
				filter_update_timer.destroy
			end
			Precursor {ES_DOCKABLE_TOOL_PANEL}
		ensure then
			memory_update_timer_destroyed: (old memory_update_timer) /= Void implies (old memory_update_timer).is_destroyed
		end

feature {NONE} -- Access

	memory_data: ARRAYED_LIST [like row_data]
			-- Collection of analysed memory data

	last_map: HASH_TABLE [INTEGER, INTEGER]
			-- Last cached object count map from `calculate_memory_data'

	filter_match_expression: RX_PCRE_MATCHER
			-- Regular expression used when filtering memory map result
		require
			is_filtering: is_filtering
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		local
			l_cell: like internal_filter_match_expression
		do
			l_cell := internal_filter_match_expression
			if l_cell = Void then
				create Result.make
				Result.compile (filter_combo.text.as_upper)
				if not Result.is_compiled then
						-- Invalid Eiffel class name, so no results will be shown.
					Result.compile (once "^$")
				end
				create l_cell.put (Result)
				internal_filter_match_expression := l_cell
			else
				Result := l_cell.item
			end
		ensure
			result_is_compiled: Result /= Void implies Result.is_compiled
			result_consistent: Result = filter_match_expression
		end

feature {NONE} -- Access

	help_provider: attached UUID
			-- <Precursor>
		once
			Result := (create {HELP_PROVIDER_KINDS}).wiki
		end

	help_context_id: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "User Interface Memory Managment"
		end

	help_context_section: detachable HELP_CONTEXT_SECTION_I
			-- <Precursor>
		once
			create {HELP_CONTEXT_SECTION} Result.make ("Detecting Memory Leaks")
		end

feature {NONE} -- Helpers

	frozen grid_wrapper: EVS_GRID_WRAPPER [EV_GRID_ROW]
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			Result := internal_grid_wrapper
			if Result = Void then
				create Result.make (memory_map_grid)
				internal_grid_wrapper := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = grid_wrapper
		end

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

	is_showing_positive_deltas: BOOLEAN
			-- Indicates if the memory map should be filter to show only positive deltas
		require
			not_is_recycled: not is_recycled
		do
			Result := is_initialized and then show_deltas_button.is_selected
		ensure
			result_implies_show_deltas_button_is_selected: Result implies show_deltas_button.is_selected
		end

feature {NONE} -- Query

	row_data: TUPLE [name: STRING; instances: INTEGER; delta: INTEGER; type_id: INTEGER]
		do
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
			l_data: like row_data
			l_expression: like filter_match_expression
			l_item: EV_GRID_LABEL_ITEM
			l_count: INTEGER
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_grid := memory_map_grid
			l_grid.lock_update

			if is_filtering then
				l_expression := filter_match_expression
			end

			i := 1
			across memory_data as l_data_cursor loop
				l_data := l_data_cursor.item

				create l_item.make_with_text (l_data.name)
				l_grid.set_item (object_column_index, i, l_item)

				l_count := l_data.instances
				create l_item.make_with_text (l_count.out)
				l_item.set_foreground_color (colors.stock_colors.dark_gray)
				l_grid.set_item (count_column_index, i, l_item)

				l_count := l_data.delta
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
				l_grid.set_item (delta_column_index, i, l_item)
				l_row := l_grid.row (i)
				l_row.set_data (l_data)
				if
					(l_expression /= Void and then not l_expression.matches (l_data.name)) or
					(is_showing_positive_deltas and then l_data.delta = 0)
				then
					l_row.hide
				end

				i := i + 1
				l_grid.insert_new_rows_parented (2, i, l_row)
				create l_item.make_with_text ("Clouds of referers")
				l_grid.set_item (1, i, l_item)
				l_row := l_grid.row (i)
				l_row.ensure_expandable
				l_row.expand_actions.extend (agent execute_with_busy_cursor (agent populate_memory_grid_clouds (l_data.type_id, l_row)))
				l_row.expand_actions.extend (agent execute_with_busy_cursor (agent on_collect))

				i := i + 1
				create l_item.make_with_text ("Instances")
				l_grid.set_item (1, i, l_item)
				l_row := l_grid.row (i)
				l_row.ensure_expandable
				l_row.expand_actions.extend (agent execute_with_busy_cursor (agent populate_memory_grid_type_subrows (l_data, l_row)))
				l_row.expand_actions.extend (agent execute_with_busy_cursor (agent on_collect))

				i := i + 1
			end

			l_grid.unlock_update
		rescue
			if l_grid.is_locked then
				l_grid.unlock_update
			end
		end

	populate_memory_grid_type_subrows (a_data: like row_data; a_parent_row: EV_GRID_ROW)
			-- Populates a row with type instances.
			--
			-- `a_parent_row': The row to populate with type instance subrows.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_parent_row /= Void
			not_a_row_is_destroyed: not a_parent_row.is_destroyed
			a_data_attached: a_data /= Void
		local
			l_objects: SPECIAL [ANY]
			l_object: ANY
			i, nb: INTEGER
		do
			if a_parent_row.subrow_count = 0 then
				l_objects := memory.objects_instance_of_type (a_data.type_id)
				if l_objects /= Void then
					from
						i := 0
						nb := l_objects.count
						memory_map_grid.insert_new_rows_parented (nb, a_parent_row.index + 1, a_parent_row)
					until
						i >= nb
					loop
						l_object := l_objects.item (i)
						populate_memory_grid_referer_row (a_parent_row.subrow (i + 1), i + 1, l_object)
						i := i + 1
					end
				end
			end
		end

	populate_with_content (a_object: ANY; a_parent_row: EV_GRID_ROW)
			-- Populates a row with type instances.
			--
			-- `a_parent_row': The row to populate with type instance subrows.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_parent_row /= Void
			not_a_row_is_destroyed: not a_parent_row.is_destroyed
		local
			i, nb: INTEGER
			l_reflected: REFLECTED_REFERENCE_OBJECT
			l_item: EV_GRID_LABEL_ITEM
			l_description: STRING
			l_reflector: REFLECTOR
			l_row: EV_GRID_ROW
			l_obj: ANY
		do
			if a_parent_row.subrow_count = 0 then
				create l_reflected.make (a_object)
				nb := l_reflected.field_count
				if nb > 0 then
					from
						i := 1
						create l_reflector
						memory_map_grid.insert_new_rows_parented (nb, a_parent_row.index + 1, a_parent_row)
					until
						i > nb
					loop
						l_row := a_parent_row.subrow (i)
						create l_description.make (30)
						l_description.append (l_reflected.field_name (i))
						l_description.append (once ": ")
						l_description.append (l_reflector.type_name_of_type (l_reflected.field_static_type (i)))

						create l_item.make_with_text (l_description)
						l_row.set_item (object_column_index, l_item)

						l_row.set_item (count_column_index, create {EV_GRID_ITEM})
						l_description.append (" = ")
						if l_reflected.field_type (i) = {REFLECTOR_CONSTANTS}.reference_type then
							l_obj := l_reflected.field (i)
							if l_obj = Void then
								create l_item.make_with_text ("Void")
							else
								if attached {READABLE_STRING_GENERAL} l_obj as l_str then
									create l_item.make_with_text (l_str)
								elseif attached {DEBUG_OUTPUT} l_obj as l_dbg then
									create l_item.make_with_text (l_dbg.debug_output)
								else
									create l_item.make_with_text (($l_obj).out)
								end
								l_row.ensure_expandable
								l_row.expand_actions.extend (agent populate_with_content (l_obj, l_row))
							end
						else
							create l_item.make_with_text (l_reflected.field (i).out)
						end
						l_row.set_item (count_column_index, l_item)

							-- Blank
						l_row.set_item (delta_column_index, create {EV_GRID_ITEM})

						i := i + 1
					end
				end
			end
		end

	populate_memory_grid_referer_subrows (a_parent_row: EV_GRID_ROW)
			-- Populates a row with referring object (object is taken from the supplied row's user data) subrows.
			--
			-- `a_parent_row': The row to populate with subrows.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_row_attached: a_parent_row /= Void
			not_a_row_is_destroyed: not a_parent_row.is_destroyed
			an_obj_attached: a_parent_row.data /= Void
		local
			l_referers: SPECIAL [ANY]
			l_grid: like memory_map_grid
			l_int: INTERNAL
			l_row: EV_GRID_ROW
			l_row_index, l_count, i, j, nb: INTEGER
			l_any: ANY
			l_item: EV_GRID_LABEL_ITEM
			l_parent_row: EV_GRID_ROW
		do
			if a_parent_row.subrow_count = 0 then
				l_referers := memory.referers (a_parent_row.data)
				l_grid := memory_map_grid

				i := a_parent_row.index + 1
				if l_referers /= Void then
					l_grid.insert_new_rows_parented (2, i, a_parent_row)
					create l_item.make_with_text ("Referers")
					l_grid.set_item (1, i, l_item)
					i := i + 1
				else
					l_grid.insert_new_rows_parented (1, i, a_parent_row)
				end
				create l_item.make_with_text ("Content")
				l_grid.set_item (1, i, l_item)

				l_parent_row := l_grid.row (a_parent_row.index + 1)
				if l_referers /= Void then
					from
						i := 0
						nb := l_referers.count
					until
						i = nb
					loop
							-- Compute number of real elements that are going to be inserted
							-- and discard items we do not want to see.
						if not is_data_result_of_analyzis (l_referers.item (i)) then
							l_count := l_count + 1
						else
							l_referers.put (Void, i)
						end
						i := i + 1
					end

					if l_count > 0 then
						from
							create l_int
							l_row_index := l_parent_row.index
							j := l_row_index + 1
							i := 0
							l_grid.insert_new_rows_parented (l_count, j, l_parent_row)
						until
							i = nb
						loop
							l_any := l_referers.item (i)
							if l_any /= Void then
								l_row := l_grid.row (j)
								populate_memory_grid_referer_row (l_row, i + 1, l_any)
								j := j + 1
							end
							i := i + 1
						end
					end
				end

					-- If there were some referers, we add after the last one that was inserted.
				if l_row /= Void then
					populate_with_content (a_parent_row.data, l_grid.row (l_row.index + 1))
				else
					populate_with_content (a_parent_row.data, l_parent_row)
				end
			end
		end

	populate_memory_grid_referer_row (a_row: EV_GRID_ROW; a_index: INTEGER; a_object: ANY)
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
			l_description: STRING_32
			l_color: EV_COLOR
		do
			create l_description.make (30)
			l_description.append_integer (a_index)
			l_description.append (once {STRING_32} ": ")
			if attached {EB_RECYCLABLE} a_object as l_recyclable then
				a_row.set_background_color (create {EV_COLOR}.make_with_8_bit_rgb (230, 230, 230))
				if l_recyclable.is_recycled then
					l_description.append (once {STRING_32} "(Recycled) ")
					l_color := colors.stock_colors.dark_green
				else
					l_description.append (once {STRING_32} "(Not Recycled) ")
					l_color := colors.stock_colors.red
				end
			end
			l_description.append (a_object.generating_type.name_32)
			create l_item.make_with_text (l_description)
			if attached l_color then
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
			a_row.expand_actions.extend (agent execute_with_busy_cursor (agent populate_memory_grid_referer_subrows (a_row)))
			a_row.expand_actions.extend (agent execute_with_busy_cursor (agent on_collect))
		ensure
			a_row_is_expandable: a_row.is_expandable
		end

	populate_memory_grid_clouds (a_dynamic_type: INTEGER; a_parent_row: EV_GRID_ROW)
			-- For each object of type `a_dynamic_type' create a list of objects referencing them
			-- ordered by increasing number of reference to objects of type `a_dynamic_type.
			-- This list is inserted as a child node of `a_parent_row'.
		require
			output_grid_not_destroyed: not memory_map_grid.is_destroyed
			a_dynamic_type_non_negative: a_dynamic_type >= 0
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: SPECIAL [ANY]
			l_sorted_data: ARRAYED_LIST [TUPLE [obj: ANY; nb: NATURAL_32]]
			l_referers: SPECIAL [ANY]
			l_item: EV_GRID_LABEL_ITEM
			l_row_index: INTEGER
			l_row: EV_GRID_ROW
			l_any: ANY
			l_table: SED_OBJECTS_TABLE
			l_mapping: HASH_TABLE [TUPLE [obj: ANY; nb: NATURAL_32], NATURAL_32]
			l_entry: TUPLE [obj: ANY; nb: NATURAL_32]
			i, j, nb1, nb2: INTEGER
			k: NATURAL_32
			l_sorter: QUICK_SORTER [TUPLE [obj: ANY; nb: NATURAL_32]]
			l_agent_sorter: AGENT_EQUALITY_TESTER [TUPLE [obj: ANY; nb: NATURAL_32]]
		do
			if a_parent_row.subrow_count = 0 then
				l_data := memory.objects_instance_of_type (a_dynamic_type)
				if l_data /= Void then
						-- We need to disable the GC so that we can use the SED_OBJECTS_TABLE
						-- properly.
					on_collect
					memory.collection_off
						-- Iterate through all the referers of objects in `l_data'
						-- and insert them in `l_mapping' incrementing the count of
						-- references when already present.
					from
						create l_table.make (l_data.count.as_natural_32)
						create l_mapping.make (l_data.count)
						i := 0
						nb1 := l_data.count - 1
					until
						i > nb1
					loop
						l_referers := memory.referers (l_data.item (i))
						from
							j := 0
							nb2 := l_referers.count - 1
						until
							j > nb2
						loop
							l_any := l_referers.item (j)
							if l_any /= l_data and not is_data_result_of_analyzis (l_any) then
								k := l_table.index (l_any)
								l_entry := l_mapping.item (k)
								if l_entry /= Void then
									l_entry.nb := l_entry.nb + 1
								else
									l_mapping.put ([l_any, {NATURAL_32} 1], k)
								end
							end
							j := j + 1
						end
						i := i + 1
					end

						-- We are done with `l_table' so we can reenable the GC.
					l_table := Void
					memory.collection_on

						-- Put the data in a gobo container for sorting it based on the
						-- number of reference we have.
					create l_sorted_data.make (l_mapping.count)
					from
						l_mapping.start
					until
						l_mapping.after
					loop
						l_sorted_data.extend (l_mapping.item_for_iteration)
						l_mapping.forth
					end

					create l_agent_sorter.make (agent sort_on_cloud_entry)
					create l_sorter.make (l_agent_sorter)
					l_sorter.sort (l_sorted_data)
				end
				if l_sorted_data /= Void and then not l_sorted_data.is_empty then
					memory_map_grid.insert_new_rows_parented (l_sorted_data.count, a_parent_row.index + 1, a_parent_row)
					from
						l_sorted_data.start
						l_row_index := a_parent_row.index
						i := l_row_index + 1
					until
						l_sorted_data.after
					loop
						l_any := l_sorted_data.item_for_iteration.obj
						create l_item.make_with_text (l_any.generating_type.name_32)
						memory_map_grid.set_item (1, i, l_item)
						create l_item.make_with_text (($l_any).out)
						memory_map_grid.set_item (2, i, l_item)
						create l_item.make_with_text (l_sorted_data.item_for_iteration.nb.out)
						memory_map_grid.set_item (3, i, l_item)

						l_row := memory_map_grid.row (i)
						l_row.ensure_expandable
						l_row.set_data (l_any)
						l_row.expand_actions.extend (agent execute_with_busy_cursor (agent populate_memory_grid_referer_subrows (l_row)))
						l_row.expand_actions.extend (agent execute_with_busy_cursor (agent on_collect))

						i := i + 1
						l_sorted_data.forth
					end
				end
			end
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
			l_menu: EV_MENU
			l_menu_item: EV_MENU_ITEM
		do
				-- Only allow recycling in objects that are not used by the tool.
			if attached a_item.row.data as l_object and then not attached {like row_data} l_object then
				create l_menu
				create l_menu_item.make_with_text_and_action ("Go to object", agent (a_object: ANY) do execute_with_busy_cursor (agent select_object (a_object)) end (l_object))
				l_menu.extend (l_menu_item)
				l_menu.extend (create {EV_MENU_SEPARATOR})
				create l_menu_item.make_with_text_and_action ("Free object",  agent (a_object: ANY) do execute_with_busy_cursor (agent free_object (a_object)) end (l_object))
				l_menu.extend (l_menu_item)

				if attached {EB_RECYCLABLE} l_object as l_recycleable and then not l_recycleable.is_recycled then
						-- Add recycle option.
					create l_menu_item.make_with_text_and_action ("Perform recycle",  agent (a_object: EB_RECYCLABLE) do execute_with_busy_cursor (agent recycle_object (a_object)) end (l_recycleable))
					l_menu.extend (l_menu_item)
				end

					-- Display menu
				l_menu.show_at (a_item.parent, a_x, a_y)

				l_menu.destroy
			end
		end

feature {NONE} -- Sort handling

	enable_sorting_on_columns (a_columns: ARRAY [EV_GRID_COLUMN])
			-- Enables sorting on a selected set of columns
			--
			-- `a_columns': The columns to enable sorting on.
		require
			not_is_recycled: not is_recycled
			a_columns_attached: a_columns /= Void
		local
			l_wrapper: like grid_wrapper
			l_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EV_GRID_ROW]
			l_column: EV_GRID_COLUMN
			l_upper, i: INTEGER
		do
			l_wrapper := grid_wrapper
			l_wrapper.enable_auto_sort_order_change
			if l_wrapper.sort_action = Void then
				l_wrapper.set_sort_action (agent sort_handler)
			end

			from
				i := a_columns.lower
				l_upper := a_columns.upper
			until i > l_upper loop
				l_column := a_columns [i]
				check l_column_attached: l_column /= Void end
				if l_column /= Void then
						-- Set fake sorting routine as sorting is handled in `sort_handler'
					create l_sort_info.make (agent (a_row, a_other_row: EV_GRID_ROW; a_order: INTEGER_32): BOOLEAN do Result := False end, {EVS_GRID_TWO_WAY_SORTING_ORDER}.descending_order)
					l_sort_info.enable_auto_indicator
					l_wrapper.set_sort_info (l_column.index, l_sort_info)
				end
				i := i + 1
			end
		end

	sort_handler (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EV_GRID_ROW])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
			a_comparator_attached: a_comparator /= Void
		do
			if memory_data /= Void then
					-- Repopulate grid
				execute_with_busy_cursor (agent
					do
						clear_memory_grid
						sort_memory_data (memory_data)
						populate_memory_grid
					end)
			end
		end

	sort_memory_data (a_map: like memory_data)
			-- Sorts memory map by type name and returns a list of sorted associated type ids.
			--
			-- `a_table': Memory counter map table to sort.
			-- `Result': List of type id's sorted by their actual type name.
		require
			not_is_recycled: not is_recycled
			a_map_attached: a_map /= Void
		local
			l_last_sort_column: INTEGER
			l_last_sort_order: INTEGER
			l_sorter: QUICK_SORTER [like row_data]
			l_agent_sorter: AGENT_EQUALITY_TESTER [like row_data]
		do
			if is_initialized then
				l_last_sort_column := grid_wrapper.last_sorted_column
				if l_last_sort_column > 0 then
					l_last_sort_order := grid_wrapper.column_sort_info.item (l_last_sort_column).current_order
				end
			end
			if l_last_sort_column = 0 then
				l_last_sort_column := delta_column_index
				l_last_sort_order := {EVS_GRID_TWO_WAY_SORTING_ORDER}.descending_order
			end
			inspect
				l_last_sort_column
			when object_column_index then create l_agent_sorter.make (agent sort_on_type_name (?, ?, l_last_sort_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order))
			when count_column_index then create l_agent_sorter.make (agent sort_on_count (?, ?, l_last_sort_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order))
			when delta_column_index then create l_agent_sorter.make (agent sort_on_delta (?, ?, l_last_sort_order = {EVS_GRID_TWO_WAY_SORTING_ORDER}.ascending_order))
			end
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (a_map)
		end

feature {NONE} -- Analysis

	is_data_result_of_analyzis (a_data: ANY): BOOLEAN
			-- Is `a_data' indirectly the result of an internal operation of Current
		do
				-- If this is the row from our current grid, no need to show this object.
			Result := attached {EV_GRID_ROW} a_data as l_row and then l_row.parent = memory_map_grid
			if not Result then
					-- If this is the closed arguments tuple of one of our agent, no need to show this object.
				Result := (attached {TUPLE [like Current]} a_data as l_discardable_data)
			end
		end

	sort_on_type_name (u, v: like row_data; sorting_order: BOOLEAN): BOOLEAN
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		local
			l_string1, l_string2: STRING
		do
			l_string1 := u.name
			l_string2 := v.name
			check
				l_string1_not_void: l_string1 /= Void
				l_string2_not_void: l_string2 /= Void
			end
			if sorting_order then
				Result := l_string1 < l_string2
			else
				Result := l_string2 < l_string1
			end
		end

	sort_on_count (u, v: like row_data; sorting_order: BOOLEAN): BOOLEAN
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.instances < v.instances
			else
				Result := v.instances < u.instances
			end
		end

	sort_on_delta (u, v: like row_data; sorting_order: BOOLEAN): BOOLEAN
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.delta < v.delta
			else
				Result := v.delta < u.delta
			end
		end

	sort_on_cloud_entry (u, v: TUPLE [obj: ANY; nb: NATURAL_32]): BOOLEAN
			-- Compare u, v
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := u.nb > v.nb
		end

	calculate_memory_data (a_refresh: BOOLEAN)
			-- Calculates and analyzes the memory data.
			--
			-- `a_refresh': Causes pre-existing data to be discarded.
		local
			l_map: HASH_TABLE [INTEGER, INTEGER]
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
					l_map.put (0, l_id)
					l_last_map.forth
				end
			end

			from l_map.start until l_map.after loop
				l_id := l_map.key_for_iteration
				l_name := l_internal.type_name_of_type (l_id)
				l_count := l_map.item_for_iteration

				if l_last_map /= Void then
					l_delta := l_count - l_last_map.item (l_id)
				else
					l_delta := l_count
				end

				l_data.extend ([l_name, l_count, l_delta, l_id])
				l_map.forth
			end
			last_map := l_map

			sort_memory_data (l_data)
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
			l_usage: DOUBLE
			l_stat: STRING_32
			l_formatter: FORMAT_DOUBLE
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
			create l_formatter.make (10, 2)
			create Result.make (20)
			Result.append (l_formatter.formatted (l_usage))
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

	show_deltas_button: SD_TOOL_BAR_TOGGLE_BUTTON
			-- Show/hide positive deltas

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
					"The garbage collector is not collecting. Attempting to refresh the memory map with the GC running may causes the system to expand its memory usage or even deplete the available memory.",
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

	on_toogle_show_deltas
			-- Called when user toogle showing of deltas
			-- Note: Connected to `show_deltas_button'
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if attached develop_window_session_data as w_session_data then
					-- Set session data
				w_session_data.set_value (show_deltas_button.is_selected, show_deltas_only_session_id)
			end

				-- Refilter
			on_filter_update_timeout
		end

	on_toggle_memory_stats
			-- Call when user toggles showing of memory stats.
			-- Note: Connected to `show_memory_usage_button'
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
		do
			if attached develop_window_session_data as w_session_data then
					-- Set session data
				w_session_data.set_value (show_memory_usage_button.is_selected, show_memory_usage_session_id)
			end

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
			l_content: STRING_32
		do
			if memory_stats_text.is_displayed then
					-- Fetch stats
				l_eiffel_info := memory.memory_statistics ({MEM_CONST}.eiffel_memory)
				l_c_info := memory.memory_statistics ({MEM_CONST}.c_memory)
				l_all_info := memory.memory_statistics ({MEM_CONST}.total_memory)

					-- Create report
				create l_content.make (1024)
				l_content.append ("Eiffel Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ({STRING_32} "Total    : " + memory_stat (l_eiffel_info.total) + "%N")
				l_content.append ({STRING_32} "Used     : " + memory_stat (l_eiffel_info.used) + "%N")
				l_content.append ({STRING_32} "Overhead : " + memory_stat (l_eiffel_info.overhead) + "%N")
				l_content.append ({STRING_32} "Available: " + memory_stat (l_eiffel_info.free) + "%N")
				l_content.append ("---------------------------------%N%N")

				l_content.append ("C Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ({STRING_32} "Total    : " + memory_stat (l_c_info.total) + "%N")
				l_content.append ({STRING_32} "Used     : " + memory_stat (l_c_info.used) + "%N")
				l_content.append ({STRING_32} "Overhead : " + memory_stat (l_c_info.overhead) + "%N")
				l_content.append ({STRING_32} "Available: " + memory_stat (l_c_info.free) + "%N")
				l_content.append ("---------------------------------%N%N")

				l_content.append ("Total Memory Statistics:%N")
				l_content.append ("---------------------------------%N")
				l_content.append ({STRING_32} "Total    : " + memory_stat (l_all_info.total) + "%N")
				l_content.append ({STRING_32} "Used     : " + memory_stat (l_all_info.used) + "%N")
				l_content.append ({STRING_32} "Overhead : " + memory_stat (l_all_info.overhead) + "%N")
				l_content.append ({STRING_32} "Available: " + memory_stat (l_all_info.free) + "%N")
				l_content.append ("---------------------------------")

				ev_application.do_once_on_idle (agent memory_stats_text.set_text (l_content))
			end
		end

	on_filter_changed
			-- Called when the filter combo box text changes.
			-- Note: Connected to `filter_combo'.
		do
			if attached develop_window_session_data as w_session_data then
					-- Set session data
				w_session_data.set_value (filter_combo.text, filter_session_id)
			end

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
			l_count, i: INTEGER
			l_regex: like filter_match_expression
			l_show_only_deltas: like is_showing_positive_deltas
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
				l_show_only_deltas := is_showing_positive_deltas

				from i := 1 until i > l_count loop
					l_row := l_grid.row (i)
					if l_row.parent_row = Void then
						if attached {like row_data} l_row.data as l_data then
							if (attached l_regex implies l_regex.matches (l_data.name)) and (not l_show_only_deltas or else l_data.delta > 0) then
								l_row.show
							else
								l_row.hide
							end
						else
							check
								is_expected_data_type: False
							end
						end
					end
					i := i + l_row.subrow_count_recursive + 1
				end
			end

			filter_update_timer.set_interval (0)
		ensure
			filter_update_timer_reset: filter_update_timer.interval = 0
		end

feature {NONE} -- Memory pruning

	select_object (a_object: ANY)
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
			l_type_name: READABLE_STRING_32
			l_stop: BOOLEAN
		do
			l_type_name := a_object.generating_type.name_32

				-- Attempt to locate type row
			l_grid := memory_map_grid
			l_count := l_grid.row_count
			from i := 1 until i > l_count or l_stop loop
				l_row := l_grid.row (i)
				l_stop := attached {like row_data} l_row.data as l_data and then l_data.name.same_string_general (l_type_name)
				if not l_stop then
					i := i + l_row.subrow_count_recursive + 1
				end
			end

			if l_stop then
				check
					l_row_attached: l_row /= Void
				end
					-- Expand row to populate sub items (Clouds + Instances)
				l_row.expand
				if not l_row.is_show_requested then
						-- Ensure the row is always shown, because the filter might hide it.
					l_row.show
				end
					-- Get `Instances' node and expand it.
				l_row := l_grid.row (l_row.index + 2)
				l_row.expand
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

	free_object (a_object: ANY)
			-- Release an object.
		require
			is_initialized: is_initialized
			not_is_recycled: not is_recycled
			a_object_attached: a_object /= Void
		local
			l_address: STRING
			l_warning: ES_WARNING_PROMPT
			l_grid: like memory_map_grid
			l_count, i: INTEGER
			l_row: EV_GRID_ROW
		do
			if a_object /= Current and a_object /= tool_descriptor and a_object /= develop_window then
				l_address := ($a_object).out
				create l_warning.make_standard_with_cancel
					({STRING_32} "Freeing an object can harm this running application%NAre you sure you want to free " + a_object.generating_type.name_32 + {STRING_32} "(" + l_address.as_string_32 + {STRING_32} ")?")
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

	recycle_object (a_object: EB_RECYCLABLE)
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
						from
							j := 1;
							l_subrow_count := l_parent_row.subrow_count
						until
							j > l_subrow_count or l_index > 0
						loop
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

	create_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
			create Result.make (4)

			create refresh_button.make
			refresh_button.set_text ("Refresh")
			refresh_button.set_tooltip ("Refreshes the view to display the current system memory state.")
			register_action (refresh_button.select_actions, agent on_refresh_memory_map)
			Result.extend (refresh_button)

			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create collect_button.make
			collect_button.set_text ("Collect")
			collect_button.set_tooltip ("Forces a GC collection.")
			register_action (collect_button.select_actions, agent do execute_with_busy_cursor (agent on_collect) end)
			Result.extend (collect_button)

			create disable_collection_button.make
			disable_collection_button.set_text ("Surpress GC")
			disable_collection_button.set_tooltip ("Enables/Disables the GC.")
			if not is_gc_collecting then
				disable_collection_button.enable_select
			end
			register_action (disable_collection_button.select_actions, agent do execute_with_busy_cursor (agent on_toogle_collection) end)
			Result.extend (disable_collection_button)
		ensure then
			result_attached: Result /= Void
		end

	create_right_tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		local
			l_label: EV_LABEL
			l_widget: SD_TOOL_BAR_WIDGET_ITEM
			l_box: EV_HORIZONTAL_BOX
		do
			create Result.make (4)

			create l_box
			l_box.set_padding (6)
			create l_label.make_with_text ("Type filter:")
			l_box.extend (l_label)

			create filter_combo
			filter_combo.set_minimum_width (200)
			filter_combo.set_tooltip ("Enter a regular expression to filter the mapped list of types.")
			register_action (filter_combo.change_actions, agent on_filter_changed)
			l_box.extend (filter_combo)
			l_box.disable_item_expand (filter_combo)
			l_box.extend (create {EV_CELL})
			l_box.last.set_minimum_width (2)

			create l_widget.make (l_box)
			l_widget.set_name ("memory filter")
			Result.extend (l_widget)

			create show_deltas_button.make
			show_deltas_button.set_text ("Deltas Only")
			register_action (show_deltas_button.select_actions, agent on_toogle_show_deltas)
			Result.extend (show_deltas_button)

			Result.extend (create {SD_TOOL_BAR_SEPARATOR}.make)

			create show_memory_usage_button.make
			show_memory_usage_button.set_text ("Show Stats")
			show_memory_usage_button.set_tooltip ("Show/hide memory statistical information.")
			register_action (show_memory_usage_button.select_actions, agent on_toggle_memory_stats)
			Result.extend (show_memory_usage_button)

		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Constants

	memory_update_timer_interval: INTEGER = 1000
	filter_update_timer_interval: INTEGER = 500
	object_column_index: INTEGER = 1
	count_column_index: INTEGER = 2
	delta_column_index: INTEGER = 3

	filter_session_id: STRING_8 = "com.eiffel.memory_tool.filter"
	show_deltas_only_session_id: STRING_8 = "com.eiffel.memory_tool.show_deltas_only"
	show_memory_usage_session_id: STRING_8 = "com.eiffel.memory_tool.show_memory_usage"

feature {NONE} -- Internal implementation cache

	internal_filter_match_expression: CELL [like filter_match_expression]
			-- Cached version of `filter_match_expression'
			-- Note: do not use direcly!

	internal_grid_wrapper: like grid_wrapper
			-- Cached version of `grid_wrapper'
			-- Note: do not use directly!

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

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
