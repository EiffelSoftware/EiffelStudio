indexing
	description: "Tool bar for docking library."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR

inherit
	SD_DRAWING_AREA
		export
			{NONE} all
			{ANY} width, height, minimum_width, minimum_height,
				 set_background_color, background_color, screen_x,
				  screen_y, hide, show, is_displayed,parent,
					pointer_motion_actions, pointer_button_release_actions,
					enable_capture, disable_capture, has_capture,
					x_position, y_position, destroy,
					set_minimum_width, set_minimum_height
			{SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE, SD_TOOL_BAR} implementation, draw_pixmap, clear_rectangle
			{SD_TOOL_BAR_ITEM, SD_TOOL_BAR} tooltip, set_tooltip, remove_tooltip
			{SD_TOOL_BAR_DRAGGING_AGENTS, SD_TOOL_BAR_DOCKER_MEDIATOR, SD_TOOL_BAR} set_pointer_style
			{SD_TOOL_BAR_ZONE, SD_TOOL_BAR} expose_actions, pointer_button_press_actions, pointer_double_press_actions,
							redraw_rectangle
		redefine
			update_for_pick_and_drop
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		local
			l_colors: EV_STOCK_COLORS
		do
			default_create
			internal_row_height := 23
			create internal_items.make (1)
			expose_actions.extend (agent on_expose)
			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_double_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_leave_actions.extend (agent on_pointer_leave)
			create drawer.make (Current)

			create l_colors
			set_background_color (l_colors.default_background_color)

			drop_actions.extend (agent on_drop_action)
			drop_actions.set_veto_pebble_function (agent on_veto_pebble_function)
		end

feature -- Properties

	set_row_height (a_height: INTEGER) is
			-- Set `row_height'
		require
			valid: a_height > 0
		do
			internal_row_height := a_height
		ensure
			set: is_row_height_set (a_height)
		end

	row_height: INTEGER is
			-- Height of row.
		do
			Result := internal_row_height
		ensure
			valid: is_row_height_valid (Result)
		end

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item'
		require
			not_void: a_item /= Void
--			parent_void: a_item.tool_bar = Void
		do
			internal_items.extend (a_item)
			a_item.set_tool_bar (Current)
		ensure
			has: has (a_item)
			is_parent_set: is_parent_set (a_item)
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		do
			internal_items.prune_all (a_item)
			a_item.set_tool_bar (Void)
		ensure
			pruned: not has (a_item)
			parent_void: a_item.tool_bar = Void
		end

	compute_minmum_size is
			-- Compute `minmum_width' and `minmum_height'.
		local
			l_minmum_width: INTEGER
			l_minmum_height: INTEGER
			l_item: SD_TOOL_BAR_ITEM
			l_items: like internal_items
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				l_items := items
				l_items.start
				if l_items.count > 0 then
					l_minmum_height := row_height
				end
			until
				l_items.after
			loop
				l_item := l_items.item
				l_separator ?= l_item
				if l_items.index = l_items.count or l_item.is_wrap then
					-- Minmum width only make sence in this case.
					if l_separator /= Void then
						-- It's a separator, we should calculate the item before
						if l_items.index > 1 then
							l_item := internal_items.i_th (l_items.index - 1)
						end
					end
					if l_minmum_width < l_item.rectangle.right then
						l_minmum_width := l_item.rectangle.right
					end
				end
				if l_items.index = l_items.count then
					l_minmum_height := l_items.item.rectangle.bottom
				end
				l_items.forth
			end
			debug ("docking")
				print ("%NSD_TOOL_BAR compute minimum size minimum_width is: " + l_minmum_width.out)
				print ("%NSD_TOOL_BAR compute minimum size minimum_height is: " + l_minmum_height.out)
			end

			set_minimum_width (l_minmum_width)
			set_minimum_height (l_minmum_height)
		end

	wipe_out is
			-- Wipe out
		do
			internal_items.wipe_out
		end

feature -- Query

	items: like internal_items is
			-- `internal_items''s snapshot.
		do
			Result := internal_items.twin
		ensure
			not_void: Result /= Void
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item' ?
		do
			Result := internal_items.has (a_item)
		end

	border_width: INTEGER is 2
			-- Border width.

	padding_width: INTEGER is 2
			-- Padding width.

feature -- Contract support

	is_row_height_set (a_new_height: INTEGER): BOOLEAN is
			-- If row height set?
		do
			Result := internal_row_height = a_new_height
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN is
			-- If `a_height' valid?
		do
			Result := internal_row_height = a_height
		end

	is_parent_set (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If `a_item' parent set?
		do
			Result := a_item.tool_bar = Current
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN is
			--
		do
			Result := start_x = a_x
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN is
			--
		do
			Result := start_y = a_y
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_TOOL_BAR} -- Internal issues

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Relative x position of `a_item'.
		require
			has: has (a_item)
		local
			l_stop: BOOLEAN
			l_items: like internal_items
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				Result := start_x
				l_items := items
				l_items.start
			until
				l_items.after or l_stop
			loop
				l_separator ?= l_items.item
				if l_items.item /= a_item then
					if l_items.item.is_wrap then
						Result := start_x
					else
						Result := Result + l_items.item.width
					end
				else
					l_stop := True
					if l_separator /= Void and then l_separator.is_wrap then
						Result := start_x
					end
				end

				l_items.forth
			end
		end

	item_y (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Relative y position of `a_item'.
		require
			has: has (a_item)
		local
			l_stop: BOOLEAN
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_items: like internal_items
		do
			from
				Result := start_y
				l_items := items
				l_items.start
			until
				l_items.after or l_stop
			loop
				l_separator ?= l_items.item
				if l_items.item /= a_item then
					if l_items.item.is_wrap then
						Result := Result + row_height
					end
					if l_separator /= Void and then l_separator.is_wrap then
						Result := Result + l_separator.width
					end
				else
					l_stop := True
					if l_separator /= Void and then l_separator.is_wrap then
						Result := Result + row_height
					end
				end
				l_items.forth
			end
		end

	update is
			-- Redraw item(s) which `is_need_redraw'
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_rect: EV_RECTANGLE
		do
			if width /= 0 and height /= 0 then
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					if l_items.item.is_need_redraw then
						l_rect := l_items.item.rectangle
						drawer.start_draw (l_rect)
						redraw_item (l_items.item)
						drawer.end_draw
						l_items.item.disable_redraw
					end
					l_items.forth
				end
			end
		end

feature {SD_TOOL_BAR_ZONE, SD_TOOL_BAR} -- Tool bar zone issues

	set_start_x (a_x: INTEGER) is
			--
		do
			internal_start_x := a_x
		ensure
			set: is_start_x_set (a_x)
		end

	set_start_y (a_y: INTEGER) is
			--
		do
			internal_start_y := a_y
		ensure
			set: is_start_y_set (a_y)
		end

	start_x: INTEGER is
			-- `internal_start_x'
		do
			Result := internal_start_x
		end

	start_y: INTEGER is
			-- 'internal_start_y'
		do
			Result := internal_start_y
		end

feature {NONE} -- Agents

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle expose actions.
		local
			l_items: like internal_items
		do
			drawer.start_draw (create {EV_RECTANGLE}.make (a_x, a_y, a_width, a_height))
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.has_rectangle (create {EV_RECTANGLE}.make (a_x, a_y, a_width, a_height)) then
					redraw_item (l_items.item)
				end
				l_items.forth
			end
			drawer.end_draw
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion actions.
		local
			l_items: like internal_items
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_items.item.on_pointer_motion (a_x, a_y)
				l_items.item.on_pointer_motion_for_tooltip (a_x, a_y)
				if l_items.item.is_need_redraw then
					drawer.start_draw (l_items.item.rectangle)
					redraw_item (l_items.item)
					drawer.end_draw
				end
				l_items.forth
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions.
		local
			l_items: like internal_items
		do
			debug ("docking")
				print ("%NSD_TOOL_BAR on_pointer_press")
			end
			if a_button = 1 then
				enable_capture
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					l_items.item.on_pointer_press (a_x, a_y)
					if l_items.item.is_need_redraw then
						drawer.start_draw (l_items.item.rectangle)
						redraw_item (l_items.item)
						drawer.end_draw
					end
					l_items.forth
				end
			end
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release actions.
		local
			l_items: like internal_items
		do

			if a_button = 1 then
				disable_capture
				internal_pointer_pressed := False
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					l_items.item.on_pointer_release (a_x, a_y)
					if l_items.item.is_need_redraw then
						drawer.start_draw (l_items.item.rectangle)
						redraw_item (l_items.item)
						drawer.end_draw
					end
					l_items.forth
				end
			end
		end

	on_pointer_leave is
			-- Handle pointer leave actions.
		local
			l_items: like internal_items
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_items.item.on_pointer_leave
				if l_items.item.is_need_redraw then
					drawer.start_draw (l_items.item.rectangle)
					redraw_item (l_items.item)
					drawer.end_draw
				end
				l_items.forth
			end
		end

	on_drop_action (a_any: ANY) is
			-- Handle drop actions.
		local
			l_screen: EV_SCREEN
			l_item: SD_TOOL_BAR_ITEM
		do
			create l_screen
			l_item := item_at_position (l_screen.pointer_position.x, l_screen.pointer_position.y)
			if l_item /= Void then
				l_item.drop_actions.call ([a_any])
			end
		end

	on_veto_pebble_function (a_any: ANY): BOOLEAN is
			-- Handle veto pebble function.
		local
			l_screen: EV_SCREEN
			l_item: SD_TOOL_BAR_ITEM
		do
			create l_screen
			l_item := item_at_position (l_screen.pointer_position.x, l_screen.pointer_position.y)
			if l_item /= Void then
				Result := l_item.drop_actions.accepts_pebble (a_any)
			end
		end

feature {SD_TOOL_BAR} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Redraw `a_item'.
		require
			not_void: a_item /= Void
		local
			l_argu: SD_TOOL_BAR_DRAWER_ARGUMENTS
			l_coordinate: EV_COORDINATE
			l_rectangle: EV_RECTANGLE
			l_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			l_item ?= a_item
			if l_item = Void then
				l_rectangle := a_item.rectangle
				create l_argu.make
				l_argu.set_item (a_item)
				create l_coordinate
				l_coordinate.set_x (item_x (a_item))
				l_coordinate.set_y (item_y (a_item))
				l_argu.set_position (l_coordinate)
				l_argu.set_tool_bar (Current)

				drawer.draw_item (l_argu)
			end
		end

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Update items for pick and drop.
		local
			l_items: like items
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_items.item.update_for_pick_and_drop (a_starting, a_pebble)
				l_items.forth
			end
			update
		end

	drawer: SD_TOOL_BAR_DRAWER
			-- Drawer with responsibility for draw OS native looks.

	internal_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- All tool bar items in Current.

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

	item_at_position (a_screen_x, a_screen_y: INTEGER): SD_TOOL_BAR_ITEM is
			-- Item at `a_screen_x', `a_screen_y'
			-- Result may be void when there wraps.
		require
			in_position: a_screen_x >= screen_x and a_screen_y >= screen_y
					and a_screen_x < width + screen_x and a_screen_y < height + screen_y
		local
			l_x, l_y: INTEGER
		do
			from
				l_x := a_screen_x - screen_x
				l_y := a_screen_y - screen_y
				internal_items.start
			until
				internal_items.after or Result /= Void
			loop
				if internal_items.item.rectangle.has_x_y (l_x, l_y) then
					Result := internal_items.item
				end
				internal_items.forth
			end
		end

	internal_row_height: INTEGER
			-- Row height of Current.

	internal_start_x: INTEGER
			-- X postion start to draw buttons.

	internal_start_y: INTEGER
			-- Y postion start to draw buttons.

invariant
	not_void: items /= Void
	not_void: internal_items /= Void

end
