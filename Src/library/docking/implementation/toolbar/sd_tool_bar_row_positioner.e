note
	description: "[
					Objects that manage tool bar positions for a SD_TOOL_BAR_ROW.
																				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ROW_POSITIONER

create
	make

feature {NONE}  -- Initlization

	make
			-- Creation method
		local
			l_shared: SD_SHARED
		do
			create l_shared
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
			-- Because tool bar row may be created when dragging. `on_pointer_motion' will call `positions_and_sizes_try'
			create positions_and_sizes_try.make (1)

		end

feature -- Command

	set_tool_bar_row (a_tool_bar_row: SD_TOOL_BAR_ROW)
			-- set `internal_tool_bar_row' with `a_tool_bar_row'
		require
			not_void: a_tool_bar_row /= Void
		do
			internal_tool_bar_row := a_tool_bar_row
			create internal_sizer.make (a_tool_bar_row)
		ensure
			set: tool_bar_row = a_tool_bar_row
		end

	position_resize_on_extend (a_new_tool_bar: SD_TOOL_BAR_ZONE; a_relative_pointer_position: INTEGER)
			-- When extend `a_new_tool_bar', if not `is_enough_max_space', then resize tool bars
		require
			has: attached {EV_WIDGET} a_new_tool_bar.tool_bar as lt_widget implies has (lt_widget)
			set: is_mediator_set
		local
			l_hot_index: INTEGER
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_last_end_position: INTEGER
			l_mediator: like internal_mediator
		do
			if is_dragging then
				l_mediator := internal_mediator
				check l_mediator /= Void end -- Implied by precondition `set'
				check new_tool_bar_is_caller: a_new_tool_bar = l_mediator.caller end
				sizer.resize_on_extend (a_new_tool_bar)
				l_hot_index := put_hot_tool_bar_at (a_relative_pointer_position)
				l_tool_bars := tool_bar_row.zones
				l_tool_bars.start
				l_tool_bars.search (a_new_tool_bar)
				if not l_tool_bars.exhausted then
					l_tool_bars.remove
				end
				if l_hot_index = 0 then
					if attached {EV_WIDGET} a_new_tool_bar.tool_bar as lt_widget_2 then
						tool_bar_row.internal_set_item_position (lt_widget_2, 0)
					else
						check not_possible: False end
					end
					l_last_end_position := a_new_tool_bar.size
				end
				from
					l_tool_bars.start
				until
					l_tool_bars.after
				loop
					if attached {EV_WIDGET} l_tool_bars.item_for_iteration.tool_bar as lt_widget_3 then
						tool_bar_row.internal_set_item_position (lt_widget_3, l_last_end_position)
					else
						check not_possible: False end
					end

					l_last_end_position := l_tool_bars.item_for_iteration.position + l_tool_bars.item_for_iteration.size

					if l_tool_bars.index = l_hot_index then
						if attached {EV_WIDGET} a_new_tool_bar.tool_bar as lt_widget_4 then
							tool_bar_row.internal_set_item_position (lt_widget_4, l_last_end_position)
						else
							check not_possible: False end
						end

						l_last_end_position := a_new_tool_bar.position + a_new_tool_bar.size
					end
					l_tool_bars.forth
				end
			end
			on_resize (tool_bar_row.size)
		end

	position_resize_on_prune
			-- Position and resize tool bars when prune a tool bar from Current
		local
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_tool_bar: SD_TOOL_BAR_ZONE
			l_positions_and_sizes: like zones_last_states
			l_mediator: like internal_mediator
		do
			sizer.resize_on_prune
			l_positions_and_sizes := zones_last_states (is_dragging)
			if sizer.is_enough_max_space (False) then
				l_tool_bars := tool_bar_row.zones
				from
					l_mediator := internal_mediator
					if l_mediator /= Void then
						l_tool_bars.start
						l_tool_bars.search (l_mediator.caller)
						if not l_tool_bars.exhausted then
							l_tool_bars.remove
						end
					end
					l_tool_bars.start
					l_positions_and_sizes.start
				until
					l_tool_bars.after
				loop
					l_tool_bar := l_tool_bars.item_for_iteration
					-- User dragged tool bar out of current row
					-- We reset orignal position
					if attached {EV_WIDGET} l_tool_bar.tool_bar as lt_widget then
						if attached l_tool_bar.row as l_row then
							l_row.set_item_position_relative (lt_widget, l_positions_and_sizes.item.pos)
						else
							check False end -- Implied by end user is dragging, so tool bar has parent row
						end
					else
						check not_possible: False end
					end

					l_tool_bars.forth
					l_positions_and_sizes.forth
				end
			end
			on_resize (tool_bar_row.size)
			check_if_correct
		end

	check_if_correct
			-- After recover last_position, if enough max space, check if current position no overlay problem
		local
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_last_x, l_last_width: INTEGER
			l_conflict: BOOLEAN
		do
			if sizer.is_enough_max_space (False) then
				l_tool_bars := tool_bar_row.zones
				from
					l_tool_bars.start
				until
					l_tool_bars.after or l_conflict
				loop

					if l_tool_bars.index > 1 then
						l_conflict := (l_last_x + l_last_width) > l_tool_bars.item_for_iteration.position
					end
					l_last_x := l_tool_bars.item_for_iteration.position
					l_last_width := l_tool_bars.item_for_iteration.size
					l_tool_bars.forth
				end
				if l_conflict then
					from
						l_last_x := 0
						l_last_width := 0
						l_tool_bars.start
					until
						l_tool_bars.after
					loop
						if attached {EV_WIDGET} l_tool_bars.item_for_iteration.tool_bar as lt_widget then
							tool_bar_row.internal_set_item_position (lt_widget, l_last_x + l_last_width)
						else
							check not_possible: False end
						end

						l_last_x := l_tool_bars.item_for_iteration.position
						l_last_width := l_tool_bars.item_for_iteration.size
						l_tool_bars.forth
					end
				end
			end
		end

	on_pointer_motion (a_relative_position: INTEGER)
			-- Handle pointer motion in Current. Position dragging tool bar and others
		require
			is_dragging: is_dragging
		local
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_hot_index: INTEGER
			l_mediator: like internal_mediator
		do
			l_mediator := internal_mediator
			if l_mediator /= Void then
				if a_relative_position < 0 then
					caller_position := 0
				else
					caller_position := a_relative_position
				end
				l_hot_index := put_hot_tool_bar_at (a_relative_position)
				try_set_position (a_relative_position, l_hot_index)
				if is_possible_set_position (a_relative_position, l_hot_index) then
					from
						l_tool_bars := tool_bar_row.zones
						l_tool_bars.start
						l_tool_bars.search (l_mediator.caller)
						if not l_tool_bars.exhausted then
							l_tool_bars.remove
						end
						positions_and_sizes_try.start
						l_tool_bars.start
						check right_size: positions_and_sizes (True).count = l_tool_bars.count end
					until
						positions_and_sizes_try.after
					loop
						check non_negative: positions_and_sizes_try.item.pos >= 0 end
						check not_outside: positions_and_sizes_try.item.pos + l_tool_bars.at(positions_and_sizes_try.index).size <= tool_bar_row.size end
						if attached {EV_WIDGET} l_tool_bars.item_for_iteration.tool_bar as lt_widget then
							tool_bar_row.internal_set_item_position (lt_widget, positions_and_sizes_try.item.pos)
						else
							check not_possible: False end
						end

						l_tool_bars.forth
						positions_and_sizes_try.forth
					end
					if attached {EV_WIDGET} l_mediator.caller.tool_bar as lt_widget_2 then
						tool_bar_row.internal_set_item_position (lt_widget_2, caller_position)
					else
						check not_possible: False end
					end
				end
			end
		end

	start_drag
			-- Do prepare works when user start dragging
		local
			l_shared: SD_SHARED
		do
			create l_shared
			internal_mediator := l_shared.tool_bar_docker_mediator_cell.item
			sizer.start_drag_prepare
			record_positions_and_sizes (True)
			positions_and_sizes_try := zones_last_states (True)
		end

	end_drag
			-- Do clean works when user end dragging
		do
			internal_mediator := Void
			sizer.end_drag_clean
			record_positions_and_sizes (False)
		end

	on_resize (a_size: INTEGER)
			-- Handle docking manger main window resize events
			-- a_size is width when row is horizontal
			-- a_size is height when row is vertical
		local
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_last_end_postion: INTEGER
		do
			tool_bar_row.set_ignore_resize (True)
			sizer.on_resize (a_size)
			if sizer.is_enough_max_space (False) then
				-- Position from right to left
				position_tool_bar_back_to_front (a_size)

				check_if_correct
			else
				-- All tool bar position must be one by one
				from
					l_zones := tool_bar_row.zones
					l_last_end_postion := 0
					l_zones.start
				until
					l_zones.after
				loop
					if attached {EV_WIDGET} l_zones.item_for_iteration.tool_bar as lt_widget then
						tool_bar_row.internal_set_item_position (lt_widget, l_last_end_postion)
					else
						check not_possible: False end
					end

					l_last_end_postion := l_zones.item_for_iteration.size + l_last_end_postion
					l_zones.forth
				end
			end
			tool_bar_row.set_ignore_resize (False)
		end

	record_positions_and_sizes (a_except_dragged_tool_bar: BOOLEAN)
			-- Record position and size
		require
			set: a_except_dragged_tool_bar implies is_mediator_set
		local
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_state: SD_TOOL_BAR_ZONE_STATE
			l_mediator: like internal_mediator
		do
			from
				l_tool_bars := tool_bar_row.zones
				if a_except_dragged_tool_bar then
					l_mediator := internal_mediator
					check l_mediator /= Void end -- Implied by precondition `set'
					l_tool_bars.start
					l_tool_bars.search (l_mediator.caller)
					if not l_tool_bars.exhausted then
						l_tool_bars.remove
					end
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

	has (a_widget: EV_WIDGET): BOOLEAN
			-- If `tool_bar_row' has a_widget?
		do
			Result := tool_bar_row.has (a_widget)
		end

	is_dragging: BOOLEAN
			-- If user dragging a tool bar now?
		do
			Result := internal_mediator /= Void
		end

	is_mediator_set: BOOLEAN
			-- If `internal_mediator' not void?
		do
			Result := internal_mediator /= Void
		end

	sizer: attached like internal_sizer
			-- Attached `internal_sizer'
		require
			set: internal_sizer /= Void
		local
			l_result: detachable like sizer
		do
			l_result := internal_sizer
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_sizer: detachable SD_TOOL_BAR_ROW_SIZER
			-- Tool bar sizer

feature {NONE}  -- Implementation

	caller_position: INTEGER
			-- Position where we should set caller

	position_tool_bar_back_to_front (a_size: INTEGER)
			-- Position SD_TOOL_BAR_ZONEs when there is enough space,
			-- From right to left, or from bottom to up
		require
			enough_max_space: sizer.is_enough_max_space (False) or sizer.is_enough_space (True, a_size)
		local
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_zone: SD_TOOL_BAR_ZONE
			l_last_start_position: INTEGER
			l_temp_position: INTEGER
			l_need_reposition: BOOLEAN
		do
			from
				l_zones := tool_bar_row.zones
				l_last_start_position := a_size
				l_zones.finish
			until
				l_zones.before or l_need_reposition
			loop
				l_zone := l_zones.item_for_iteration
				if l_zone.assistant.last_state.position + l_zone.size < l_last_start_position then
					if attached {EV_WIDGET} l_zone.tool_bar as lt_widget then
						-- We can position it to orignal position
						tool_bar_row.internal_set_item_position (lt_widget, l_zone.assistant.last_state.position)
					else
						check not_possible: False end
					end
				else
					l_temp_position := l_last_start_position - 1 - l_zone.size
					if l_temp_position < 0 then
						l_need_reposition := True
					else
						if attached {EV_WIDGET} l_zone.tool_bar as lt_widget_2 then
							tool_bar_row.internal_set_item_position (lt_widget_2, l_temp_position)
						else
							check not_possible: False end
						end
					end
				end
				l_last_start_position := l_zone.position
				l_zones.back
			end
		end

	position_front_to_back (a_hot_index: INTEGER)
			-- Same as `position_back_to_front' but in different order
 		require
			enough_max_space: sizer.is_enough_max_space (True) or sizer.is_enough_space (True, 0)
			not_void: positions_and_sizes_try /= Void
			left_side_outside: True
			set: is_mediator_set
		local
			l_last_start_position: INTEGER
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_mediator: like internal_mediator
		do
			debug ("docking")
				print ("%N SD_TOOL_BAR_ROW_POSITIONER position_front_to_back START ----------------")
			end
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `set'
			from
				l_zones := tool_bar_row.zones
				l_zones.start
				l_zones.search (l_mediator.caller)
				if not l_zones.exhausted then
					l_zones.remove
				end
				l_last_start_position := 0
				positions_and_sizes_try.start
			until
				positions_and_sizes_try.after
			loop
				if a_hot_index = positions_and_sizes_try.index - 1 then
					debug ("docking")
						print ("%N positioner caller: l_last_position: " + l_last_start_position.out + "; caller sizie: " + l_mediator.caller.size.out)
					end
					caller_position := l_last_start_position
					l_last_start_position := caller_position + l_mediator.caller.size

				end
				debug ("docking")
					print ("%N positioner other: l_last_position: " + l_last_start_position.out + "; other size: " + l_zones.at (positions_and_sizes_try.index).size.out)
				end
				positions_and_sizes_try.item.pos := l_last_start_position
				l_last_start_position := positions_and_sizes_try.item.pos + l_zones.at (positions_and_sizes_try.index).size
				positions_and_sizes_try.forth
			end
			if a_hot_index = positions_and_sizes_try.count then
				caller_position := l_last_start_position
			end
			debug ("docking")
				print ("%N SD_TOOL_BAR_ROW_POSITIONER position_front_to_back END ----------------")
			end
			debug ("docking")
				if a_hot_index = positions_and_sizes_try.count then
					if caller_position + l_mediator.caller.size > tool_bar_row.size then
						print ("%N Exception SD_TOOL_BAR_ROW_POSITIONER caller_position: " + (caller_position + l_mediator.caller.size).out)
						print ("%N           tool bar size: " + tool_bar_row.size.out)
					end
				else
					if (positions_and_sizes_try.last.pos + sizer.size_of (tool_bar_row.zones.count)) > tool_bar_row.size then
						print ("%N Exception SD_TOOL_BAR_ROW_POSITIONER last position: " + (positions_and_sizes_try.last.pos + sizer.size_of (tool_bar_row.zones.count)).out)
						print ("%N           tool bar size: " + tool_bar_row.size.out)
						print ("%N          is_enough_space? " + sizer.is_enough_space (True, 0).out)
						print ("%N          is_eought_max_space? " + sizer.is_enough_max_space (True).out)
					end
				end
			end
		ensure
			caller_right_side_not_outside: (attached internal_mediator as le_mediator) implies (a_hot_index = positions_and_sizes_try.count implies caller_position + le_mediator.caller.size <= tool_bar_row.size)
			others_right_side_not_outside: a_hot_index /= positions_and_sizes_try.count implies positions_and_sizes_try.last.pos + sizer.size_of (tool_bar_row.zones.count) <= tool_bar_row.size
		end

	put_hot_tool_bar_at (a_position: INTEGER): INTEGER
			-- Which index we should put hot tool bar?
			-- 0 is before 1st tool bar, 1 is after 1st tool bar, 2 is after 2nd tool bar...
			-- a_position is relative position
		require
			set: is_mediator_set
		local
			l_found: BOOLEAN
			l_last_end_position: INTEGER
			l_positions_and_sizes: like positions_and_sizes
			l_mediator: like internal_mediator
		do
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `set'
			if l_mediator.is_resizing_mode then
				Result := last_hot_index
			else
				l_positions_and_sizes := positions_and_sizes (True)
				if l_positions_and_sizes.count > 0 and then a_position <= l_positions_and_sizes.first.pos then
					l_found := True
					Result := 0
				else
					from
						l_positions_and_sizes.start
					until
						l_positions_and_sizes.after or l_found
					loop
						if l_last_end_position <= a_position and a_position < l_positions_and_sizes.item.pos then
							Result := Result - 1
							l_found := True
						end
						if not l_found then
							if l_positions_and_sizes.item.pos <= a_position and
								 a_position <= l_positions_and_sizes.item.pos + l_positions_and_sizes.item.size then
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
				last_hot_index := Result
			end
		ensure
			valid: Result >= 0 and Result <= positions_and_sizes (True).count
		end

	last_hot_index: INTEGER
			-- Last `put_hot_tool_bar_at_result'

	try_set_position (a_position: INTEGER; a_hot_index: INTEGER)
			 -- Try to position every tool bar. `a_hot_index' is Result from `put_hot_tool_bar_at'
		require
			is_dragging: is_dragging
			set: is_mediator_set
		local
			l_last_position: INTEGER
			l_temp: TUPLE [pos: INTEGER_32; size: INTEGER_32]
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_zone_last_position, l_zone_last_size: INTEGER
			l_mediator: like internal_mediator
		do
			l_zones := tool_bar_row.zones
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `l_mediator'
			l_zones.start
			l_zones.search (l_mediator.caller)
			if not l_zones.exhausted then
				l_zones.remove
			end
			-- Position every tool bar before hot tool bar
			from
				l_zones.go_i_th (a_hot_index)
				l_last_position := a_position
			until
				l_zones.before
			loop
				-- FIXIT: maybe we use state pattern here?
				l_zone_last_position := positions_and_sizes_try.i_th (l_zones.index).pos
				l_zone_last_size := l_zones.item_for_iteration.size
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW_POSITIONER try_set_position set position beofre hot items; Looping ..")
					print ("%N                            l_zone_last_position: " + l_zone_last_position.out)
					print ("%N                            l_zone_last_size: " + l_zone_last_size.out)
					print ("%N                            l_last_position: " + l_last_position.out)
					print ("%N                            a_position: " + a_position.out)
				end
				if (l_zone_last_position + l_zone_last_size >= l_last_position)	then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (l_zones.index)
					l_temp.pos := l_last_position - l_zone_last_size - 1
				end

				l_last_position := positions_and_sizes_try.i_th (l_zones.index).pos
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW_POSITIONER try_set_position set position beofre hot items; Position is: " + l_last_position.out)
				end
				l_zones.back
			end
			-- Position every tool bar after hot tool bar
			from
				l_zones.go_i_th (a_hot_index + 1)
				l_last_position := a_position + l_mediator.caller.size
			until
				l_zones.after
			loop
				if not sizer.is_enough_max_space (True) then
					l_zone_last_position := positions_and_sizes_try.i_th (l_zones.index).pos
					l_zone_last_size := l_zones.item_for_iteration.size
				else
					l_zone_last_position := l_zones.item_for_iteration.assistant.last_state.position
					l_zone_last_size := l_zones.item_for_iteration.assistant.last_state.size
				end

				if l_last_position >= l_zone_last_position then
					-- There is position conflict
					l_temp := positions_and_sizes_try.i_th (l_zones.index)
					l_temp.pos := l_last_position
				end
				l_last_position := positions_and_sizes_try.i_th (l_zones.index).pos + l_zone_last_size
				l_zones.forth
			end
		end

	is_possible_set_position (a_hot_pointer_position: INTEGER; a_hot_index: INTEGER): BOOLEAN
			-- After `try_set_position' is it possible to set postion to `positions_and_sizes_try'?
		require
			set: is_mediator_set
		local
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_mediator: like internal_mediator
		do
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `set'
			l_zones := tool_bar_row.zones
			l_zones.start
			l_zones.search (l_mediator.caller)
			if not l_zones.exhausted then
				l_zones.remove
			end
			if tool_bar_row.is_enough_max_space then
				Result := is_possible_set_position_enough_max_space (a_hot_pointer_position, a_hot_index)
			else
				Result := is_possible_set_position_not_enough_max_space (a_hot_pointer_position, a_hot_index)
			end
			last_pointer_position := a_hot_pointer_position
		ensure

		end

	is_possible_set_position_enough_max_space (a_hot_pointer_position: INTEGER; a_hot_index: INTEGER): BOOLEAN
			-- When enough maximum space, it's possible set position base on `positions_and_sizes_try'?
		require
			enough_max_space: sizer.is_enough_max_space (True)
			set: is_mediator_set
		local
			l_size: INTEGER
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_mediator: like internal_mediator
		do
			l_zones := tool_bar_row.zones
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `set'
			if attached l_mediator.caller as l_caller then
				l_zones.start
				l_zones.search (l_caller)
				if not l_zones.exhausted then
					l_zones.remove
				end
			end
			if positions_and_sizes_try /= Void and then positions_and_sizes_try.count > 0 then
				if positions_and_sizes_try.first.pos < 0 then
					position_front_to_back (a_hot_index)
				end
				l_size := l_zones.at (positions_and_sizes_try.count).size
				if positions_and_sizes_try.last.pos + l_size > tool_bar_row.size then
					position_front_to_back (a_hot_index)
				end
			end
			if a_hot_index = positions_and_sizes_try.count then
				if a_hot_pointer_position + l_mediator.caller.size > tool_bar_row.size and not Result then
				 	-- Check if dragged tool bar right edge outside
					Result := sizer.try_to_solve_no_space_hot_tool_bar_right (positions_and_sizes_try, (a_hot_pointer_position + l_mediator.caller.size) - tool_bar_row.size, a_hot_pointer_position)
					if Result then
						position_front_to_back (a_hot_index)
					end
				else
					Result := True
				end
			else
				Result := True
			end
		end

	is_possible_set_position_not_enough_max_space (a_hot_pointer_position: INTEGER; a_hot_index: INTEGER): BOOLEAN
			-- When not enough maximum space, it's possible set position base on `positions_and_sizes_try'?			--
		require
			not_enough_space: not sizer.is_enough_max_space (True)
			set: is_mediator_set
		local
			l_size: INTEGER
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_mediator: like internal_mediator
		do
			l_mediator := internal_mediator
			check l_mediator /= Void end -- Implied by precondition `set'
			l_zones := tool_bar_row.zones
			l_zones.start
			l_zones.search (l_mediator.caller)
			if not l_zones.exhausted then
				l_zones.remove
			end
			-- Check if first out of border
			if positions_and_sizes_try /= Void and then positions_and_sizes_try.count > 0 then
				if a_hot_pointer_position < last_pointer_position then
					if positions_and_sizes_try.first.pos < 0 then
						Result := sizer.try_solve_no_space_left (positions_and_sizes_try, a_hot_index)
						if Result then
							position_front_to_back (a_hot_index)
						end
					end
				end
				if not Result and then a_hot_pointer_position > last_pointer_position  then
					l_size := l_zones.at (positions_and_sizes_try.count).size
					if positions_and_sizes_try.last.pos + l_size > tool_bar_row.size then
						-- Check if last out of border
						Result := sizer.try_solve_no_space_right (positions_and_sizes_try, a_hot_index, a_hot_pointer_position)
						if Result then
							position_front_to_back (a_hot_index)
						end
					end
				end
			end

			if a_hot_index = positions_and_sizes_try.count then
				if a_hot_pointer_position + l_mediator.caller.size > tool_bar_row.size and not Result then
				 	-- Check if dragged tool bar right edge outside
					Result := sizer.try_to_solve_no_space_hot_tool_bar_right (positions_and_sizes_try, (a_hot_pointer_position + l_mediator.caller.size) - tool_bar_row.size, a_hot_pointer_position)
					if Result then
						position_front_to_back (a_hot_index)
					end
				end
			end
		end

	zones_last_states (a_except_dragged_zone: BOOLEAN): ARRAYED_LIST [TUPLE [pos: INTEGER; size: INTEGER]]
			-- Zone last states
		require
			set: a_except_dragged_zone implies is_mediator_set
		local
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_temp_state: SD_TOOL_BAR_ZONE_STATE
			l_mediator: like internal_mediator
		do
			l_zones := tool_bar_row.zones

			if a_except_dragged_zone then
				l_mediator := internal_mediator
				check l_mediator /= Void end -- Implied by precondition `set'
				l_zones.start
				l_zones.search (l_mediator.caller)
				if not l_zones.exhausted then
					l_zones.remove
				end
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

	last_pointer_position: INTEGER
			-- Last pointer position

	positions_and_sizes_try: ARRAYED_LIST [TUPLE [pos: INTEGER; size: INTEGER]]
			-- Try to set tool bar positions and sizes
			-- First is position, Second is size

	tool_bar_row: attached like internal_tool_bar_row
			-- Attached `internal_tool_bar_row'
		require
			set: internal_tool_bar_row /= Void
		local
			l_result: detachable like tool_bar_row
		do
			l_result := internal_tool_bar_row
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_tool_bar_row: detachable SD_TOOL_BAR_ROW
			-- Tool bar row which Current managed

	positions_and_sizes (a_except_dragged: BOOLEAN): ARRAYED_LIST [TUPLE [pos: INTEGER; size: INTEGER]]
			-- Position and sizes
		require
			valid: a_except_dragged implies is_dragging
			set: is_mediator_set
		local
			l_list: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_state: SD_TOOL_BAR_ZONE_STATE
			l_mediator: like internal_mediator
		do
			from
				l_mediator := internal_mediator
				check l_mediator /= Void end -- Implied by precondition `set'
				create Result.make (1)
				l_list := tool_bar_row.zones
				l_list.start
			until
				l_list.after
			loop
				if not (a_except_dragged and then l_list.item_for_iteration = l_mediator.caller) then
					l_state := l_list.item_for_iteration.assistant.last_state
					Result.extend ([l_state.position, l_state.size])
				end
				l_list.forth
			end
		end

	internal_mediator: detachable SD_TOOL_BAR_DOCKER_MEDIATOR;
			-- Tool bar docker mendiator

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
