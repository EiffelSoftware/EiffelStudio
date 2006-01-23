indexing
	description: "Save memory states at differents point and analyze the difference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_MEMORY_CHANGE_MEDIATOR

inherit
	ANY

	MA_SINGLETON_FACTORY
		export
			{NONE} all
		end
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create states.make (10)
			grid_from_state := main_window.memory_spot_1
			grid_to_state := main_window.memory_spot_2
			grid_from_state.enable_single_row_selection
			grid_to_state.enable_single_row_selection
			grid_changed := main_window.increased_object_result

			create grid_data.make_default
			init_grid
			grid_changed.set_item_pebble_function (agent handle_pick_item)
			grid_changed.set_accept_cursor (accept_node_class)
			grid_changed.set_deny_cursor (deny_node_class)
		end

feature -- Command

	states_open_from_file is
			-- Open states from disk.
		local
			l_item: MA_MEMORY_STATE
			l_list: ARRAYED_LIST [MA_MEMORY_STATE]
		do
			states.open_states
			l_list := states.states
			from
				l_list.start
				grid_data.wipe_out
			until
				l_list.after
			loop
				l_item := l_list.item
				grid_data.force ([grid_state_prefix + l_list.index.out, l_item.objects_total_count, l_item.memory_used_eiffel, l_item.memory_used_c], l_list.index)
				l_list.forth
			end
			update_grid_content
		ensure
			grid_data_set: states.states.count = grid_data.count
		end

	states_save_to_file is
			-- Save states to a disk file.
		do
			states.save_states
		end

	adjust_widgets_layout is
			-- Adjust the split, 2 grids' positon and size to make it nice looking.
		do
			adjust_split_vertical
			adjust_split_horizontal
		end

	adjust_split_vertical is
			-- Adjust the split area (which ia at the top area)'s position.
		do
			main_window.split_incre.set_split_position ((main_window.split_incre.width / 2).ceiling)
		end

	adjust_split_horizontal is
			-- Adjust the split area (which ia at the bottom area)'s position.
		do
			main_window.split_incre_horizontal.set_split_position (main_window.split_incre_horizontal.minimum_split_position
				+ main_window.memory_spot_1.row_count * main_window.memory_spot_1.row_height + main_window.memory_spot_1.header.height)
		end

	adjust_column_width (a_column_index: INTEGER; a_grid: EV_GRID) is
			-- Adjust a column width to fix the max width of the item its contain.
		do
			if a_grid.row_count > 0 then
				a_grid.column (a_column_index).set_width (a_grid.column (a_column_index).required_width_of_item_span (1, a_grid.row_count))
			end
		end

	add_current_state is
			-- Save current memory state, show them in grid.
		local
			l_state: MA_MEMORY_STATE
		do
			system_util.collect
			create l_state.make_with_memory_map (memory.memory_count_map)
			states.extend (l_state)
			grid_data.force_last ([grid_state_prefix + states.count.out, l_state.objects_total_count,
			 l_state.memory_used_eiffel, l_state.memory_used_c])
			update_grid_content
		ensure
			states_add_one: states.count = old states.count + 1
		end

	show_object_count_changed is
			-- Show the object increased objects information in the result grid.
		local
			l_state_1, l_state_2: MA_MEMORY_STATE
			l_info_dlg: EV_INFORMATION_DIALOG
		do
			if grid_from_state.selected_rows.count > 0 then
				if grid_to_state.selected_rows.count > 0 then
					l_state_2 := states.i_th (grid_to_state.selected_rows.first.index)
					l_state_1 := states.i_th (grid_from_state.selected_rows.first.index)
					grid_util.grid_remove_and_clear_all_rows (grid_changed)
					grid_data_increased := l_state_1.compare (l_state_2)
					update_grid_increased_content
				else
					create l_info_dlg.make_with_text ("Please select a To State from the right grid.")
					l_info_dlg.show_relative_to_window (main_window)
				end
			else
				create l_info_dlg.make_with_text ("Please select a From State from the left grid.")
				l_info_dlg.show_relative_to_window (main_window)
			end
		end

	update_grid_content is
			-- Fill grid_from_state, grid_to_state using grid data.
		local
			l_item: EV_GRID_LABEL_ITEM
			l_i: INTEGER
		do
			from
				grid_data.start
				grid_util.grid_remove_and_clear_all_rows (grid_from_state)
				grid_util.grid_remove_and_clear_all_rows (grid_to_state)
				l_i := 1
			until
				grid_data.after
			loop
				-- set state name
				create l_item.make_with_text (grid_data.item (l_i).item (1).out)
				l_item.set_pixmap (icons.pixmap_file_content (icons.icon_system_state_from))
				grid_from_state.set_item (1, l_i, l_item.deep_twin)
				l_item.set_pixmap (icons.pixmap_file_content (icons.icon_system_state_to))
				grid_to_state.set_item (1, l_i, l_item)
				-- set object count
				create l_item.make_with_text (grid_data.item (l_i).item (2).out)
				grid_from_state.set_item (2, l_i, l_item.deep_twin)
				grid_to_state.set_item (2, l_i, l_item)

				-- set eiffel memory used
				create l_item.make_with_text (grid_data.item (l_i).item (3).out)
				grid_from_state.set_item (3,	l_i, l_item.deep_twin)
				grid_to_state.set_item (3,	l_i, l_item)
				-- set c memory used
				create l_item.make_with_text (grid_data.item (l_i).item (4).out)
				grid_from_state.set_item (4,	l_i, l_item.deep_twin)
				grid_to_state.set_item (4,	l_i, l_item)

				grid_data.forth
				l_i := l_i + 1
			end
		ensure
			grid_data_set: grid_from_state.row_count = grid_data.count and grid_to_state.row_count = grid_data.count
		end

feature {NONE} -- Implemention

	update_grid_increased_content  is
			-- Show the increased objects in the bottom result grid.
		local
			l_int: INTEGER
			l_item: EV_GRID_LABEL_ITEM
			l_i: INTEGER
		do
			from
				grid_data_increased.start
			until
				grid_data_increased.after
			loop
				if not filter.filter_class (grid_data_increased.item_for_iteration.item (1).out) then
					l_i := l_i + 1
					create l_item.make_with_text (grid_data_increased.item_for_iteration.item (1).out)
					l_item.set_pixmap (icons.pixmap_file_content (icons.icon_object_grid_class))
					grid_changed.set_item (1, l_i, l_item)
					l_int := grid_data_increased.item_for_iteration.integer_32_item (2)
					create l_item.make_with_text (l_int.out)
					if l_int > 0 then
						l_item.set_foreground_color (increased_color)
					else
						l_item.set_foreground_color (decreased_color)
					end
					grid_changed.set_item (2, l_i, l_item)
				end
				grid_data_increased.forth
			end
		end

	init_grid is
			-- Init the grid's title.
		do
			grid_from_state.insert_new_column (1)
			grid_from_state.insert_new_column (2)
			grid_from_state.insert_new_column (3)
			grid_from_state.insert_new_column (4)
			grid_from_state.column (1).set_title ("From state")
			grid_from_state.column (2).set_title ("Objects count")
			grid_from_state.column (3).set_title ("Effel memory used")
			grid_from_state.column (4).set_title ("C memory used")
			grid_from_state.column (1).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (1, grid_from_state))
			grid_from_state.column (2).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (2, grid_from_state))
			grid_from_state.column (3).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (3, grid_from_state))
			grid_from_state.column (4).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (4, grid_from_state))

			grid_to_state.insert_new_column (1)
			grid_to_state.insert_new_column (2)
			grid_to_state.insert_new_column (3)
			grid_to_state.insert_new_column (4)
			grid_to_state.column (1).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (1, grid_to_state))
			grid_to_state.column (2).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (2, grid_to_state))
			grid_to_state.column (3).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (3, grid_to_state))
			grid_to_state.column (4).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (4, grid_to_state))
			grid_to_state.column (1).set_title ("To state")
			grid_to_state.column (2).set_title ("Objects count")
			grid_to_state.column (3).set_title ("Effel memory used")
			grid_to_state.column (4).set_title ("C memory used")

			grid_changed.insert_new_column (1)
			grid_changed.insert_new_column (2)
			grid_changed.column (1).set_title ("Object type")
			grid_changed.column (2).set_title ("Delta")
			grid_changed.column (1).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (1))
			grid_changed.column (2).header_item.pointer_button_press_actions.force_extend (agent on_grid_header_click (2))
			grid_changed.column (1).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (1, grid_changed))
			grid_changed.column (2).header_item.pointer_double_press_actions.force_extend (agent adjust_column_width (2, grid_changed))
		ensure
			grid_from_state_column_set: grid_from_state.column_count = 4
			grid_to_state_column_set: grid_to_state.column_count = 4
			grid_changed_column_set: grid_changed.column_count = 2
		end

	on_grid_header_click (a_column_index: INTEGER) is
			-- User click on the column header of index `a_column_index'.
		require
			a_column_index_positive: a_column_index > 0
			a_column_index_not_too_big: a_column_index <= grid_changed.column_count
		do
			if grid_changed.header.pointed_divider_index = 0 then
				if sorted_column = a_column_index then
						-- We invert the sorting.
					sorting_order := not sorting_order
				else
					sorted_column := a_column_index
					sorting_order := False
				end
				if grid_data_increased /= Void then
					sort_data
					update_grid_increased_content
				end
			end
		end

	handle_pick_item (a_item: EV_GRID_LABEL_ITEM): MA_CLASS_STONE is
			-- User pick a item from grid to filter.
		do
			if a_item /= Void and a_item.column.index = 1 then
				Result := create {MA_CLASS_STONE}.make (a_item.text)
			end
		end

	sort_data is
			-- Sort `grid_data' according to `sorted_column' and `sorting_order'.
		local
			l_sorter: DS_QUICK_SORTER [like grid_data_increased_row]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [like grid_data_increased_row]
		do
			inspect
				sorted_column
			when 1 then create l_agent_sorter.make (agent sort_on_type_name)
			when 2 then create l_agent_sorter.make (agent sort_on_count)
			end
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (grid_data_increased)
		end

	sorting_order: BOOLEAN
			-- If True, sorted from the smaller to the bigger.

	sorted_column: INTEGER
			-- Column on which sorting is done.

	sort_on_type_name (u, v: like grid_data_increased_row): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.item (1).out < v.item (1).out
			else
				Result := u.item (1).out > v.item (1).out
			end
		end

	sort_on_count (u, v: like grid_data_increased_row): BOOLEAN is
			-- Compare u, v.
		require
			u_not_void: u /= Void
			v_not_void: v /= Void
		do
			if sorting_order then
				Result := u.integer_item (2) < v.integer_item (2)
			else
				Result := v.integer_item (2) < u.integer_item (2)
			end
		end

	grid_data_increased_row: TUPLE [STRING, INTEGER] is
			-- Anchor type should not called.
		require
			False
		do
		end


	grid_data_increased: DS_ARRAYED_LIST [like grid_data_increased_row]
			-- the objects increased, first INTEGER is increased object count, second INTEGER is the increased objects type id

	grid_data: DS_ARRAYED_LIST [like row_data]
			-- Data used to fill grid.

	row_data: TUPLE [STRING, INTEGER, INTEGER, INTEGER]
			-- Type for the data inserted in grid
			-- It is [Object Type Name, Effel Memory Used, C Memory Used, TypeId].

	grid_from_state, grid_to_state: EV_GRID -- Two grid show states.

	grid_changed: EV_GRID
			-- The grid to show objects increased.

	states: MA_MEMORY_STATE_MANAGER

	grid_state_prefix: STRING is "States: "
			-- The states grid prefix of first column.

invariant
	states_not_void: states /= Void
	grid_1_not_void: grid_from_state /= Void
	grid_2_not_void: grid_to_state /= Void
	grid_increased_not_void: grid_changed /= Void
	main_window_not_void: main_window /= Void
	grid_data_not_void: grid_data /= Void
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
