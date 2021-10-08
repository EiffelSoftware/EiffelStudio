note
	description: "Tool bar for docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR

inherit
	DEBUG_OUTPUT
		undefine
			default_create,
			copy
		end

	SD_GENERIC_TOOL_BAR
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_DRAWING_AREA
		rename
			has_capture as has_capture_vision2,
			enable_capture as enable_capture_vision2,
			disable_capture as disable_capture_vision2,
			refresh_now as refresh_now_vision2,
			clear_and_redraw as refresh_now
		export
			{NONE} all
			{ANY} width, height, minimum_width, minimum_height,
				 set_background_color, background_color, screen_x,
				  screen_y, hide, show, is_displayed,parent,
					pointer_motion_actions, pointer_button_release_actions,
					x_position, y_position, destroy, out,
					set_minimum_width, set_minimum_height, is_destroyed,
					object_id, is_sensitive, refresh_now
			{SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE, SD_GENERIC_TOOL_BAR} implementation, draw_pixmap, clear_rectangle
			{SD_TOOL_BAR_ITEM, SD_GENERIC_TOOL_BAR} tooltip, set_tooltip, remove_tooltip, font
			{SD_TOOL_BAR_DRAGGING_AGENTS, SD_TOOL_BAR_DOCKER_MEDIATOR, SD_GENERIC_TOOL_BAR, SD_TOOL_BAR_ITEM} set_pointer_style
			{SD_TOOL_BAR_ZONE, SD_GENERIC_TOOL_BAR} expose_actions, pointer_button_press_actions, pointer_double_press_actions,
							redraw_rectangle
			{SD_NOTEBOOK_HIDE_TAB_DIALOG} key_press_actions, focus_out_actions, set_focus, has_focus
			{SD_TOOL_BAR_DRAWER_IMP} draw_ellipsed_text_top_left
			{SD_GENERIC_TOOL_BAR} is_initialized
		redefine
			update_for_pick_and_drop,
			initialize,
			destroy,
			set_background_color,
			create_interface_objects,
			debug_output
		end

	SD_WIDGETS_LISTS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make, default_create

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			default_create
		end

feature {SD_TOOL_BAR} -- Internal initlization

	create_interface_objects
			-- <Precursor>
		do
			Precursor
			create internal_shared
			create internal_items.make (1)
		end

	initialize
			-- Initlialize
		do
			Precursor {SD_DRAWING_AREA}

			internal_row_height := standard_height

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

			add_tool_bar (Current)

				-- Prevent mouse press from taking the focus.
			disable_focus_on_press
		end

feature -- Command

	extend (a_item: like item_type)
			-- <Precursor>
		do
			internal_items.extend (a_item)
			a_item.set_tool_bar (Current)

			is_need_calculate_size := True
		end

	force (a_item: like item_type; a_index: INTEGER)
			-- <Precursor>
		do
			internal_items.go_i_th (a_index)
			internal_items.put_left (a_item)
			a_item.set_tool_bar (Current)
			is_need_calculate_size := True
		end

	prune (a_item: like item_type)
			-- <Precursor>
		do
			internal_items.prune_all (a_item)
			a_item.set_tool_bar (Void)
			is_need_calculate_size := True
		ensure then
			pruned: not has (a_item)
			parent_void: a_item.tool_bar = Void
		end

	compute_minimum_size
			-- <Precursor>
		local
			l_minimum_width: INTEGER
			l_minimum_height: INTEGER
			l_item: like item_type
			l_items: like internal_items
			l_item_before: detachable like item_type
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
				if l_items.index = l_items.count or l_item.is_wrap then
					-- Minimum width only make sence in this case.
					if
						attached {SD_TOOL_BAR_SEPARATOR} l_item and then
							-- It's a separator, we should calculate the item before
						attached l_item_before
					then
						l_item := l_item_before
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

	update_size
			-- <Precursor>
		local
			l_parent: detachable EV_CONTAINER
			l_old_size: INTEGER
		do
			if attached {SD_TOOL_BAR_ROW} parent as l_tool_bar_row then
				-- After `compute_minimum_size', `l_tool_bar_row' size will changed, we record it here.
				-- Otherwise it will cause bug#13164.
				l_old_size := l_tool_bar_row.size
				compute_minimum_size
				l_tool_bar_row.set_item_size (Current, minimum_width, minimum_height)
				l_tool_bar_row.on_resize (l_old_size)
			else
				compute_minimum_size
				-- If Current is in a SD_FLOATING_TOOL_BAR_ZONE which is a 3 level parent.
				l_parent := parent
				if l_parent /= Void then
					l_parent := l_parent.parent
					if l_parent /= Void then
						l_parent := l_parent.parent
						if attached {SD_FLOATING_TOOL_BAR_ZONE} l_parent as l_floating_zone then
							l_floating_zone.set_size (l_floating_zone.minimum_width, l_floating_zone.minimum_height)
						end
					end
				end
			end
		end

	wipe_out
			-- <Precursor>
		do
			internal_items.wipe_out
		end

	enable_capture
			-- <Precursor>
		do
			enable_capture_vision2
		end

	disable_capture
			-- <Precursor>
		do
			disable_capture_vision2
		end

	destroy
			-- <Precursor>
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

			clear_content
			prune_tool_bar (Current)
			Precursor {SD_DRAWING_AREA}
		end

	set_background_color (a_color: like background_color)
			-- <Precursor>
		local
			l_old_background: detachable like background_color
		do
			if is_displayed then
				l_old_background := background_color.twin
			end

			Precursor (a_color)

			if l_old_background /= Void and then not l_old_background.is_equal (background_color) then
				refresh_now
			end
		end

feature {SD_TOOL_BAR_TITLE_BAR, SD_TITLE_BAR} -- Special setting

	preferred_height: INTEGER
			-- Preferred tool bar height
		local
			l_item: like item_type
			l_items: ARRAYED_LIST [like item_type]
			l_height: INTEGER
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_item := l_items.item
				-- We ignore separator
				if not attached {SD_TOOL_BAR_SEPARATOR} l_item then
					if attached l_item.pixmap as l_pixmap then
						l_height := l_pixmap.height + 2 * padding_width
					elseif attached l_item.pixel_buffer as l_pixel_buffer then
						l_height := l_pixel_buffer.height + 2 * padding_width
					elseif attached {SD_TOOL_BAR_WIDGET_ITEM} l_item as l_widget_item then
						l_height := l_widget_item.widget.minimum_height
					end

					if Result < l_height then
						Result := l_height
					end
				end

				l_items.forth
			end
		end

feature -- Query

	items: like internal_items
			-- <Precursor>
		do
			Result := internal_items.twin
		end

	all_items: like internal_items
			-- <Precursor>
		local
			l_items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
		do
			if attached content as c then
				from
					l_items := c.items
					l_items.start
					create Result.make (l_items.count)
				until
					l_items.after
				loop
					if attached {like item_type} l_items.item as l_item then
						Result.extend (l_item)
					else
						-- FIXIT: Maybe we should have SD_MENU_CONTENT? However, SD_MENU_BAR is not complete now
						check menu_bar_only_have_menu_items: False end
					end

					l_items.forth
				end
			else
				Result := items
			end
		end

	has (a_item: like item_type): BOOLEAN
			-- If Current has `a_item'?
		do
			Result := internal_items.has (a_item)
		end

	padding_width: INTEGER = 4
			-- <Precursor>

	standard_height: INTEGER
			-- <Precursor>
		do
			Result := internal_shared.tool_bar_size
		end

	row_height: INTEGER
			-- <Precursor>
		local
			l_font_height, l_pixmap_height: INTEGER
		do
			if is_need_calculate_size then
				is_need_calculate_size := False
				l_pixmap_height := preferred_height
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
		end

	items_have_texts: BOOLEAN
			-- <Precursor>
		local
			l_items: ARRAYED_LIST [like item_type]
		do
			from
				l_items := internal_items
				l_items.start
			until
				l_items.after or Result
			loop
				if attached {SD_TOOL_BAR_BUTTON} l_items.item as l_button then
					Result := l_button.text /= Void
				end

				l_items.forth
			end
		end

	has_capture: BOOLEAN
			-- If current has capture?
			-- We rename `has_capture' from ancestor, because we want remove the postcondition (bridge_ok) in
			-- SD_WIDGET_TOOL_BAR
		do
			Result := has_capture_vision2
		end

	item_type: SD_TOOL_BAR_ITEM
			-- Type of items of Current
		do
			check False end -- Anchor type only
			create {SD_TOOL_BAR_SEPARATOR} Result.make -- Satisfy void-safe compiler
		end

feature -- Contract support

	is_row_height_set (a_new_height: INTEGER): BOOLEAN
			-- If row height set?
		do
			Result := internal_row_height = a_new_height
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := internal_row_height = a_height
		end

	is_parent_set (a_item: like item_type): BOOLEAN
			-- <Precursor>
		do
			Result := a_item.tool_bar = Current
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := start_x = a_x
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := start_y = a_y
		end

	is_item_valid (a_item: like item_type): BOOLEAN
			-- <Precursor>
		do
			Result := True
			if attached {SD_TOOL_BAR_WIDGET_ITEM} a_item as l_widget_item then
				Result := l_widget_item.widget.parent = Void
			end
		end

	is_item_position_valid (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := a_screen_x >= screen_x and a_screen_y >= screen_y
								and a_screen_x < width + screen_x and a_screen_y < height + screen_y
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_GENERIC_TOOL_BAR, SD_SIZES, SD_TOOL_BAR_ZONE} -- Internal issues

	set_need_calculate_size (a_bool: BOOLEAN)
			-- <Precursor>
		do
			is_need_calculate_size := a_bool
		end

	set_row_height (a_height: INTEGER)
			-- <Precursor>
		do
			internal_row_height := a_height
		end

	item_x (a_item: like item_type): INTEGER
			-- <Precursor>
		local
			l_stop: BOOLEAN
			l_item: like item_type
			l_items: like internal_items
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
					l_stop := True
					if attached {SD_TOOL_BAR_SEPARATOR} l_item as l_separator and then l_separator.is_wrap then
						Result := start_x
					end
				end
				l_items.forth
			end
		end

	item_y (a_item: like item_type): INTEGER
			-- <Precursor>
		local
			l_stop: BOOLEAN
			l_item: like item_type
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
				if l_item /= a_item then
					if l_item.is_wrap then
						Result := Result + l_item.height
					end
					if attached {SD_TOOL_BAR_SEPARATOR} l_item as l_separator and then l_separator.is_wrap then
						Result := Result + l_separator.width
					end
				else
					l_stop := True
					if attached {SD_TOOL_BAR_SEPARATOR} l_item as l_separator and then l_separator.is_wrap then
						Result := Result + l_item.height
					end
				end
				l_items.forth
			end
		end

	update
			-- <Precursor>
		local
			l_items: ARRAYED_LIST [like item_type]
			l_item: like item_type
		do
			if width /= 0 and height /= 0 then
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					-- item's tool bar query maybe Void, because it's hidden when not enough space to display
					l_item := l_items.item
					if l_item.is_need_redraw and l_item.tool_bar /= Void then
						drawer.start_draw (l_item.rectangle)
						redraw_item (l_item)
						drawer.end_draw
						l_item.disable_redraw
					end
					l_items.forth
				end
			end
		end

feature {SD_TOOL_BAR_ZONE, SD_GENERIC_TOOL_BAR} -- Tool bar zone issues

	set_start_x (a_x: INTEGER)
			-- <Precursor>
		do
			internal_start_x := a_x
		end

	set_start_y (a_y: INTEGER)
			-- <Precursor>
		do
			internal_start_y := a_y
		end

	start_x: INTEGER
			-- <Precursor>
		do
			Result := internal_start_x
		end

	start_y: INTEGER
			-- <Precursor>
		do
			Result := internal_start_y
		end

feature {NONE} -- Agents

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle expose actions
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

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer motion actions
		local
			l_items: like internal_items
			l_item: like item_type
			l_capture_enabled: BOOLEAN
		do
			-- Special handing for GTK
			-- Because on GTK, pointer leave actions doesn't have same behavior as Windows implementation
			-- This will cause `pointer_entered' flag not same between Windows and Gtk after pressed at SD_TOOL_BAR_RESIZABLE_ITEM end area
			if not {PLATFORM}.is_windows then
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

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer press actions
		local
			l_items: like internal_items
			l_item: like item_type
		do
			debug ("docking")
				print ("%NSD_TOOL_BAR on_pointer_press")
			end
				-- We only handle press/release occurring in the widget (i.e. we ignore the one outside of the widget).		
				-- Otherwise it will cause bug#12549
			if
				a_screen_x >= screen_x and a_screen_x <= screen_x + width and
				a_screen_y >= screen_y  and a_screen_y <= screen_y + height and then
				a_button = {EV_POINTER_CONSTANTS}.left
			then
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

	on_pointer_press_forwarding (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer press actions for forwarding
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

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release actions.
		local
			l_items: like internal_items
			l_item: like item_type
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
					-- Reset state value and disable capture should not care about the pointer position. Otherwise capture will still enabled if end user released the pointer button outside current.
				disable_capture
				internal_pointer_pressed := False
			end

				-- We only handle press/release occurring in the widget (i.e. we ignore the one outside of the widget).
				-- Otherwise it will cause bug#12549.
			if
				a_screen_x >= screen_x and a_screen_x <= screen_x + width and
				a_screen_y >= screen_y  and a_screen_y <= screen_y + height and then
				a_button = {EV_POINTER_CONSTANTS}.left
			then
				from
					l_items := items
					l_items.start
				until
					l_items.after
				loop
					l_item := l_items.item
					l_item.on_pointer_release (a_x, a_y)
					if l_item.is_displayed and then l_item.is_need_redraw and then (attached l_item.tool_bar as l_tool_bar and then not l_tool_bar.is_destroyed) then
							--| FIXME According to LarryL, if l_item.is_displayed is False, then the toolbar is Void, this appears to not be the case in
							--| some circumstances so the protection has been added
						drawer.start_draw (l_item.rectangle)
						redraw_item (l_item)
						drawer.end_draw
					end
					l_items.forth
				end
			end
		end

	on_pointer_enter
			-- Handle poiner enter actions
			-- Pointer enter actions and pointer leave actions always called in pairs
			-- That means: `on_pointer_motion' actions can be called without `on_pointer_enter' be called
			-- That will let tool bar item draw hot state (which is done by `pointer_motion_actions'), but no pointer leave actions to erase the hot state
		do
			pointer_entered := True
		ensure
			set: pointer_entered
		end

	on_pointer_leave
			-- Handle pointer leave actions
		local
			l_items: like internal_items
			l_item: like item_type
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
			set: not pointer_entered
		end

	on_drop_action (a_any: ANY)
			-- Handle drop actions
		local
			l_item: like item_type
			l_pointer_position: EV_COORDINATE
		do
			l_pointer_position := (create {EV_SCREEN}).pointer_position
			l_item := item_at_position (l_pointer_position.x, l_pointer_position.y)
			if l_item /= Void then
				l_item.drop_actions.call ([a_any])
			end
		end

	on_veto_pebble_function (a_any: ANY): BOOLEAN
			-- Handle veto pebble function.
		local
			l_pointer_position: EV_COORDINATE
		do
				-- We do not accept any stone if we are hidden.
			if is_displayed then
				l_pointer_position := (create {EV_SCREEN}).pointer_position
				if
					is_item_position_valid (l_pointer_position.x, l_pointer_position.y) and then
					attached item_at_position (l_pointer_position.x, l_pointer_position.y) as l_item and then
					l_item.is_sensitive
				then
					Result := l_item.drop_actions.accepts_pebble (a_any)
				end
			end
		end

	on_pebble_function: detachable ANY
			-- Handle pebble function event
		local
			l_item: detachable like item_type
			l_position: EV_COORDINATE
		do
			l_position := (create {EV_SCREEN}).pointer_position
			if is_item_position_valid (l_position.x, l_position.y) then
				l_item := item_at_position (l_position.x, l_position.y)
			end
			if l_item /= Void and then attached l_item.pebble_function as l_function then
				Result := l_function.item ([l_position.x, l_position.y])
				if Result /= Void then
						-- We have a pebble, ensure we use the p&d cursors
						-- set in `l_item' if any.
					set_accept_cursor (l_item.accept_cursor)
					set_deny_cursor (l_item.deny_cursor)
				end
			end
		end

feature {SD_GENERIC_TOOL_BAR, SD_TOOL_BAR_ZONE} -- Implementation

	set_content (a_content: SD_TOOL_BAR_CONTENT)
			-- <Precursor>
		do
			content := a_content
		end

	clear_content
			-- <Precursor>
		do
			content := Void
		end

	content: detachable SD_TOOL_BAR_CONTENT
			-- <Precursor>

	redraw_item (a_item: like item_type)
			-- Redraw `a_item'
		require
			not_void: a_item /= Void
		local
			l_argu: SD_TOOL_BAR_DRAWER_ARGUMENTS
			l_coordinate: EV_COORDINATE
		do
			if not attached {SD_TOOL_BAR_WIDGET_ITEM} a_item then
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

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: detachable ANY)
			-- Update items for pick and drop
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
			-- Drawer with responsibility for draw OS native looks
		do
			Result := internal_shared.tool_bar_drawer
			Result.set_tool_bar (Current)
		end

	internal_items: ARRAYED_SET [like item_type]
			-- All tool bar items in Current

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

	item_at_position (a_screen_x, a_screen_y: INTEGER): detachable like item_type
			-- <Precursor>
			-- Result maybe void since there are tool bar drag areas at head of tool bar
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

	internal_row_height: INTEGER
			-- Row height of Current

	internal_start_x: INTEGER
			-- X postion start to draw buttons

	internal_start_y: INTEGER
			-- Y postion start to draw buttons

	is_need_calculate_size: BOOLEAN
			-- <Precursor>

	is_content_attached: BOOLEAN
			-- <Precursor>
		do
			Result := attached content
		end

feature {NONE} -- Output

	debug_output: STRING_32
		do
			Result := Precursor
			Result.append ("::SD_TOOL_BAR: ")
			Result.append
				(if attached content as c then
					c.title
				else
					{STRING_32} "no content"
				end)
		end

invariant
	items_not_void: items /= Void
	internal_items_not_void: internal_items /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
