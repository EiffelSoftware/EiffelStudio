indexing
	description: "[
					A tool bar container that is a row when at top/bottom or column at
					left/right tool bar area. It contain SD_TOOL_BAR_ZONE.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ROW

inherit
	EV_FIXED
		rename
			extend as extend_fixed,
			set_item_position as set_item_position_fixed
		export
			{NONE} all
			{ANY} has, parent, count
			{SD_TOOL_BAR_ZONE} set_item_size
		redefine
			prune
		end

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN) is
			-- Creation method
		do
			default_create
			create internal_shared
			create internal_positioner.make (Current)
			is_vertical := a_vertical
		ensure
			set: is_vertical = a_vertical
		end

feature -- Command

	extend (a_tool_bar: SD_TOOL_BAR_ZONE) is
			-- Extend `a_tool_bar'.
		require
			a_tool_bar_not_void: a_tool_bar /= Void
			parent_void: a_tool_bar.parent = Void
		do
			if a_tool_bar.is_vertical /= is_vertical then
				a_tool_bar.change_direction (not is_vertical)
			end
			extend_fixed (a_tool_bar)

			if is_vertical then
				if a_tool_bar.minimum_width > {SD_SHARED}.tool_bar_size then
					a_tool_bar.set_minimum_width ({SD_SHARED}.tool_bar_size)
				end
				set_item_width (a_tool_bar, {SD_SHARED}.tool_bar_size)
			else
				if a_tool_bar.minimum_height > {SD_SHARED}.tool_bar_size then
					a_tool_bar.set_minimum_height ({SD_SHARED}.tool_bar_size)
				end
				set_item_height (a_tool_bar, {SD_SHARED}.tool_bar_size)
			end

			a_tool_bar.set_row (Current)
			set_item_position_fixed (a_tool_bar, 1, 1)
			if internal_shared.tool_bar_docker_mediator_cell.item /= Void then
				if is_vertical then
					internal_positioner.position_resize_on_extend (a_tool_bar, to_relative_position (internal_shared.tool_bar_docker_mediator_cell.item.screen_y))
				else
					internal_positioner.position_resize_on_extend (a_tool_bar, to_relative_position (internal_shared.tool_bar_docker_mediator_cell.item.screen_x))
				end
			end

			a_tool_bar.assistant.update_indicator
		ensure
			extended: has (a_tool_bar)
			direction_changed: a_tool_bar.is_vertical = is_vertical
			tool_bar_row_set: a_tool_bar.row = Current
		end

	prune (a_item: EV_WIDGET) is
			-- Redefine
		local
			l_tool_bar: SD_TOOL_BAR_ZONE
			l_result: INTEGER
		do
			l_tool_bar ?= a_item
			check not_void: l_tool_bar /= Void end
			l_result := l_tool_bar.assistant.expand_size (l_tool_bar.maximize_size)
			Precursor {EV_FIXED} (a_item)
			internal_positioner.position_resize_on_prune
		end

	on_pointer_motion (a_screen_position: INTEGER) is
			-- When user dragging, handle pointer motion.
		do
			internal_positioner.on_pointer_motion (to_relative_position (a_screen_position))
		end

	set_item_position (a_widget: EV_WIDGET; a_screen_x_y: INTEGER) is
			-- Set `a_widget' position with screen position.
		require
			a_widget_not_void: a_widget /= Void
		do
			set_item_position_relative (a_widget, to_relative_position (a_screen_x_y))
		ensure
		end

	set_item_position_relative (a_widget: EV_WIDGET; a_relative_x_y: INTEGER) is
			-- Set `a_widget' position with relative position.
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_set_item_position (a_widget, a_relative_x_y)
		ensure
		end

	apply_change is
			-- Handle user stopped dragging.
		do
			internal_positioner.end_drag
		end

	start_drag (a_dragged_item: EV_WIDGET) is
			-- Handle user start dragging.
		require
			a_dragged_item_not_void: a_dragged_item /= Void
		do
			internal_positioner.start_drag
		end

	on_resize (a_size: INTEGER) is
			-- Handle docking manger main window resize events.
			-- a_size is width when row is horizontal
			-- a_size is height when row is vertical
		do
			if not is_ignore_resize then
				internal_positioner.on_resize (a_size)
			end
		end

	record_state is
			-- Record position and size state.
		do
			internal_positioner.record_positions_and_sizes (False)
		end

	set_ignore_resize (a_ignore: BOOLEAN) is
			-- Set `is_ignore_resize'.
		do
			is_ignore_resize := a_ignore
		ensure
			set: is_ignore_resize = a_ignore
		end

feature {SD_TOOL_BAR_ROW_POSITIONER} -- Internal Issues

	internal_set_item_position (a_widget: EV_WIDGET; a_relative_position: INTEGER) is
			-- Only do set item position issues.
		do
			if has (a_widget) then
				if is_vertical then
					set_item_y_position (a_widget, a_relative_position)
				else
					set_item_x_position (a_widget, a_relative_position)
				end
			end
		end

feature -- Query

	has_screen_y (a_screen_y: INTEGER): BOOLEAN is
			-- If a_screen_y in Current area?
		do
			Result := a_screen_y >= screen_y and a_screen_y <= (screen_y + height)
		end

	has_screen_x (a_screen_x: INTEGER): BOOLEAN is
			-- If a_screen_x in Current area?
		do
			Result := a_screen_x >= screen_x and a_screen_x <= (screen_x + width)
		end

	is_vertical: BOOLEAN
			-- If `Current' is_vertical?

	tool_bar_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE] is
			-- All tool bar zone in Current. Order is from left to right (top to bottom).
		local
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_sorter: DS_QUICK_SORTER [SD_TOOL_BAR_ZONE]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [SD_TOOL_BAR_ZONE]
		do
			from
				create Result.make (1)
				start
			until
				after
			loop
				l_tool_bar_zone ?= item
				check only_has_tool_bar_zone: l_tool_bar_zone /= Void end
				Result.force_last (l_tool_bar_zone)
				forth
			end
			create l_agent_sorter.make (agent sort_by_position)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (Result)
		end

	size: INTEGER is
			-- Size of current.
		do
			if is_vertical then
				Result := height
			else
				Result := width
			end
		ensure
			valid: Result = height or Result = width
		end

	is_ignore_resize: BOOLEAN
			-- Is ignore resize?

	is_enough_max_space: BOOLEAN is
			-- If there is enought space for each SD_TOOL_BAR without reduce size?
		do
			Result := internal_positioner.internal_sizer.is_enough_max_space (True)
		end

feature {SD_TOOL_BAR_ROW_POSITIONER} -- Implementation

	sort_by_position (a_first, a_second: SD_TOOL_BAR_ZONE): BOOLEAN is
			-- Compare `a_first' and `a_second'.
		require
			not_void: a_first /= Void
			not_void: a_second /= Void
		do
			Result := a_first.position < a_second.position
		end

	to_relative_position (a_screen_position: INTEGER): INTEGER is
			-- Screen position convert to relative position.
		do
			if not is_vertical then
				Result := a_screen_position - screen_x
			else
				Result := a_screen_position - screen_y
			end
		end

	internal_positioner: SD_TOOL_BAR_ROW_POSITIONER
			-- Tool bar positioner.

	internal_shared: SD_SHARED;
			-- All singletons.

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
