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
				l_tool_bars := internal_tool_bar_row.tool_bar_zones
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
				l_tool_bars := internal_tool_bar_row.tool_bar_zones
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
			l_tool_bars := internal_tool_bar_row.tool_bar_zones
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
					l_tool_bars := internal_tool_bar_row.tool_bar_zones
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
					l_tool_bars := internal_tool_bar_row.tool_bar_zones
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
--			enought_space: is_enough_space (False, a_size)
		end

	try_to_solve_no_space_left (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at left side. Try to minmize some tool bars.
		local
			l_space_to_reduce: INTEGER
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_space_reduced: INTEGER
			l_space_expanded: INTEGER
		do
			if not is_enough_max_space (True) then
				l_zones := internal_tool_bar_row.tool_bar_zones
				l_zones.delete (internal_mediator.caller)
				check same_size: a_possible_positions.count = l_zones.count end
				from
					l_space_to_reduce := 0 - a_possible_positions.first.integer_32_item (1)
					a_possible_positions.start
				until
					a_possible_positions.after or Result
				loop
					if l_space_reduced < l_space_to_reduce then
						l_space_reduced := l_space_reduced + l_zones.item (a_possible_positions.index).assistant.can_reduce_size (l_space_to_reduce)
					 	a_possible_positions.item.put_integer_32 (l_zones.item (a_possible_positions.index).size, 2)
					else
						l_space_expanded := l_space_expanded + l_zones.item (a_possible_positions.index).assistant.can_expand_size ({INTEGER}.max_value)
						debug ("docking")
							print ("%N                     trying...  l_space_expanded: " + l_space_expanded.out)
						end
					end
					a_possible_positions.forth
				end
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW_SIZER try_to_solve_no_space_left: ")
					print ("%N                       l_space_reduced: " + l_space_reduced.out)
					print ("%N                       l_space_to_reduce: " + l_space_to_reduce.out)
					print ("%N                       l_space_expanded: " + l_space_expanded.out)
				end
				if l_space_reduced >= l_space_to_reduce and l_space_expanded > 0 and l_space_expanded <= l_space_to_reduce then
					Result := True
					l_space_reduced := 0
					l_space_expanded := 0
					-- Now we really reduce size and expand size.
					from
						l_space_to_reduce := 0 - a_possible_positions.first.integer_32_item (1)
						a_possible_positions.start
					until
						a_possible_positions.after
					loop
						if l_space_reduced < l_space_to_reduce then
							l_space_reduced := l_space_reduced + l_zones.item (a_possible_positions.index).assistant.reduce_size (l_space_to_reduce)

							a_possible_positions.item.put_integer_32 (l_zones.item (a_possible_positions.index).size, 2)

							debug ("docking")
								print ("%N SD_TOOL_BAR_ROW_SIZER try_to_solve_no_space_left reduce size")
							end
						else
							l_space_expanded := l_space_expanded + l_zones.item (a_possible_positions.index).assistant.expand_size ({INTEGER}.max_value)
							debug ("docking")
								print ("%N SD_TOOL_BAR_ROW_SIZER try_to_solve_no_space_left expand size")
							end
						end
						a_possible_positions.forth
					end
				end
			end
		end

	try_to_solve_no_space_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]; a_hot_index: INTEGER): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space at right side. Try to minmize some tool bars.
		do

		end

	try_to_solve_no_space_hot_tool_bar_right (a_possible_positions: ARRAYED_LIST [TUPLE [INTEGER, INTEGER]]): BOOLEAN is
			-- After SD_POSITIONER calculation, there is not enough space for dragged tool bar at right side. Try to minmize dragged tool bar.
		do

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
			l_tool_bars := internal_tool_bar_row.tool_bar_zones

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
			l_tool_bars := internal_tool_bar_row.tool_bar_zones
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

feature {NONE} -- Implementation

	internal_mediator: SD_TOOL_BAR_DOCKER_MEDIATOR
			-- Docker mediator for one user dragging.

	internal_tool_bar_row: SD_TOOL_BAR_ROW
			-- Tool bar row which all it's tool bars' size are managed by Current.

	all_sizes: ARRAYED_LIST [INTEGER]
			-- All orignal sizes when user dragging.

invariant
	not_void: internal_tool_bar_row /= Void

end
