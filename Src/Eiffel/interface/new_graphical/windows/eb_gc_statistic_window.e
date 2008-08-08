indexing
	description: "[
		Window to perform GC statistics.

		Trick: Each time we expand a node we launch a GC cycle to get rid of the garbage
		created to compute the information. This cannot be done within the action because
		the generated code may have some hidden temporary locals still referencing some
		temporary objects, this is why for all `expand_actions' we always call `collect'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GC_STATISTIC_WINDOW

create
	make

feature {NONE} -- Initialization

	make (a_font: EV_FONT) is
			-- Initialize current with `a_font' which will be used to display GC statistics.
		require
			a_font_not_void: a_font /= Void
			a_font_not_destroyed: not a_font.is_destroyed
		local
			l_vbar: EV_VERTICAL_BOX
			l_toolbar: EV_TOOL_BAR
			l_titem: EV_TOOL_BAR_BUTTON
			l_toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			create window.make_with_title ("GC statistics")
			create l_vbar
			window.extend (l_vbar)

				-- Create toolbar and associated toolbar buttons
			create l_toolbar
			l_vbar.extend (l_toolbar)
			l_vbar.disable_item_expand (l_toolbar)

			create l_titem.make_with_text ("Collect")
			l_titem.select_actions.extend (agent collect)
			l_toolbar.extend (l_titem)

			create l_titem.make_with_text ("Mem update")
			l_titem.select_actions.extend (agent show_memory_usage)
			l_toolbar.extend (l_titem)

			create l_titem.make_with_text ("Mem map")
			l_titem.select_actions.extend (agent show_memory_map)
			l_toolbar.extend (l_titem)

			create l_toggle_button.make_with_text ("Disable GC")
			l_toggle_button.select_actions.extend (agent toggle_gc (l_toggle_button))
			l_toolbar.extend (l_toggle_button)

				-- Create display_container
			create display_container
			display_container.set_minimum_size (350, 300)
			l_vbar.extend (display_container)

				-- Create output
			create output_text
			output_text.set_font (a_font)

				-- Create grid
			create output_grid
			output_grid.enable_tree
			output_grid.enable_partial_dynamic_content
			output_grid.insert_new_column (1)
			output_grid.insert_new_column (2)
			output_grid.insert_new_column (3)
			output_grid.column (1).set_title ("Object Type")
			output_grid.column (2).set_title ("Count")
			output_grid.column (3).set_title ("Delta")
			output_grid.column (1).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (1))
			output_grid.column (2).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (2))
			output_grid.column (3).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (3))

				-- We sort on `Count' column by default
			sorted_column := 2

			window.close_request_actions.extend (agent window.hide)
		end

feature -- Update

	show is
			-- Show Current
		do
			window.raise
		end

	show_memory_usage is
			-- Update `output_text' with current memory usage.
		local
			eiffel_mem_info, c_mem_info, total_mem_info: MEM_INFO
			l_content: STRING
		do
			show_output_text
			collect

			eiffel_mem_info := mem.memory_statistics ({MEM_CONST}.eiffel_memory)
			c_mem_info := mem.memory_statistics ({MEM_CONST}.c_memory)
			total_mem_info := mem.memory_statistics ({MEM_CONST}.total_memory)

			create l_content.make_empty
			l_content.append ("Eiffel total memory   : " + eiffel_mem_info.total.out + "%N")
			l_content.append ("Eiffel used memory    : " + eiffel_mem_info.used.out + "%N")
			l_content.append ("Eiffel overhead memory: " + eiffel_mem_info.overhead.out + "%N")
			l_content.append ("Eiffel free memory    : " + eiffel_mem_info.free.out + "%N%N")

			l_content.append ("C total memory        : " + c_mem_info.total.out + "%N")
			l_content.append ("C used memory         : " + c_mem_info.used.out + "%N")
			l_content.append ("C overhead memory     : " + c_mem_info.overhead.out + "%N")
			l_content.append ("C free memory         : " + c_mem_info.free.out + "%N%N")

			l_content.append ("Total memory          : " + total_mem_info.total.out + "%N")
			l_content.append ("Total used memory     : " + total_mem_info.used.out + "%N")
			l_content.append ("Total overhead memory : " + total_mem_info.overhead.out + "%N")
			l_content.append ("Total free memory     : " + total_mem_info.free.out + "%N")

			output_text.set_text (l_content)
		end

	show_memory_map is
			-- Show memory map
		local
			l_new_table, l_old_table: HASH_TABLE [INTEGER, INTEGER]
			i: INTEGER
			l_int: INTERNAL
			l_name: STRING
			l_count, l_delta: INTEGER
			l_data: like grid_data
		do
			show_output_grid

				-- Get the data right away.
			collect
			l_new_table := mem.memory_count_map

				-- Process `l_new_table' and fill `output_grid' with associated data.
			from
				create l_int
				l_new_table.start
				l_old_table := last_table
				create l_data.make (l_new_table.count)
				i := 1
			until
				l_new_table.after
			loop
				l_name := l_int.type_name_of_type (l_new_table.key_for_iteration)
				l_count := l_new_table.item_for_iteration

					-- Compute `l_delta' now.
				if l_old_table /= Void then
					l_old_table.search (l_new_table.key_for_iteration)
					if l_old_table.found then
						l_delta := l_new_table.item_for_iteration - l_old_table.found_item
						l_old_table.remove (l_new_table.key_for_iteration)
					else
						l_delta := l_new_table.item_for_iteration
					end
				else
					l_delta := l_new_table.item_for_iteration
				end
				l_data.force ([l_name, l_count, l_delta, l_new_table.key_for_iteration], i)
				i := i + 1
				l_new_table.forth
			end

			if l_old_table /= Void and then not l_old_table.is_empty then
				from
					l_old_table.start
				until
					l_old_table.after
				loop
					l_name := l_int.type_name_of_type (l_old_table.key_for_iteration)
					l_count := 0
					l_delta := - l_old_table.item_for_iteration
					l_data.force ([l_name, l_count, l_delta, l_old_table.key_for_iteration], i)
					i := i + 1
					l_old_table.forth
				end
			end

			last_table := l_new_table
			grid_data := l_data

			sort_data
			update_grid_content
		end

	collect is
			-- Perform a GC cycle.
		do
			mem.full_collect
		end

	toggle_gc (a_button: EV_TOOL_BAR_TOGGLE_BUTTON) is
			-- Disable or enable GC
		require
			a_button_not_void: a_button /= Void
		do
			if a_button.is_selected then
				mem.collection_off
				a_button.set_text ("Enable GC")
			else
				mem.collection_on
				a_button.set_text ("Disable GC")
			end
		end

feature {NONE} -- Access

	window: EV_TITLED_WINDOW
			-- Window containing the GC statistics.

	display_container: EV_CELL
			-- Container for `output_text' and others.

	output_text: EV_TEXT
			-- Text control that contains the GC statistics.

	output_grid: EV_GRID
			-- Grid control used to show memory map.

	mem: MEMORY is
			-- Access to MEMORY routines
		once
			create Result
		ensure
			mem_not_void: mem /= Void
		end

	last_table: HASH_TABLE [INTEGER, INTEGER]
			-- Result of last call to `mem.memory_map_count' in `show_memory_map'.

	grid_data: DS_ARRAYED_LIST [like row_data]
			-- Data used to fill grid.

	sorted_column: INTEGER
			-- Column on which sorting is done.

	sorting_order: BOOLEAN
			-- If True, sorted from the smaller to the bigger.

	red_color: EV_COLOR is
			-- Red color
		once
			Result := (create {EV_STOCK_COLORS}).red
		ensure
			red_color_set: Result /= Void
		end

	green_color: EV_COLOR is
			-- Green color
		once
			Result := (create {EV_STOCK_COLORS}).dark_green
		ensure
			green_color_set: Result /= Void
		end

	row_data: TUPLE [type_name: STRING; nb: INTEGER; delta: INTEGER; type_id:INTEGER] is
			-- Type for the data inserted in `output_grid'
			-- It is [type_name, number_of_objects, variation_since_last_time, type_id].
		do
		end

feature {NONE} -- Implementation

	show_output_text is
			-- Show `output_text' if not yet visible.
		require
			window_not_void: display_container /= Void
			window_not_destroyed: not display_container.is_destroyed
			window_shown: display_container.is_displayed
		do
			if output_grid.row_count >= 1 then
				output_grid.remove_rows (1, output_grid.row_count)
			end
			output_text.remove_text
			if display_container.full then
				if display_container.item /= output_text then
					display_container.replace (output_text)
				end
			else
				display_container.put (output_text)
			end
		ensure
			output_text_shown: output_text.is_displayed
			output_text_empty: output_text.text_length = 0
			output_grid_not_show: not output_grid.is_displayed
			output_grid_empty: output_grid.row_count = 0
		end

	show_output_grid is
			-- Show `output_grid' if not yet visible.
		require
			window_not_void: display_container /= Void
			window_not_destroyed: not display_container.is_destroyed
			window_shown: display_container.is_displayed
		do
			if output_grid.row_count >= 1 then
				output_grid.remove_rows (1, output_grid.row_count)
			end
			output_text.remove_text
			if display_container.full then
				if display_container.item /= output_grid then
					display_container.replace (output_grid)
				end
			else
				display_container.put (output_grid)
			end
		ensure
			output_grid_shown: output_grid.is_displayed
			output_grid_empty: output_grid.row_count = 0
			output_text_not_show: not output_text.is_displayed
			output_text_empty: output_text.text_length = 0
		end

	on_grid_header_click (a_column_index: INTEGER) is
			-- User click on the column header of index `a_column_index'.
		require
			a_column_index_positive: a_column_index > 0
			output_grid_not_destroyed: not output_grid.is_destroyed
			a_column_index_not_too_big: a_column_index <= output_grid.column_count
		do
			if output_grid.header.pointed_divider_index = 0 then
				if sorted_column = a_column_index then
						-- We invert the sorting.
					sorting_order := not sorting_order
				else
					sorted_column := a_column_index
					sorting_order := False
				end
				if grid_data /= Void then
					sort_data
					update_grid_content
				end
			end
		end

	update_grid_content is
			-- Fill grid using `grid_data'
		require
			grid_data_not_void: grid_data /= Void
		local
			l_data: like grid_data
			l_row_data: like row_data
			l_item: EV_GRID_LABEL_ITEM
			i, l_count, l_delta: INTEGER
			l_str: STRING
			l_row: EV_GRID_ROW
			l_grid: like output_grid
		do
			from
				l_data := grid_data
				l_grid := output_grid
				if output_grid.row_count >= 1 then
					output_grid.remove_rows (1, output_grid.row_count)
				end
				i := 1
				l_data.start
			until
				l_data.after
			loop
				l_row_data := l_data.item_for_iteration
				l_str := l_row_data.type_name
				check
					l_str_not_void: l_str /= Void
				end

					-- Set type name
				create l_item.make_with_text (l_str)
				l_grid.set_item (1, i, l_item)

					-- Set count
				l_count := l_row_data.nb
				create l_item.make_with_text (l_count.out)
				l_grid.set_item (2, i, l_item)

					-- Set delta
				l_delta := l_row_data.delta
				if l_delta /= 0 then
					create l_item.make_with_text (l_delta.out)
					if l_delta > 0 then
						l_item.set_foreground_color (red_color)
					else
						l_item.set_foreground_color (green_color)
					end
					l_grid.set_item (3, i, l_item)
				end

				if l_count >= 1 then
					l_row := l_grid.row (i)
					i := i + 1
					l_grid.insert_new_rows_parented (2, i, l_row)
					create l_item.make_with_text ("Clouds of referers")
					l_grid.set_item (1, i, l_item)
					l_row := l_grid.row (i)
					l_row.ensure_expandable
					l_row.expand_actions.extend (agent on_expand_actions_for_clouds (l_row_data.type_id, l_row))
					l_row.expand_actions.extend (agent collect)

					i := i + 1
					create l_item.make_with_text ("Instances")
					l_grid.set_item (1, i, l_item)
					l_row := l_grid.row (i)
					l_row.ensure_expandable
					l_row.expand_actions.extend (agent on_expand_actions_for_type (l_row_data.type_id, l_row))
					l_row.expand_actions.extend (agent collect)
				end

				i := i + 1
				l_data.forth
			end
		end

	on_expand_actions_for_clouds (a_dynamic_type: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- For each object of type `a_dynamic_type' create a list of objects referencing them
			-- ordered by increasing number of reference to objects of type `a_dynamic_type.
			-- This list is inserted as a child node of `a_parent_row'.
		require
			output_grid_not_destroyed: not output_grid.is_destroyed
			a_dynamic_type_non_negative: a_dynamic_type >= 0
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: SPECIAL [ANY]
			l_sorted_data: DS_ARRAYED_LIST [TUPLE [obj: ANY; nb: NATURAL_32]]
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
			l_sorter: DS_QUICK_SORTER [TUPLE [obj: ANY; nb: NATURAL_32]]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [TUPLE [obj: ANY; nb: NATURAL_32]]
		do
			if a_parent_row.subrow_count = 0 then
				l_data := mem.objects_instance_of_type (a_dynamic_type)
				if l_data /= Void then
						-- We need to disable the GC so that we can use the SED_OBJECTS_TABLE
						-- properly.
					collect
					mem.collection_off
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
						l_referers := mem.referers (l_data.item (i))
						from
							j := 0
							nb2 := l_referers.count - 1
						until
							j > nb2
						loop
							if l_referers.item (j) /= l_data then
								k := l_table.index (l_referers.item (j))
								l_entry := l_mapping.item (k)
								if l_entry /= Void then
									l_entry.nb := l_entry.nb + 1
								else
									l_mapping.put ([l_referers.item (j), {NATURAL_32} 1], k)
								end
							end
							j := j + 1
						end
						i := i + 1
					end

						-- We are done with `l_table' so we can reenable the GC.
					l_table := Void
					mem.collection_on

						-- Put the data in a gobo container for sorting it based on the
						-- number of reference we have.
					create l_sorted_data.make (l_mapping.count)
					from
						l_mapping.start
					until
						l_mapping.after
					loop
						l_sorted_data.force_last (l_mapping.item_for_iteration)
						l_mapping.forth
					end

					create l_agent_sorter.make (agent sort_on_cloud_entry)
					create l_sorter.make (l_agent_sorter)
					l_sorted_data.sort (l_sorter)
				end
				if l_sorted_data /= Void then
					output_grid.insert_new_rows_parented (l_sorted_data.count, a_parent_row.index + 1, a_parent_row)
					from
						l_sorted_data.start
						l_row_index := a_parent_row.index
						i := l_row_index + 1
					until
						l_sorted_data.after
					loop
						l_any := l_sorted_data.item_for_iteration.obj
						create l_item.make_with_text (l_any.generating_type)
						output_grid.set_item (1, i, l_item)
						create l_item.make_with_text (($l_any).out)
						output_grid.set_item (2, i, l_item)
						create l_item.make_with_text (l_sorted_data.item_for_iteration.nb.out)
						output_grid.set_item (3, i, l_item)

						l_row := output_grid.row (i)
						l_row.ensure_expandable
						l_row.expand_actions.extend (agent on_expand_actions_for_referers (l_any, l_row))
						l_row.expand_actions.extend (agent collect)

						i := i + 1
						l_sorted_data.forth
					end
				end
			end
		end

	on_expand_actions_for_type (a_dynamic_type: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Add all objects of the given dynamic type of `a_dynamic_type' as subnode
			-- of row `a_parent_row'.
		require
			output_grid_not_destroyed: not output_grid.is_destroyed
			a_dynamic_type_non_negative: a_dynamic_type >= 0
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: SPECIAL [ANY]
			l_item: EV_GRID_LABEL_ITEM
			l_row_index, i, j, nb: INTEGER
			l_row: EV_GRID_ROW
			l_any: ANY
		do
			if a_parent_row.subrow_count = 0 then
				l_data := mem.objects_instance_of_type (a_dynamic_type)
				if l_data /= Void then
					output_grid.insert_new_rows_parented (l_data.count, a_parent_row.index + 1, a_parent_row)
					from
						l_row_index := a_parent_row.index
						i := l_row_index + 1
						j := 0
						nb := l_data.count - 1
					until
						j > nb
					loop
						create l_item.make_with_text ((i - l_row_index).out)
						output_grid.set_item (1, i, l_item)
						l_any := l_data.item (j)
						create l_item.make_with_text (($l_any).out)
						output_grid.set_item (2, i, l_item)

						l_row := output_grid.row (i)
						l_row.ensure_expandable
						l_row.expand_actions.extend (agent on_expand_actions_for_referers (l_any, l_row))
						l_row.expand_actions.extend (agent collect)

						i := i + 1
						j := j + 1
					end
				end
			end
		end

	on_expand_actions_for_referers (an_object: ANY; a_parent_row: EV_GRID_ROW) is
			-- Add all objects referring to `an_object' as subnode
			-- of row `a_parent_row'.
		require
			output_grid_not_destroyed: not output_grid.is_destroyed
			an_object_not_void: an_object /= Void
			a_parent_row_not_void: a_parent_row /= Void
		local
			l_data: SPECIAL [ANY]
			l_item: EV_GRID_LABEL_ITEM
			l_row_index: INTEGER
			i, j, nb, l_count: INTEGER
			l_int: INTERNAL
			l_any: ANY
			l_row: EV_GRID_ROW
		do
			if a_parent_row.subrow_count = 0 then
				l_data := mem.referers (an_object)
				if l_data /= Void then
					from
						j := 0
						nb := l_data.count
					until
						j = nb
					loop
							-- Compute number of real elements that are going to be inserted.
						if not ({l_discardable_data_1: TUPLE [like Current]} l_data.item (j)) then
							l_count := l_count + 1
						end
						j := j + 1
					end

					from
						create l_int
						l_row_index := a_parent_row.index
						i := l_row_index + 1
						j := 0
						output_grid.insert_new_rows_parented (l_count, i, a_parent_row)
					until
						j = nb
					loop
						l_any := l_data.item (j)
							-- We are not interested in seeing objects of the grid
						if not ({l_discardable_data_2: TUPLE [like Current]} l_any) then
							create l_item.make_with_text ((i - l_row_index).out + ": " + l_int.type_name (l_any))
							output_grid.set_item (1, i, l_item)
							create l_item.make_with_text (($l_any).out)
							output_grid.set_item (2, i, l_item)

							l_row := output_grid.row (i)
							l_row.ensure_expandable
							l_row.expand_actions.extend (agent on_expand_actions_for_referers (l_any, l_row))
							l_row.expand_actions.extend (agent collect)
							i := i + 1
						end
						j := j + 1
					end
				end
			end
		end

	sort_data is
			-- Sort `grid_data' according to `sorted_column' and `sorting_order'.
		require
			grid_data_not_void: grid_data /= Void
		local
			l_sorter: DS_QUICK_SORTER [like row_data]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [like row_data]
		do
			inspect
				sorted_column
			when 1 then create l_agent_sorter.make (agent sort_on_type_name)
			when 2 then create l_agent_sorter.make (agent sort_on_count)
			when 3 then create l_agent_sorter.make (agent sort_on_delta)
			end
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (grid_data)
		end

	sort_on_type_name (u, v: like row_data): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		local
			l_string1, l_string2: STRING
		do
			l_string1 := u.type_name
			l_string2 := v.type_name
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

	sort_on_count (u, v: like row_data): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.nb < v.nb
			else
				Result := v.nb < u.nb
			end
		end

	sort_on_delta (u, v: like row_data): BOOLEAN is
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

	sort_on_cloud_entry (u, v: TUPLE [obj: ANY; nb: NATURAL_32]): BOOLEAN is
			-- Compare u, v
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			Result := u.nb > v.nb
		end

invariant
	window_not_void: window /= Void
	display_container_not_void: display_container /= Void
	output_text_not_void: output_text /= Void
	output_grid_not_void: output_grid /= Void

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
