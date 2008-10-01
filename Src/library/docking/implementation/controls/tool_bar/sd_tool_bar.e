indexing
	description: "Tool bar for docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR

inherit
	SD_DRAWING_AREA
		rename
			has_capture as has_capture_vision2,
			enable_capture as enable_capture_vision2,
			disable_capture as disable_capture_vision2
		export
			{NONE} all
			{ANY} width, height, minimum_width, minimum_height,
				 set_background_color, background_color, screen_x,
				  screen_y, hide, show, is_displayed,parent,
					pointer_motion_actions, pointer_button_release_actions,
					x_position, y_position, destroy, out,
					set_minimum_width, set_minimum_height, is_destroyed,
					object_id
			{SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE, SD_TOOL_BAR} implementation, draw_pixmap, clear_rectangle
			{SD_TOOL_BAR_ITEM, SD_TOOL_BAR} tooltip, set_tooltip, remove_tooltip, font
			{SD_TOOL_BAR_DRAGGING_AGENTS, SD_TOOL_BAR_DOCKER_MEDIATOR, SD_TOOL_BAR, SD_TOOL_BAR_ITEM} set_pointer_style
			{SD_TOOL_BAR_ZONE, SD_TOOL_BAR} expose_actions, pointer_button_press_actions, pointer_double_press_actions,
							redraw_rectangle
			{SD_NOTEBOOK_HIDE_TAB_DIALOG} key_press_actions, focus_out_actions, set_focus, has_focus
			{SD_TOOL_BAR_DRAWER_IMP} draw_ellipsed_text_top_left
			{SD_TOOL_BAR} is_initialized
		redefine
			update_for_pick_and_drop,
			initialize,
			destroy
		end

	SD_WIDGETS_LISTS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			default_create
			add_tool_bar (Current)
		end

feature {SD_TOOL_BAR} -- Internal initlization

	initialize is
			-- Initlialize
		do
			Precursor {SD_DRAWING_AREA}

			create internal_shared
			internal_row_height := standard_height
			create internal_items.make (1)
			expose_actions.extend (agent on_expose)
			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_button_press_actions.extend (agent on_pointer_press_forwarding)
			pointer_double_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_leave_actions.extend (agent on_pointer_leave)
			pointer_enter_actions.extend (agent on_pointer_enter)

			drop_actions.extend (agent on_drop_action)
			drop_actions.set_veto_pebble_function (agent on_veto_pebble_function)
			set_pebble_function (agent on_pebble_function)

			set_background_color (internal_shared.default_background_color)
		end

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item' to the end.
		require
			not_void: a_item /= Void
			valid: is_item_valid (a_item)
		do
			internal_items.extend (a_item)
			a_item.set_tool_bar (Current)

			is_need_calculate_size := True
		ensure
			has: has (a_item)
			is_parent_set: is_parent_set (a_item)
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER) is
			-- Assign item `a_item' to `a_index'-th entry.
			-- Always applicable: resize the array if `a_index' falls out of
			-- currently defined bounds; preserve existing items.
		require
			not_void: a_item /= Void
			valid: is_item_valid (a_item)
		do
			internal_items.go_i_th (a_index)
			internal_items.put_left (a_item)
			a_item.set_tool_bar (Current)
			is_need_calculate_size := True
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		do
			internal_items.prune_all (a_item)
			a_item.set_tool_bar (Void)
			is_need_calculate_size := True
		ensure
			pruned: not has (a_item)
			parent_void: a_item.tool_bar = Void
		end

	compute_minimum_size is
			-- Compute `minmum_width' and `minimum_height'.
		local
			l_minimum_width: INTEGER
			l_minimum_height: INTEGER
			l_item: SD_TOOL_BAR_ITEM
			l_items: like internal_items
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_item_before: SD_TOOL_BAR_ITEM
		do
			from
				l_items := items
				l_items.start
				if l_items.count > 0 then
					l_minimum_height := row_height
				end
			until
				l_items.after
			loop
				l_item := l_items.item
				l_separator ?= l_item
				if l_items.index = l_items.count or l_item.is_wrap then
					-- Minimum width only make sence in this case.
					if l_separator /= Void then
						-- It's a separator, we should calculate the item before
						if l_item_before /= Void then
							l_item := l_item_before
						end
					end
					if l_minimum_width < l_item.rectangle.right then
						l_minimum_width := l_item.rectangle.right
					end
				end
				if l_items.index = l_items.count then
					l_minimum_height := l_item.rectangle.bottom
				end

				l_item_before := l_items.item
				l_items.forth
			end
			debug ("docking")
				print ("%NSD_TOOL_BAR compute minimum size minimum_width is: " + l_minimum_width.out)
				print ("%NSD_TOOL_BAR compute minimum size minimum_height is: " + l_minimum_height.out)
				print ("%N             items.count: " + l_items.count.out)
			end

			set_minimum_width (l_minimum_width)
			set_minimum_height (l_minimum_height)
		end

	update_size is
			-- Update `tool_bar' size if Current width changed.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_parent: EV_CONTAINER
			l_floating_zone: SD_FLOATING_TOOL_BAR_ZONE
			l_old_size: INTEGER
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				-- After `compute_minimum_size', `l_tool_bar_row' size will changed, we record it here.
				-- Otherwise it will cause bug#13164.
				l_old_size := l_tool_bar_row.size
			end
			compute_minimum_size
			if l_tool_bar_row /= Void then
				l_tool_bar_row.set_item_size (Current, minimum_width, minimum_height)
				l_tool_bar_row.on_resize (l_old_size)
			else
				-- If Current is in a SD_FLOATING_TOOL_BAR_ZONE which is a 3 level parent.
				l_parent := parent
				if l_parent /= Void then
					l_parent := l_parent.parent
					if l_parent /= Void then
						l_parent := l_parent.parent
						l_floating_zone ?= l_parent
						if l_floating_zone /= Void then
							l_floating_zone.set_size (l_floating_zone.minimum_width, l_floating_zone.minimum_height)
						end
					end
				end
			end
		end

	wipe_out is
			-- Wipe out
		do
			internal_items.wipe_out
		end

	enable_capture is
			-- Enable capture
		do
			enable_capture_vision2
		end

	disable_capture is
			-- Disable capture
		do
			disable_capture_vision2
		end

	destroy	is
			-- Redefine
		do
			expose_actions.wipe_out
			pointer_motion_actions.wipe_out
			pointer_button_press_actions.wipe_out
			pointer_button_press_actions.wipe_out
			pointer_double_press_actions.wipe_out
			pointer_button_release_actions.wipe_out
			pointer_leave_actions.wipe_out
			pointer_enter_actions.wipe_out
			drop_actions.wipe_out
			drop_actions.set_veto_pebble_function (Void)

			content := Void
			prune_tool_bar (Current)
			Precursor {SD_DRAWING_AREA}
		end

feature {SD_TOOL_BAR_TITLE_BAR, SD_TITLE_BAR} -- Special setting

	prefered_height: INTEGER is
			-- Prefered tool bar height.
		local
			l_item: SD_TOOL_BAR_ITEM
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_height: INTEGER
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_item := l_items.item
				l_separator ?= l_item
				-- We ignore separator
				if l_separator = Void then
					if l_item.pixmap /= Void then
						l_height := l_item.pixmap.height + 2 * padding_width
					elseif l_item.pixel_buffer /= Void then
						l_height := l_item.pixel_buffer.height + 2 * padding_width
					end

					if Result < l_height then
						Result := l_height
					end
				end

				l_items.forth
			end
		end

feature -- Query

	items: like internal_items is
			-- Visible items
		do
			Result := internal_items.twin
		ensure
			not_void: Result /= Void
		end

	all_items: like internal_items is
			-- All items
		do
			if content /= Void then
				Result := content.items.twin
			else
				Result := items
			end
		ensure
			not_void: Result /= Void
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item' ?
		do
			Result := internal_items.has (a_item)
		end

	padding_width: INTEGER is 4
			-- Padding width.

	standard_height: INTEGER is
			-- Standard tool bar height.
		do
			Result := internal_shared.tool_bar_size
		end

	row_height: INTEGER is
			-- Height of row.
		local
			l_font_height, l_pixmap_height: INTEGER
		do
			if is_need_calculate_size then
				is_need_calculate_size := False
				l_pixmap_height := prefered_height
				if not items_have_texts then
					Result := l_pixmap_height
				else
					l_font_height := standard_height
					if l_font_height >= l_pixmap_height then
						Result := l_font_height
					else
						Result := l_pixmap_height
					end
				end
				internal_row_height := Result
			else
				Result := internal_row_height
			end
		ensure
			valid: is_row_height_valid (Result)
		end

	items_have_texts: BOOLEAN is
			-- If any item has text?
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_button: SD_TOOL_BAR_BUTTON
		do
			from
				l_items := internal_items
				l_items.start
			until
				l_items.after or Result
			loop
				l_button ?= l_items.item
				if l_button /= Void then
					if l_button.text /= Void then
						Result := True
					end
				end

				l_items.forth
			end
		end

	has_capture: BOOLEAN is
			-- If current has capture?
			-- We rename `has_capture' from ancestor, because we want remove the postcondition (bridge_ok) in
			-- SD_WIDGET_TOOL_BAR.
		do
			Result := has_capture_vision2
		end

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

	is_item_valid (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If `a_item' valid?
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			Result := True
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				Result := l_widget_item.widget.parent = Void
			end
		end

	is_item_position_valid (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `a_screen_x' and `a_screen_y' within tool bar items area?
		do
			Result := a_screen_x >= screen_x and a_screen_y >= screen_y
								and a_screen_x < width + screen_x and a_screen_y < height + screen_y
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_TOOL_BAR, SD_SIZES, SD_TOOL_BAR_ZONE} -- Internal issues

	need_calculate_size is
			-- Set if need recalculate `row_height'.
		do
			is_need_calculate_size := True
		end

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Relative x position of `a_item'.
		require
			has: has (a_item)
		local
			l_stop: BOOLEAN
			l_item: SD_TOOL_BAR_ITEM
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
				l_item := l_items.item
				if l_item /= a_item then
					if l_item.is_wrap then
						Result := start_x
					else
						Result := Result + l_item.width
					end
				else
					l_separator ?= l_item
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
			l_item: SD_TOOL_BAR_ITEM
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
				l_item := l_items.item
				l_separator ?= l_item
				if l_item /= a_item then
					if l_item.is_wrap then
						Result := Result + l_item.height
					end
					if l_separator /= Void and then l_separator.is_wrap then
						Result := Result + l_separator.width
					end
				else
					l_stop := True
					if l_separator /= Void and then l_separator.is_wrap then
						Result := Result + l_item.height
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
			l_item: SD_TOOL_BAR_ITEM
		do
			if width /= 0 and height /= 0 then
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					-- item's tool bar query maybe Void, because it's hidden when not enough space to display.
					l_item := l_items.item
					if l_item.is_need_redraw and l_item.tool_bar /= Void then
						l_rect := l_item.rectangle
						drawer.start_draw (l_rect)
						redraw_item (l_item)
						drawer.end_draw
						l_item.disable_redraw
					end
					l_items.forth
				end
			end
		end

feature {SD_TOOL_BAR_ZONE, SD_TOOL_BAR} -- Tool bar zone issues

	set_start_x (a_x: INTEGER) is
			-- Set start x position with `a_x'.
		do
			internal_start_x := a_x
		ensure
			set: is_start_x_set (a_x)
		end

	set_start_y (a_y: INTEGER) is
			-- Set start y position with `a_y'.
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
			l_rect: EV_RECTANGLE
		do
			create l_rect.make (a_x, a_y, a_width, a_height)
			drawer.start_draw (l_rect)
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.has_rectangle (l_rect) then
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
			l_item: SD_TOOL_BAR_ITEM
			l_platform: PLATFORM
			l_capture_enabled: BOOLEAN
		do
			-- Special handing for GTK.
			-- Because on GTK, pointer leave actions doesn't have same behavior as Windows implementation.
			-- This will cause `pointer_entered' flag not same between Windows and Gtk after pressed at SD_TOOL_BAR_RESIZABLE_ITEM end area.
			create l_platform
			if not l_platform.is_windows then
				l_capture_enabled := has_capture
			end

			if pointer_entered or l_capture_enabled then
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					l_item := l_items.item
					l_item.on_pointer_motion (a_x, a_y)
					l_item.on_pointer_motion_for_tooltip (a_x, a_y)
					if l_item.is_need_redraw then
						drawer.start_draw (l_item.rectangle)
						redraw_item (l_item)
						drawer.end_draw
					end
					l_items.forth
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions.
		local
			l_items: like internal_items
			l_item: SD_TOOL_BAR_ITEM
		do
			debug ("docking")
				print ("%NSD_TOOL_BAR on_pointer_press")
			end
			-- We only handle press/release occurring in the widget (i.e. we ignore the one outside of the widget).			
			-- Otherwise it will cause bug#12549.
			if a_screen_x >= screen_x and a_screen_x <= screen_x + width and
				a_screen_y >= screen_y  and a_screen_y <= screen_y + height then

				if a_button = {EV_POINTER_CONSTANTS}.left then
					enable_capture
					from
						l_items := items
						l_items.start
					until
						l_items.after
					loop
						l_item := l_items.item
						l_item.on_pointer_press (a_x, a_y)
						if l_item.is_need_redraw then
							drawer.start_draw (l_item.rectangle)
							redraw_item (l_item)
							drawer.end_draw
						end
						l_items.forth
					end
				end
			end
		end

	on_pointer_press_forwarding (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press actions for forwarding.
		local
			l_items: like internal_items
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_items.item.on_pointer_press_forwarding (a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
				l_items.forth
			end
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release actions.
		local
			l_items: like internal_items
			l_item: SD_TOOL_BAR_ITEM
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				-- Reset state value and disable capture should not care about the pointer position. Otherwise capture will still enabled if end user released the pointer button outside current.
				disable_capture
				internal_pointer_pressed := False
			end

			-- We only handle press/release occurring in the widget (i.e. we ignore the one outside of the widget).			
			-- Otherwise it will cause bug#12549.			
			if a_screen_x >= screen_x and a_screen_x <= screen_x + width and
				a_screen_y >= screen_y  and a_screen_y <= screen_y + height then

				if a_button = {EV_POINTER_CONSTANTS}.left then
					from
						l_items := items
						l_items.start
					until
						l_items.after
					loop
						l_item := l_items.item
						l_item.on_pointer_release (a_x, a_y)
						if l_item.is_displayed and then l_item.is_need_redraw and then l_item.tool_bar /= Void and then not l_item.tool_bar.is_destroyed then
							--| FIXME According to LarryL, if l_item.is_displayed is False, then the toolbar is Void, this appears to not be the case in
							--| some circumstances so the protection has been added.
							drawer.start_draw (l_item.rectangle)
							redraw_item (l_item)
							drawer.end_draw
						end
						l_items.forth
					end
				end
			end
		end

	on_pointer_enter is
			-- Handle poiner enter actions.
			-- Pointer enter actions and pointer leave actions always called in pairs.
			-- That means: `on_pointer_motion' actions can be called without `on_pointer_enter' be called.
			-- That will let tool bar item draw hot state (which is done by `pointer_motion_actions'), but no pointer leave actions to erase the hot state.
		do
			pointer_entered := True
		ensure
			set: pointer_entered = True
		end

	on_pointer_leave is
			-- Handle pointer leave actions.
		local
			l_items: like internal_items
			l_item: SD_TOOL_BAR_ITEM
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_item := l_items.item
				l_item.on_pointer_leave
				if l_item.is_need_redraw then
					drawer.start_draw (l_item.rectangle)
					redraw_item (l_item)
					drawer.end_draw
				end
				l_items.forth
			end
			pointer_entered := False
		ensure
			set: pointer_entered = False
		end

	on_drop_action (a_any: ANY) is
			-- Handle drop actions.
		local
			l_screen: EV_SCREEN
			l_item: SD_TOOL_BAR_ITEM
			l_pointer_position: EV_COORDINATE
		do
			create l_screen
			l_pointer_position := l_screen.pointer_position
			l_item := item_at_position (l_pointer_position.x, l_pointer_position.y)
			if l_item /= Void then
				l_item.drop_actions.call ([a_any])
			end
		end

	on_veto_pebble_function (a_any: ANY): BOOLEAN is
			-- Handle veto pebble function.
		local
			l_screen: EV_SCREEN
			l_item: SD_TOOL_BAR_ITEM
			l_pointer_position: EV_COORDINATE
			l_stock_pixmap: EV_STOCK_PIXMAPS
		do
			create l_screen
			l_pointer_position := l_screen.pointer_position
			if is_item_position_valid (l_pointer_position.x, l_pointer_position.y)  then
				l_item := item_at_position (l_pointer_position.x, l_pointer_position.y)
				if l_item /= Void then
					Result := l_item.drop_actions.accepts_pebble (a_any)
					create l_stock_pixmap
					if l_item.accept_cursor /= Void then
						set_accept_cursor (l_item.accept_cursor)
					else
						set_accept_cursor (l_stock_pixmap.standard_cursor)
					end
					if l_item.deny_cursor /= Void then
						set_deny_cursor (l_item.deny_cursor)
					else
						set_deny_cursor (l_stock_pixmap.no_cursor)
					end
				end
			end
		end

	on_pebble_function: ANY is
			-- Handle pebble function event.
		local
			l_item: SD_TOOL_BAR_ITEM
			l_screen: EV_SCREEN
			l_position: EV_COORDINATE
		do
			create l_screen
			l_position := l_screen.pointer_position
			if is_item_position_valid (l_position.x, l_position.y) then
				l_item := item_at_position (l_position.x, l_position.y)
			end
			if l_item /= Void and then l_item.pebble_function /= Void then
				l_item.pebble_function.call ([])
				Result := l_item.pebble_function.last_result
			end
		end

feature {SD_TOOL_BAR, SD_TOOL_BAR_ZONE} -- Implementation

	set_content (a_content: like content) is
			-- Set `content' with `a_content'.
		do
			content := a_content
		ensure
			content_set: content = a_content
		end

	content: SD_TOOL_BAR_CONTENT
			-- Related tool bar content

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

	drawer: SD_TOOL_BAR_DRAWER is
			-- Drawer with responsibility for draw OS native looks.
		do
			Result := internal_shared.tool_bar_drawer
			Result.set_tool_bar (Current)
		end

	internal_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- All tool bar items in Current.

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

	item_at_position (a_screen_x, a_screen_y: INTEGER): SD_TOOL_BAR_ITEM is
			-- Item at `a_screen_x', `a_screen_y'
			-- Result may be void when there wraps.
		require
			in_position: is_item_position_valid (a_screen_x, a_screen_y)
		local
			l_x, l_y: INTEGER
			l_items: like internal_items
		do
			from
				l_x := a_screen_x - screen_x
				l_y := a_screen_y - screen_y
				l_items := internal_items
				l_items.start
			until
				l_items.after or Result /= Void
			loop
				Result := l_items.item
				if not Result.rectangle.has_x_y (l_x, l_y) then
					Result := Void
				end
				l_items.forth
			end
		end

	pointer_entered: BOOLEAN
			-- Has pointer enter actions been called?
			-- The reason why have this flag see `on_pointer_enter''s comments.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_row_height: INTEGER
			-- Row height of Current.

	internal_start_x: INTEGER
			-- X postion start to draw buttons.

	internal_start_y: INTEGER
			-- Y postion start to draw buttons.

	is_need_calculate_size: BOOLEAN
			-- Need recalcualte current `row_height'? Because some thing changed?

invariant
	items_not_void: items /= Void
	internal_items_not_void: internal_items /= Void

indexing
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
