note
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
			set_item_position as set_item_position_fixed,
			prune as prune_fixed
		export
			{NONE} all
			{ANY} has, parent, count, prunable, is_destroyed, is_empty, cursor, start, item, forth,
				go_to, index, changeable_comparison_criterion, after, extendible,
				valid_cursor, object_comparison, readable, off, cl_extend
			{SD_TOOL_BAR_ROW} compare_objects, set_extend
			{SD_TOOL_BAR_ZONE, SD_GENERIC_TOOL_BAR} set_item_size, width, screen_x
			{SD_TOOL_BAR_HOT_ZONE, SD_TOOL_BAR_CONTENT} destroy
		redefine
			destroy
		end

	ANY
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_DOCKING_MANAGER_HOLDER
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_manager: SD_DOCKING_MANAGER; a_vertical: BOOLEAN)
			-- Creation method
		require
			not_void: a_manager /= Void
		do
			create internal_shared
			create internal_zones.make (10)
			create internal_positioner.make

			is_vertical := a_vertical
			set_docking_manager (a_manager)

			default_create
			internal_positioner.set_tool_bar_row (Current)
		ensure
			set: docking_manager = a_manager
			set: is_vertical = a_vertical
		end

feature -- Command

	extend (a_zone: SD_TOOL_BAR_ZONE)
			-- Extend `a_zone'
		require
			a_tool_bar_not_void: a_zone /= Void
			parent_void: a_zone.row = Void
		do
			if a_zone.is_vertical /= is_vertical then
				a_zone.change_direction (not is_vertical)
			end

			if attached {EV_WIDGET} a_zone.tool_bar as lt_widget then
				extend_fixed (lt_widget)

				if is_vertical then
					if a_zone.tool_bar.minimum_width > internal_shared.tool_bar_size then
						lt_widget.set_minimum_width (internal_shared.tool_bar_size)
						set_item_width (lt_widget, internal_shared.tool_bar_size)
					end
				else
					-- We can't use `internal_shared.tool_bar_size' as tool bar's height.  And we don't need care about it since `a_zone.tool_bar' calculated correctly itself
					-- Otherwise when desktop system font is very small (ie, Scans 8 on Linux Desktop),  `SD_WIDGET_TOOL_BAR.height' may larger than `internal_shared.tool_bar_size'
					-- If we force to use `internal_shared.tool_bar_size', it will lead to notebook tab cut-off problem after just shown a SD_WIDGET_TOOL_BAR
	--				if a_zone.tool_bar.minimum_height > internal_shared.tool_bar_size then
	--					a_zone.tool_bar.set_minimum_height (internal_shared.tool_bar_size)
	--				end
					set_item_height (lt_widget, a_zone.tool_bar.minimum_height)
				end

				set_item_position_fixed (lt_widget, 0, 0)
				if attached internal_shared.tool_bar_docker_mediator_cell.item as l_mediator then
					if is_vertical then
						internal_positioner.position_resize_on_extend (a_zone, to_relative_position (l_mediator.screen_y))
					else
						internal_positioner.position_resize_on_extend (a_zone, to_relative_position (l_mediator.screen_x))
					end
				end
				a_zone.assistant.update_indicator
				internal_zones.extend (a_zone)
			else
				check not_possible: False end
			end
		ensure
			extended: attached {EV_WIDGET} a_zone.tool_bar as lt_widget_2 implies has (lt_widget_2) and internal_zones.has (a_zone)
			direction_changed: a_zone.is_vertical = is_vertical
			tool_bar_row_set: a_zone.row = Current
		end

	prune (a_zone: SD_TOOL_BAR_ZONE)
			-- <Precursor>
		local
			l_result: INTEGER
		do
			l_result := a_zone.assistant.expand_size (a_zone.maximize_size)
			if attached {EV_WIDGET} a_zone.tool_bar as lt_widget then
				prune_fixed (lt_widget)
			else
				check not_possible: False end
			end
			internal_zones.start
			internal_zones.search (a_zone)
			if not internal_zones.exhausted then
				internal_zones.remove
			end
			internal_positioner.position_resize_on_prune
		ensure
			pruned: not internal_zones.has (a_zone)
		end

	on_pointer_motion (a_screen_position: INTEGER)
			-- When user dragging, handle pointer motion
		local
			l_relative_position: INTEGER
		do
			-- We have to check if `internal_positioner' is dragging for GTK since key press actions may
			-- not be called immediately
			-- See bug#13196	
			if internal_positioner.is_dragging then
				l_relative_position := to_relative_position (a_screen_position)
				internal_positioner.on_pointer_motion (l_relative_position)
			end
		end

	set_item_position_relative (a_widget: EV_WIDGET; a_relative_x_y: INTEGER)
			-- Set `a_widget' position with relative position
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_set_item_position (a_widget, a_relative_x_y)
		end

	reposition
			-- Reposition zones, make sure there are not clip each other
		require
			is_dragged: (create {SD_SHARED}).tool_bar_docker_mediator_cell.item /= Void
		do
			if is_vertical then
				on_pointer_motion (screen_y)
			else
				on_pointer_motion (screen_x)
			end
		end

	apply_change
			-- Handle user stopped dragging
		do
			internal_positioner.end_drag
		end

	start_drag (a_dragged_item: EV_WIDGET)
			-- Handle user start dragging
		require
			a_dragged_item_not_void: a_dragged_item /= Void
		do
			internal_positioner.start_drag
		end

	on_resize (a_size: INTEGER)
			-- Handle docking manger main window resize events
			-- a_size is width when row is horizontal
			-- a_size is height when row is vertical
		do
			if not is_ignore_resize then
				internal_positioner.on_resize (a_size)
			end
		end

	record_state
			-- Record position and size state
		do
			internal_positioner.record_positions_and_sizes (False)
		end

	set_ignore_resize (a_ignore: BOOLEAN)
			-- Set `is_ignore_resize'.
		do
			is_ignore_resize := a_ignore
		ensure
			set: is_ignore_resize = a_ignore
		end

	destroy
			-- <Precursor>
		do
			clear_docking_manager
			Precursor {EV_FIXED}
		end

feature {SD_TOOL_BAR_ROW_POSITIONER} -- Internal Issues

	internal_set_item_position (a_widget: EV_WIDGET; a_relative_position: INTEGER)
			-- Only do set item position issues
		require
			valid: a_relative_position >= 0
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

	has_screen_y (a_screen_y: INTEGER): BOOLEAN
			-- If a_screen_y in Current area?
		do
			Result := a_screen_y >= screen_y and a_screen_y <= (screen_y + height)
		end

	has_screen_x (a_screen_x: INTEGER): BOOLEAN
			-- If a_screen_x in Current area?
		do
			Result := a_screen_x >= screen_x and a_screen_x <= (screen_x + width)
		end

	is_vertical: BOOLEAN
			-- If `Current' is_vertical?

	zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			-- All tool bar zone in Current. Order is from left to right (top to bottom)
		local
			l_sortable_array: SORTED_TWO_WAY_LIST [SD_TOOL_BAR_ZONE]
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
		do
			l_zones := internal_zones.twin

			from
				l_zones.start
				create l_sortable_array.make
			until
				l_zones.after
			loop
				l_sortable_array.extend (l_zones.item)

				l_zones.forth
			end

			from
				l_sortable_array.start
				create Result.make (l_sortable_array.count)
			until
				l_sortable_array.after
			loop
				Result.extend (l_sortable_array.item)

				l_sortable_array.forth
			end
		end

	size: INTEGER
			-- Size of current
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

	is_enough_max_space: BOOLEAN
			-- If there is enought space for each SD_TOOL_BAR without reduce size?
		do
			Result := internal_positioner.sizer.is_enough_max_space (True)
		end

	hidden_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- All hideen items in row
		local
			l_tool_bars: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_temp_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			create Result.make (1)
			-- Prepare all hiden items in Current row
			l_tool_bars := zones
			from
				l_tool_bars.start
			until
				l_tool_bars.after
			loop
				-- We can't just call `append' to insert items, because we want to reverse items order
				from
					l_temp_items := l_tool_bars.item_for_iteration.assistant.hide_tool_bar_items
					l_temp_items.finish
				until
					l_temp_items.before
				loop
					Result.extend (l_temp_items.item)
					l_temp_items.back
				end
				l_tool_bars.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {SD_TOOL_BAR_ROW_POSITIONER} -- Implementation

	to_relative_position (a_screen_position: INTEGER): INTEGER
			-- Screen position convert to relative position
		do
			if not is_vertical then
				Result := a_screen_position - screen_x
				debug ("docking")
					print ("%N SD_TOOL_BAR_ROW to_relative_position: a_screen_position: " + a_screen_position.out + ". screen_x: " + screen_x.out)
				end
			else
				Result := a_screen_position - screen_y
			end
		end

	internal_positioner: SD_TOOL_BAR_ROW_POSITIONER
			-- Tool bar positioner

	internal_shared: SD_SHARED;
			-- All singletons

	internal_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE];
			-- All tool bar zones in Current

invariant

	not_void: internal_zones /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
