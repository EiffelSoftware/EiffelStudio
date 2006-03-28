indexing
	description: "Tool bar for docking library."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR

inherit
	EV_DRAWING_AREA
		export
			{NONE} all
			{ANY} width, height, minimum_width, minimum_height, set_background_color, background_color, screen_x, screen_y
			{SD_TOOL_BAR_DRAWER_I} implementation, draw_pixmap, clear_rectangle
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
			row_height := 23
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
		end

feature -- Properties

	set_row_height (a_height: INTEGER) is
			-- Set `row_height'
		require
			valid: a_height > 0
		do
			row_height := a_height
		ensure
			set: row_height = a_height
		end

	row_height: INTEGER
			-- Height of row.

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item'
		require
			not_void: a_item /= Void
		do
			internal_items.extend (a_item)
			a_item.set_tool_bar (Current)
		ensure
			has: has (a_item)
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		do
			internal_items.prune_all (a_item)
		ensure
			pruned: not has (a_item)
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

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM} -- Internal issues

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

feature {NONE} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Redraw `a_item'.
		require
			not_void: a_item /= Void
		local
			l_argu: SD_TOOL_BAR_DRAWER_ARGUMENTS
			l_coordinate: EV_COORDINATE
			l_rectangle: EV_RECTANGLE
		do
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

	drawer: SD_TOOL_BAR_DRAWER
			-- Drawer with responsibility for draw OS native looks.

	internal_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- All tool bar items in Current.

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

	start_x, start_y: INTEGER
			-- X/Y postion start to draw buttons.

invariant
	not_void: items /= Void
	not_void: internal_items /= Void

end
