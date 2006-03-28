indexing
	description: "[
					Objects that manage tool bar sizes for a SD_TOOL_BAR_ROW.
																			]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ROW_SIZER

create
	make

feature {NONE}  -- Initlization

	make (a_tool_bar_row: SD_TOOL_BAR_ROW) is
			-- Creation method.
		require
			not_void: a_tool_bar_row /= Void
		local
			l_shared: SD_SHARED
		do
			internal_tool_bar_row := a_tool_bar_row
			create l_shared
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
		ensure
			set: internal_tool_bar_row = a_tool_bar_row
		end

feature -- Command

	start_drag_prepare is
			-- Do prepare works when user start drag.
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_shared: SD_SHARED
		do
			from
				l_tool_bars := internal_tool_bar_row.zones
				l_tool_bars.start
				create all_sizes.make (1)
			until
				l_tool_bars.after
			loop
				all_sizes.extend (l_tool_bars.item_for_iteration.size)
				l_tool_bars.forth
			end
			create l_shared
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
		end

	end_drag_clean is
			-- Do clean works when user end drag.
		do
			all_sizes := Void
		end

	resize_on_extend (a_new_tool_bar: SD_TOOL_BAR_ZONE) is
			-- When extend `a_new_tool_bar;, if not `is_enough_max_space', then resize tool bars.
		require
			has: has (a_new_tool_bar)
		local
			l_space_to_reduce: INTEGER
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
		do
			if not is_enough_max_space (True) then
				-- Not enough space, resize from right to left.
				l_space_to_reduce := space_to_resize (True, 0)
				l_tool_bars := internal_tool_bar_row.zones
				l_tool_bars.delete (a_new_tool_bar)
				from
					l_tool_bars.finish
				until
					l_tool_bars.before or l_space_to_reduce <= 0
				loop
					l_space_to_reduce := l_space_to_reduce - l_tool_bars.item_for_iteration.assistant.reduce_size (l_space_to_reduce)
					l_tool_bars.back
				end
				-- After resize other toolbars, there is still no enough space
				-- So we resize a_new_tool_bar now
				if l_space_to_reduce > 0 then
					l_space_to_reduce := l_space_to_reduce - a_new_tool_bar.assistant.reduce_size (l_space_to_reduce)
					-- FIXIT: If there is still not enough space
					--        We should change current toolbar to another row.
					--        We should wrap unplacable tool bar to another row, like Microsft Office.
					check should_not_space_left: l_space_to_reduce <= 0 end
				end
			end
		ensure
			enough_space: is_enough_space (True, 0)
		end

	resize_on_prune is
			-- Just after prune a tool bar from `internal_tool_bar_row', we need to resize all tool bars if needed.
		local
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_size_to_expand: INTEGER
		do
			l_tool_bars := internal_tool_bar_row.zones
			from
				l_size_to_expand := space_to_resize (True, 0)
				l_size_to_expand := - l_size_to_expand
				l_tool_bars.start
			until
				l_tool_bars.after or l_size_to_expand <= 0
			loop
				l_size_to_expand := l_size_to_expand - l_tool_bars.item_for_iteration.assistant.expand_size (l_size_to_expand)
				l_tool_bars.forth
			end
			if is_enough_max_space (False) then
				-- Every body should extend to full size
			else
				-- Everyboy should extend
			end
		end

	on_resize (a_size: INTEGER) is
			-- Handle docking manager main window resize events.
			-- a_size is width when row is horizontal
			-- a_size is height when row is vertical
		local
			l_space_to_reduce, l_space_to_expand: INTEGER
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
		do
			if not is_enough_space (False, a_size) then
				from
					-- From right to left
					l_space_to_reduce := space_to_resize (False, a_size)
					l_tool_bars := internal_tool_bar_row.zones
					l_tool_bars.finish
				until
					l_tool_bars.before or l_space_to_reduce <= 0
				loop
					l_space_to_reduce := l_space_to_reduce - l_tool_bars.item_for_iteration.assistant.reduce_size (l_space_to_reduce)
					l_tool_bars.back
				end
			else
				-- We can expand some size.
				from
					l_space_to_reduce := space_to_resize (False, a_size)
					check negative: l_space_to_reduce <= 0 end
					l_space_to_expand := - l_space_to_reduce
					l_tool_bars := internal_tool_bar_row.zones
					l_tool_bars.start
				until
					l_tool_bars.after or l_space_to_expand <= 0
				loop
					l_space_to_expand := l_space_to_expand - l_tool_bars.item_for_iteration.assistant.expand_size (l_space_to_expand)
					l_tool_bars.forth
				end
			end
			debug ("docking")
				if not is_enough_space (False, a_size) then
					print ("%N SD_TOOL_BAR_ROW_POSITIONER ....")
				end
			end
		ensure
			enought_space:
		end

	try_solve_no_space_left (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at left side. Try to minmize some tool bars.
		do
			if not is_enough_max_space (True) then
				Result := can_solve_no_space_left (a_possible_positions, a_hot_index)

				-- We really reduce and expand size now.
				if Result then
					solve_no_space_left (a_possible_positions, a_hot_index)
				end
			end
		end

	try_solve_no_space_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER; a_hot_position: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at right side. Try to minmize some tool bars.
		require
			valid: a_hot_index = a_possible_positions.count implies a_hot_position > 0
		local

		do
			debug ("docking")
				print ("%N SD_TOOL_BAR_ROW_SIZER try_solve_no_space_right")
			end
			if not is_enough_max_space (True) then
				Result := can_solve_no_space_right (a_possible_positions, a_hot_index, a_hot_position)
			end

			if Result then
				solve_no_space_right (a_possible_positions, a_hot_index, a_hot_position)
			end
		end

	try_to_solve_no_space_hot_tool_bar_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_size_to_reduce, a_hot_position: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space for dragged tool bar at right side. Try to minmize dragged tool bar.
		require
			valid: a_size_to_reduce > 0
		do
			Result := try_solve_no_space_right (a_possible_positions, a_possible_positions.count, a_hot_position)
		end

feature -- Query

	is_enough_max_space (a_inlcude_caller_size: BOOLEAN) : BOOLEAN is
			-- If there is enough space without reduce size of all tool bar zones in Current?
		local
			l_all_size: INTEGER
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_caller: SD_TOOL_BAR_ZONE
			l_row_max_size: INTEGER
		do
			l_tool_bars := internal_tool_bar_row.zones

			if a_inlcude_caller_size and then internal_mediator /= Void then
				l_caller := internal_mediator.caller
				l_tool_bars.delete (l_caller)
			end
			from
				l_tool_bars.start
			until
				l_tool_bars.after
			loop
				l_row_max_size := l_row_max_size + l_tool_bars.item_for_iteration.maximize_size
				l_tool_bars.forth
			end
			l_all_size := internal_tool_bar_row.size
			if a_inlcude_caller_size then
				Result := l_all_size >= l_row_max_size + l_caller.maximize_size
			else
				Result := l_all_size >= l_row_max_size
			end
		end

	is_enough_space (a_dragging_state: BOOLEAN; a_new_size: INTEGER): BOOLEAN is
			-- If there is enough space for all tool bars' current size?
		do
			Result := space_to_resize (a_dragging_state, a_new_size) <= 0
		end

	space_to_resize (a_dragging_state: BOOLEAN; a_new_size: INTEGER): INTEGER is
			-- Space that not enough, so have to reduce tool bars size.
			-- If space is enough, Result will negative, means size we can expand.
		local
			l_all_size: INTEGER
			l_tool_bars: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_row_max_size: INTEGER
		do
			l_tool_bars := internal_tool_bar_row.zones
			from
				l_tool_bars.start
			until
				l_tool_bars.after
			loop
				l_row_max_size := l_row_max_size + l_tool_bars.item_for_iteration.size
				l_tool_bars.forth
			end
			if a_dragging_state then
				l_all_size := internal_tool_bar_row.size
				Result := l_row_max_size - l_all_size
			else
				Result := l_row_max_size - a_new_size
			end
		ensure

		end

	has (a_tool_bar: EV_WIDGET): BOOLEAN is
			-- If `internal_tool_bar_row' has a_tool_bar?
		do
			Result := internal_tool_bar_row.has (a_tool_bar)
		end

feature {NONE} -- Implementation for `try_solve_no_space_left'

	can_solve_no_space_left (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- If possible slove no space left?
		require
			not_enough_space: not is_enough_max_space (True)
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_total_reduced_size_left: INTEGER
			l_size_to_reduce_left: INTEGER
			l_size_to_expand_right: INTEGER
			l_total_expanded_size_right: INTEGER
		do
			l_zones := internal_tool_bar_row.zones
			l_zones.delete (internal_mediator.caller)
			check same_size: a_possible_positions.count = l_zones.count end
			l_size_to_reduce_left := 0 - a_possible_positions.first.integer_32_item (1)

			if a_hot_index /= 0 then
				from
					a_possible_positions.start
				until
					-- Left side want to be smaller
					a_possible_positions.after or a_possible_positions.index >= a_hot_index + 1 or (l_size_to_reduce_left - l_total_reduced_size_left) <= 0
				loop
					l_total_reduced_size_left := l_total_reduced_size_left + l_zones.item (a_possible_positions.index).assistant.can_reduce_size (l_size_to_reduce_left - l_total_reduced_size_left)
					a_possible_positions.forth
				end
			end

			-- Now we start to calculate right side
			l_size_to_expand_right := l_total_reduced_size_left
			if a_hot_index < a_possible_positions.count then
				from
					-- Right side (include caller) want to be bigger
					a_possible_positions.go_i_th (a_hot_index + 1)
				until
					a_possible_positions.after or (l_size_to_expand_right - l_total_expanded_size_right) <= 0
				loop
					l_total_expanded_size_right := l_total_expanded_size_right + l_zones.item (a_possible_positions.index).assistant.can_expand_size (l_size_to_expand_right - l_total_expanded_size_right)
					a_possible_positions.forth
				end
			end

			if (l_size_to_expand_right - l_total_expanded_size_right) >= 0 then
				l_total_expanded_size_right := l_total_expanded_size_right + internal_mediator.caller.assistant.can_expand_size (l_size_to_expand_right - l_total_expanded_size_right)
			end

			if l_total_reduced_size_left > 0 and l_total_expanded_size_right > 0 then
				Result := True
			end
		end

	solve_no_space_left (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER) is
			-- We really solve no space left problem by reduce/expand SD_TOOL_BAR_ZONR sizes.
		require
			not_void: a_possible_positions /= Void
			valid: a_hot_index >= 0 and a_hot_index <= a_possible_positions.count
			can_solve: can_solve_no_space_left (a_possible_positions, a_hot_index)
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_total_reduced_size_left: INTEGER
			l_size_to_reduce_left: INTEGER
			l_size_to_expand_right: INTEGER
			l_total_expanded_size_right: INTEGER
			l_temp_zone: SD_TOOL_BAR_ZONE
		do
			l_zones := internal_tool_bar_row.zones
			l_zones.delete (internal_mediator.caller)
			check same_size: a_possible_positions.count = l_zones.count end
			l_size_to_reduce_left := 0 - a_possible_positions.first.integer_32_item (1)

			if a_hot_index /= 0 then
				from
					a_possible_positions.start
				until
					-- Left side want to be smaller
					a_possible_positions.after or a_possible_positions.index >= a_hot_index + 1 or (l_size_to_reduce_left - l_total_reduced_size_left) <= 0
				loop
					l_temp_zone := l_zones.item (a_possible_positions.index)
					l_total_reduced_size_left := l_total_reduced_size_left + l_temp_zone.assistant.reduce_size (l_size_to_reduce_left - l_total_reduced_size_left)
					a_possible_positions.item.put_integer_32 (l_temp_zone.size, 2)
					a_possible_positions.forth
				end
			end

			-- Now we start to really expand right side
			l_size_to_expand_right := calculate_size_to_expand_right (a_possible_positions, a_hot_index)
			if a_hot_index <= a_possible_positions.count then
				from
					-- Right side (include caller) want to be bigger
					a_possible_positions.go_i_th (a_hot_index + 1)
				until
					a_possible_positions.after or (l_size_to_expand_right - l_total_expanded_size_right) <= 0
				loop
					if a_hot_index = a_possible_positions.index - 1 then
						l_total_expanded_size_right := l_total_expanded_size_right + internal_mediator.caller.assistant.expand_size (l_size_to_expand_right - l_total_expanded_size_right)
					end
					if (l_size_to_expand_right - l_total_expanded_size_right) > 0 then
						l_temp_zone := l_zones.item (a_possible_positions.index)
						l_total_expanded_size_right := l_total_expanded_size_right + l_temp_zone.assistant.expand_size (l_size_to_expand_right - l_total_expanded_size_right)
						a_possible_positions.item.put_integer_32 (l_temp_zone.size, 2)
					end
					a_possible_positions.forth
				end
			end

			if a_hot_index = a_possible_positions.count and then (l_size_to_expand_right - l_total_expanded_size_right) >= 0 then
				l_total_expanded_size_right := l_total_expanded_size_right + internal_mediator.caller.assistant.expand_size (l_size_to_expand_right - l_total_expanded_size_right)
			end
		end

	calculate_size_to_expand_right (a_new_possible_size_position: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER):INTEGER is
			-- After really reduce size left, we calculate really size to expand for right side.
		require
			not_void: a_new_possible_size_position /= Void
			valid: a_hot_index >= 0 and a_hot_index <= a_new_possible_size_position.count
		local
			l_new_left_size: INTEGER
			l_old_right_size: INTEGER
		do
			from
				a_new_possible_size_position.start
			until
				a_new_possible_size_position.after or a_new_possible_size_position.index >= a_hot_index + 1
			loop
				l_new_left_size := l_new_left_size + a_new_possible_size_position.item.integer_32_item (2)
				a_new_possible_size_position.forth
			end

			from
				a_new_possible_size_position.go_i_th (a_hot_index + 1)
			until
				a_new_possible_size_position.after
			loop
				l_old_right_size := l_old_right_size + a_new_possible_size_position.item.integer_32_item (2)
				a_new_possible_size_position.forth
			end
			l_old_right_size := l_old_right_size + internal_mediator.caller.size

			Result := internal_tool_bar_row.size - l_new_left_size - l_old_right_size
		ensure
			valid: Result > 0
		end

feature {NONE} -- Implementation for `try_solve_no_space_right'

	can_solve_no_space_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER; a_hot_position: INTEGER): BOOLEAN is
			-- If possible slove no space right?
		require
			not_enough_space: not is_enough_max_space (True)
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_total_reduced_size_right: INTEGER
			l_size_to_reduce_right: INTEGER
			l_size_to_expand_left: INTEGER
			l_total_expanded_size_left: INTEGER
		do
			l_zones := internal_tool_bar_row.zones
			l_zones.delete (internal_mediator.caller)
			check same_size: a_possible_positions.count = l_zones.count end
			if a_hot_index /= a_possible_positions.count then
				l_size_to_reduce_right := (a_possible_positions.last.integer_32_item (1) + a_possible_positions.last.integer_32_item (2)) - internal_tool_bar_row.size
			else
				l_size_to_reduce_right := a_hot_position + internal_mediator.caller.size - internal_tool_bar_row.size
			end
			check positive: l_size_to_reduce_right > 0 end

			-- Right side want to be smaller
			l_total_reduced_size_right := l_total_reduced_size_right + internal_mediator.caller.assistant.can_reduce_size (l_size_to_reduce_right)
			from
				a_possible_positions.go_i_th (a_hot_index + 1)
			until
				a_possible_positions.after or l_size_to_reduce_right - l_total_reduced_size_right <= 0
			loop
				l_total_reduced_size_right := l_total_reduced_size_right + l_zones.item (a_possible_positions.index).assistant.can_reduce_size (l_size_to_reduce_right - l_total_reduced_size_right)
				a_possible_positions.forth
			end

			-- Left side want to be bigger
			l_size_to_expand_left := l_total_reduced_size_right
			from
				a_possible_positions.go_i_th (a_hot_index)
			until
				a_possible_positions.before or l_size_to_expand_left - l_total_expanded_size_left <= 0
			loop
				l_total_expanded_size_left := l_total_expanded_size_left + l_zones.item (a_possible_positions.index).assistant.can_expand_size (l_size_to_expand_left - l_total_expanded_size_left)

				a_possible_positions.back
			end

			if l_total_expanded_size_left > 0 and l_total_reduced_size_right > 0 and l_total_expanded_size_left <= l_total_reduced_size_right then
				Result := True
			end
		end

	solve_no_space_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index, a_hot_position: INTEGER) is
			-- We really solve no space right problem by reduce/expand SD_TOOL_BAR_ZONR sizes.
		require
			not_void: a_possible_positions /= Void
			valid: a_hot_index >= 0 and a_hot_index <= a_possible_positions.count
			can_solve: can_solve_no_space_right (a_possible_positions, a_hot_index, a_hot_position)
		local
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_total_reduced_size_right: INTEGER
			l_size_to_reduce_right: INTEGER
			l_size_to_expand_left: INTEGER
			l_total_expanded_size_left: INTEGER
			l_temp_zone: SD_TOOL_BAR_ZONE
		do
			l_zones := internal_tool_bar_row.zones
			l_zones.delete (internal_mediator.caller)
			check same_size: a_possible_positions.count = l_zones.count end
			if a_hot_index /= a_possible_positions.count then
				l_size_to_reduce_right := (a_possible_positions.last.integer_32_item (1) + a_possible_positions.last.integer_32_item (2)) - internal_tool_bar_row.size
			else
				l_size_to_reduce_right := a_hot_position + internal_mediator.caller.size - internal_tool_bar_row.size
			end
			check positive: l_size_to_reduce_right > 0 end
			-- Right side want to be smaller
			from
				a_possible_positions.go_i_th (a_hot_index + 1)
			until
				a_possible_positions.after or l_size_to_reduce_right - l_total_reduced_size_right <= 0
			loop
				if a_possible_positions.count = a_hot_index - 1 then
					l_total_reduced_size_right := l_total_reduced_size_right + internal_mediator.caller.assistant.reduce_size (l_size_to_reduce_right - l_total_reduced_size_right)
				end
				l_temp_zone := l_zones.item (a_possible_positions.index)
				if l_size_to_reduce_right - l_total_reduced_size_right > 0 then
					l_total_reduced_size_right := l_total_reduced_size_right + l_temp_zone.assistant.reduce_size (l_size_to_reduce_right - l_total_reduced_size_right)
					a_possible_positions.item.put_integer_32 (l_temp_zone.size, 2)
					a_possible_positions.forth
				end
			end

			if a_hot_index = a_possible_positions.count and l_size_to_reduce_right - l_total_reduced_size_right > 0 then
				l_total_reduced_size_right := l_total_reduced_size_right + internal_mediator.caller.assistant.reduce_size (l_size_to_reduce_right - l_total_reduced_size_right)
			end

			-- Left side want to be bigger
			l_size_to_expand_left := calculate_size_to_expand_left (a_possible_positions, a_hot_index)
			if a_hot_index /= 0 then
				from
					a_possible_positions.go_i_th (a_hot_index)
				until
					a_possible_positions.before or l_size_to_expand_left - l_total_expanded_size_left <= 0
				loop
					l_temp_zone := l_zones.item (a_possible_positions.index)
					l_total_expanded_size_left := l_total_expanded_size_left + l_temp_zone.assistant.expand_size (l_size_to_expand_left - l_total_expanded_size_left)
					a_possible_positions.item.put_integer_32 (l_temp_zone.size, 2)
					a_possible_positions.back
				end
			end

		end

	calculate_size_to_expand_left (a_new_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): INTEGER is
			-- After really reduce size right, we calculate really size to expand for left side.
		require
			not_void: a_new_positions /= Void
			valid: a_hot_index >= 0 and a_hot_index <= a_new_positions.count
		local
			l_old_left_size: INTEGER
			l_new_right_size: INTEGER
		do
			from
				a_new_positions.start
			until
				a_new_positions.after or a_new_positions.index > a_hot_index
			loop
				l_old_left_size := l_old_left_size + a_new_positions.item.integer_32_item (2)
				a_new_positions.forth
			end

			from
				a_new_positions.go_i_th (a_hot_index + 1)
			until
				a_new_positions.after
			loop
				l_new_right_size := l_new_right_size + a_new_positions.item.integer_32_item (2)
				a_new_positions.forth
			end
			l_new_right_size := l_new_right_size + internal_mediator.caller.size

			Result := internal_tool_bar_row.size - l_old_left_size - l_new_right_size
		ensure
			positive: Result > 0
		end

feature {NONE} -- Implementation attributes

	internal_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Docker mediator for one user dragging.

	internal_tool_bar_row: SD_TOOL_BAR_ROW
			-- Tool bar row which all it's tool bars' size are managed by Current.

	all_sizes: ARRAYED_LIST [INTEGER]
			-- All orignal sizes when user dragging.

invariant
	not_void: internal_tool_bar_row /= Void

end
