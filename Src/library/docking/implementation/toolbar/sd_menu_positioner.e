indexing
	description: "[
					Objects that manage tool bar positions for a SD_TOOL_BAR_ROW.
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ROW_POSITIONER

create
	make

feature {NONE}  -- Initlization

	make (a_tool_bar_row: SD_TOOL_BAR_ROW) is
			-- Creation method.
		require
			not_void: a_tool_bar_row /= Void
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_shared: SD_SHARED
		do
			create l_shared
			create internal_sizer.make (a_tool_bar_row)
			l_tool_bars := a_tool_bar_row.tool_bar_zones
			internal_tool_bar_row := a_tool_bar_row
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
			-- Because tool bar row may be created when dragging. `on_pointer_motion' will call `positions_and_sizes_try'.
			create positions_and_sizes_try.make (1)
		ensure
			set: internal_tool_bar_row = a_tool_bar_row
		end

feature -- Command

	position_resize_on_extend (a_new_tool_bar: SD_TOOL_BAR_ZONE; a_relative_pointer_position: INTEGER) is
			-- When extend `a_new_tool_bar', if not `is_enough_max_space', then resize tool bars.
		require
			has: has (a_new_tool_bar)
		local
			l_hot_index: INTEGER
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_last_end_position: INTEGER
		do
			debug ("docking")
				print ("%N ^^^^^^^^^^^^^^^^^^^ SD_TOOL_BAR_ROW_POSITIONER position_resize_on_extend ^^^^^^^^^^^^^^^^^^")
			end
			if is_dragging then
				check new_tool_bar_is_caller: a_new_tool_bar = internal_mediator.caller end
				internal_sizer.resize_on_extend (a_new_tool_bar)
				l_hot_index := put_hot_tool_bar_at (a_relative_pointer_position)
				l_tool_bars := internal_tool_bar_row.tool_bar_zones
				l_tool_bars.delete (a_new_tool_bar)
				if l_hot_index = 0 then
					internal_tool_bar_row.internal_set_item_position (a_new_tool_bar, 0)
					l_last_end_position := a_new_tool_bar.size
				end
				from
					l_tool_bars.start
				until
					l_tool_bars.after
				loop
					debug ("docking")
						print ("%N ^^^^^^^^^^^^^^^^^^^ SD_TOOL_BAR_ROW_POSITIONER position_resize_on_extend 2 l_last_end_position: ^^^^^^^^^^^^^^^^^^" + l_last_end_position.out)
					end
					internal_tool_bar_row.internal_set_item_position (l_tool_bars.item_for_iteration, l_last_end_position + 1)
					l_last_end_position := l_tool_bars.item_for_iteration.position + l_tool_bars.item_for_iteration.size

					if l_tool_bars.index = l_hot_index then
						internal_tool_bar_row.internal_set_item_position (a_new_tool_bar, l_last_end_position + 1)
						debug ("docking")
							print ("%N ^^^^^^^^^^^^^^^^^^^ SD_TOOL_BAR_ROW_POSITIONER position_resize_on_extend 3 l_last_end_position: ^^^^^^^^^^^^^^^^^^" + l_last_end_position.out)
						end
						l_last_end_position := a_new_tool_bar.position + a_new_tool_bar.size
					end
					l_tool_bars.forth
				end
			end
		end

	position_resize_on_prune is
			-- Position and resize tool bars when prune a tool bar from Current.
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_tool_bar: SD_TOOL_BAR_ZONE
			l_positions_and_sizes: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
		do
			internal_sizer.resize_on_prune
			debug ("docking")
				print ("%NSD_TOOL_BAR_ROW_POSITIONER position_resize_on_prune OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO")
			end
			l_positions_and_sizes := zones_last_states (is_dragging)
			if internal_sizer.is_enough_max_space (False) then
				l_tool_bars := internal_tool_bar_row.tool_bar_zones
				debug ("docking")
					print ("%N                                                   XXXXXXXXXXXXXXXXXXXXXXXXXX l_tool_bars.count: " + l_tool_bars.count.out)
				end
				from
					l_tool_bars.start
					l_positions_and_sizes.start
				until
					l_tool_bars.after
				loop
					l_tool_bar := l_tool_bars.item_for_iteration
					-- User dragged tool bar out of current row
					-- We reset orignal position.
					l_tool_bar.row.set_item_position_relative (l_tool_bar, l_positions_and_sizes.item.integer_32_item (1))
					l_tool_bars.forth
					l_positions_and_sizes.forth
				end
			end
			debug ("docking")
				print ("%N                                                   ENNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNND")
			end
		end

	on_pointer_motion (a_relative_position: INTEGER) is
			-- Handle pointer motion in Current. Position dragging tool bar and others.
		require
			is_dragging: is_dragging
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_hot_index: INTEGER
		do
			l_hot_index := put_hot_tool_bar_at (a_relative_position)
			try_set_position (a_relative_position, l_hot_index)
			if is_possible_set_position (a_relative_position, l_hot_index) then
				from
					l_tool_bars := internal_tool_bar_row.tool_bar_zones
					l_tool_bars.delete (internal_mediator.caller)
					internal_tool_bar_row.internal_set_item_position (internal_mediator.caller, a_relative_position)
					positions_and_sizes_try.start
					l_tool_bars.start
					debug ("docking")
						if not (positions_and_sizes (True).count = l_tool_bars.count) then
							print ("%NSD_TOOL_BAR_ROW_POSITIONER: on_pointer_motion: Routine failer")
							print ("%N                                               positions_and_sizes (False).count: " + positions_and_sizes (False).count.out)
							print ("%N                                               l_tool_bars.count: " + l_tool_bars.count.out)
						end
					end
					check right_size: positions_and_sizes (True).count = l_tool_bars.count end
				until
					positions_and_sizes_try.after
				loop
					internal_tool_bar_row.internal_set_item_position (l_tool_bars.item_for_iteration, positions_and_sizes_try.item.integer_32_item (1))
					l_tool_bars.forth
					positions_and_sizes_try.forth
				end
			end
		end

	start_drag is
			-- Do prepare works when user start dragging.
		local
			l_shared: SD_SHARED
		do
			create l_shared
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
			internal_sizer.start_drag_prepare
			record_positions_and_sizes (True)
			positions_and_sizes_try := zones_last_states (True)
		end

	end_drag is
			-- Do clean works when user end dragging.
		do
			internal_mediator := Void
			internal_sizer.end_drag_clean
			record_positions_and_sizes (False)
		end

	on_resize (a_size: INTEGER) is
			-- Handle docking manger main window resize events.
			-- a_size is width when row is horizontal
			-- a_size is height when row is vertical
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_last_end_postion: INTEGER
		do
			internal_tool_bar_row.set_ignore_resize (True)
			internal_sizer.on_resize (a_size)
			if internal_sizer.is_enough_max_space (False) then
				-- Position from right to left
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW_POSITIONER [enough max space]")
				end
				position_tool_bar_back_to_front (a_size)
			else
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW_POSITIONER [NOT enough max space]")
				end
				-- All tool bar position must be one by one.
				from
					l_zones := internal_tool_bar_row.tool_bar_zones
					l_last_end_postion := 1
					l_zones.start
				until
					l_zones.after
				loop
					internal_tool_bar_row.internal_set_item_position (l_zones.item_for_iteration, l_last_end_postion)

					l_last_end_postion := l_zones.item_for_iteration.size + 1 + l_last_end_postion
					debug ("docking")
						print ("%N SD_TOOL_BAR_ROW_POSITIONER on_resize tool_bra_zone position: " + l_zones.item_for_iteration.x_position.out)
					end
					l_zones.forth
				end
			end
			internal_tool_bar_row.set_ignore_resize (False)
		end

	record_positions_and_sizes (a_except_dragged_tool_bar: BOOLEAN) is
			-- Record position and size.
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_state: SD_TOOL_BAR_ZONE_STATE
		do
			debug ("docking")
				print ("%N OOOOOOOOOOOOOOOOO SD_TOOL_BAR_POSITIONER record positions and sizes OOOOOOOOOOOO")
			end
			from
				l_tool_bars := internal_tool_bar_row.tool_bar_zones
				if a_except_dragged_tool_bar then
					check not_void: internal_mediator /= Void end
					l_tool_bars.delete (internal_mediator.caller)
				end

				l_tool_bars.start
			until
				l_tool_bars.after
			loop
				l_state := l_tool_bars.item_for_iteration.assistant.last_state
				l_state.set_position (l_tool_bars.item_for_iteration.position)
				l_state.set_size (l_tool_bars.item_for_iteration.size)
				l_tool_bars.forth
			end
		end

feature -- Query

	has (a_widget: EV_WIDGET): BOOLEAN is
			-- If `internal_tool_bar_row' has a_widget?
		do
			Result := internal_tool_bar_row.has (a_widget)
		end

	is_dragging: BOOLEAN is
			-- If user dragging a tool bar now?
		do
			Result := internal_mediator /= Void
		end

	internal_sizer: SD_TOOL_BAR_ROW_SIZER
			-- Tool bar sizer.

feature {NONE}  -- Implementation

	position_one_by_one (a_hot_index: INTEGER) is
			-- Position `positions_and_sizes' one by one.
		require
			enough_space: internal_sizer.is_enough_space (True, internal_tool_bar_row.size)
		local
			l_last_position: INTEGER
		do
			from
				l_last_position := 1
				positions_and_sizes_try.start
			until
				positions_and_sizes_try.after
			loop
				if a_hot_index = positions_and_sizes_try.index - 1 then
					l_last_position := l_last_position + internal_mediator.caller.size
				end
				positions_and_sizes_try.item.put_integer_32 (l_last_position, 1)
				l_last_position := l_last_position + positions_and_sizes_try.item.integer_32_item (2) + 1
				positions_and_sizes_try.forth
			end
		end

	position_tool_bar_back_to_front (a_size: INTEGER) is
			-- Position SD_TOOL_BAR_ZONEs when there is enough space,
			-- From right to left, or from bottom to up.
		require
			enough_max_space: internal_sizer.is_enough_max_space (False)
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_zone: SD_TOOL_BAR_ZONE
			l_last_start_position: INTEGER
		do
			from
				l_zones := internal_tool_bar_row.tool_bar_zones
				l_last_start_position := a_size
				l_zones.finish
				l_zones.finish
			until
				l_zones.before
			loop
				debug ("docking")
					print ("%NSD_TOOL_BAR_ROW_POSITIONER positione_tool_bar_back_to_front a_size: " + a_size.out)
				end
				l_zone := l_zones.item_for_iteration
				if l_zones.item_for_iteration.assistant.last_state.position + l_zone.size < l_last_start_position then
					-- We can position it to orignal position.
					internal_tool_bar_row.internal_set_item_position (l_zone, l_zones.item_for_iteration.assistant.last_state.position)
					debug ("docking")
						print ("%N********** SD_TOOL_BAR_ROW_POSITIONER position_tool_bar_right_to_left ********** 1")
					end
				else
					internal_tool_bar_row.internal_set_item_position (l_zone, l_last_start_position - 1 - l_zone.size)
					debug ("docking")
						print ("%N********** SD_TOOL_BAR_ROW_POSITIONER position_tool_bar_right_to_left ********** 2")
					end
				end
				l_last_start_position := l_zone.position
				l_zones.back
			end
		end

	put_hot_tool_bar_at (a_position: INTEGER): INTEGER is
			-- Which index we should put hot tool bar?
			-- 0 is before 1st tool bar, 1 is after 1st tool bar, 2 is after 2nd tool bar...
			-- a_position is relative position.
		local
			l_found: BOOLEAN
			l_last_end_position: INTEGER
			l_positions_and_sizes: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
		do
			l_positions_and_sizes := positions_and_sizes (True)
			if l_positions_and_sizes.count > 0 and then a_position <= l_positions_and_sizes.first.integer_32_item (1) then
				l_found := True
				Result := 0
			else
				from
					l_positions_and_sizes.start
				until
					l_positions_and_sizes.after or l_found
				loop
					if l_last_end_position <= a_position and a_position < l_positions_and_sizes.item.integer_32_item (1) then
						Result := Result - 1
						l_found := True
					end
					if not l_found then
						if l_positions_and_sizes.item.integer_32_item (1) <= a_position and
							 a_position <= l_positions_and_sizes.item.integer_32_item (1) + l_positions_and_sizes.item.integer_32_item (2) then
							l_found := True
						end
					end
					l_positions_and_sizes.forth
					Result := Result + 1
				end
			end
			if not l_found then
				Result := l_positions_and_sizes.count
			end
			debug ("docking")
				print ("%NSD_TOOL_BAR_ROW_POSITIONER put_hot_tool_bar_at: " + Result.out)
			end
		ensure
			valid: Result >= 0 and Result <= positions_and_sizes (True).count
		end

	try_set_position (a_position: INTEGER; a_hot_index: INTEGER) is
			 -- Try to position every tool bar. `a_hot_index' is Result from `put_hot_tool_bar_at'.
		require
			is_dragging: is_dragging
		local
			l_last_position: INTEGER
			l_temp: TUPLE [INTEGER, INTEGER]
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_zone_last_position, l_zone_last_size: INTEGER
		do
			l_zones := internal_tool_bar_row.tool_bar_zones
			l_zones.delete (internal_mediator.caller)
			-- Position every tool bar before hot tool bar.
			from
				l_zones.go_i_th (a_hot_index)
				l_last_position := a_position
			until
				l_zones.before
			loop
				-- FIXIT: maybe we use state pattern here?
				if not internal_sizer.is_enough_max_space (True) then
					l_zone_last_position := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (1)
					l_zone_last_size := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (2)
				else
					l_zone_last_position := l_zones.item_for_iteration.assistant.last_state.position
					l_zone_last_size := l_zones.item_for_iteration.assistant.last_state.size
				end

				if (l_zone_last_position + l_zone_last_size >= l_last_position)	then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (l_zones.index)
					l_temp.put_integer_32 (l_last_position - l_zone_last_size - 1, 1)
				end
				l_last_position := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (1)
				l_zones.back
			end
			-- Position every tool bar after hot tool bar.
			from
				l_zones.go_i_th (a_hot_index + 1)
				l_last_position := a_position + internal_mediator.caller.size
			until
				l_zones.after
			loop
				if not internal_sizer.is_enough_max_space (True) then
					l_zone_last_position := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (1)
					l_zone_last_size := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (2)
				else
					l_zone_last_position := l_zones.item_for_iteration.assistant.last_state.position
					l_zone_last_size := l_zones.item_for_iteration.assistant.last_state.size
				end

				if l_last_position >= l_zone_last_position then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (l_zones.index)
					l_temp.put_integer_32 (l_last_position + 1, 1)
				end
				l_last_position := positions_and_sizes_try.i_th (l_zones.index).integer_32_item (1) + l_zone_last_size
				l_zones.forth
			end
		end

	is_possible_set_position (a_hot_pointer_position: INTEGER; a_hot_index: INTEGER): BOOLEAN is
			-- After `try_set_position' is it possible to set postion to `positions_and_sizes_try'?
		do
			Result := True
			-- Check if first out of border
			if positions_and_sizes_try /= Void and then positions_and_sizes_try.count > 0 then
				if positions_and_sizes_try.first.integer_32_item (1) < 0 then
					if internal_sizer.is_enough_max_space (True) then
						Result := False
					else
						Result := internal_sizer.try_to_solve_no_space_left (positions_and_sizes_try, a_hot_index)
						if Result then
							position_one_by_one (a_hot_index)
						end
					end
					debug ("docking")
						print ("%N XXXXXXXXXXXXXXXX SD_TOOL_BAR_ROW_POSITIONER left out of borderd XXXXXXXXXXXXXXXXX")
					end
				end
				-- Check if last out of border
				if positions_and_sizes_try.last.integer_32_item (1) + positions_and_sizes_try.last.integer_32_item (2) > internal_tool_bar_row.size then
					if internal_sizer.is_enough_max_space (True) then
						Result := False
					else
						Result := internal_sizer.try_to_solve_no_space_right (positions_and_sizes_try, a_hot_index)
					end
					debug ("docking")
						print ("%N XXXXXXXXXXXXXXXX SD_TOOL_BAR_ROW_POSITIONER right out of borderd XXXXXXXXXXXXXXXXX")
					end
				end
			end
			-- Check if dragged tool bar right edge outside.
			if a_hot_pointer_position + internal_mediator.caller.size > internal_tool_bar_row.size then
				if internal_sizer.is_enough_max_space (True) then
					Result := False
				else
					Result := internal_sizer.try_to_solve_no_space_hot_tool_bar_right (positions_and_sizes_try)
				end
			end
		end

	zones_last_states (a_except_dragged_zone: BOOLEAN): ARRAYED_LIST [TUPLE [INTEGER, INTEGER]] is
			-- Zone last states
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_temp_state: SD_TOOL_BAR_ZONE_STATE
		do
			l_zones := internal_tool_bar_row.tool_bar_zones
			if a_except_dragged_zone then
				l_zones.delete (internal_mediator.caller)
			end

			-- Copy values from `postions_and_sizes'
			from
				create Result.make (1)
				l_zones.start
			until
				l_zones.after
			loop
				l_temp_state := l_zones.item_for_iteration.assistant.last_state
				Result.extend ([l_temp_state.position, l_temp_state.size])
				l_zones.forth
			end
		end

	positions_and_sizes_try: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]
			-- Try to set tool bar positions and sizes.
			-- First is position, Second is size.

	position_one_tool_bar (a_tool_bar: SD_TOOL_BAR_ZONE; l_position: INTEGER) is
			-- Position one tool bar position.
		do
			internal_tool_bar_row.internal_set_item_position (a_tool_bar, l_position)
		end

	internal_tool_bar_row: SD_TOOL_BAR_ROW
			-- Tool bar row which Current managed.

	positions_and_sizes (a_except_dragged: BOOLEAN): ARRAYED_LIST [TUPLE [INTEGER, INTEGER]] is
			-- Position and sizes.
		require
			valid: a_except_dragged implies is_dragging
		local
			l_list: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_state: SD_TOOL_BAR_ZONE_STATE
		do
			from
				create Result.make (1)
				l_list := internal_tool_bar_row.tool_bar_zones
				l_list.start
			until
				l_list.after
			loop
				if not (a_except_dragged and then l_list.item_for_iteration = internal_mediator.caller) then
					l_state := l_list.item_for_iteration.assistant.last_state
					Result.extend ([l_state.position, l_state.size])
				end
				l_list.forth
			end
		end

	internal_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Tool bar docker mendiator.

invariant
	not_void: internal_mediator /= Void

end
