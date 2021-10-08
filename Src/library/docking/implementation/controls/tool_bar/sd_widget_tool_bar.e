note
	description: "[
		Tool bar that support SD_TOOL_BAR_WIDGET_ITEM
		A decorator for SD_TOOL_BAR
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_TOOL_BAR

inherit
	SD_GENERIC_TOOL_BAR
		undefine
			default_create,
			is_equal,
			copy
		end

	EV_FIXED
		rename
			extend as extend_fixed,
			wipe_out as wipe_out_fixed,
			has as has_fixed,
			prune as prune_fixed,
			force as force_fixed,
			has_capture as has_capture_not_use,
			enable_capture as enable_capture_not_use,
			disable_capture as disable_capture_not_use
		undefine
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			is_displayed,
			initialize
		redefine
			destroy
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make (a_tool_bar: SD_TOOL_BAR)
			-- Creation method
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar

			default_create


			extend_fixed (tool_bar)
			tool_bar.expose_actions.extend (agent on_expose)

			internal_shared.widgets.add_tool_bar (Current)
		ensure
			set: tool_bar = a_tool_bar
		end

	initialize
			-- <Precursor>
		do
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, True)
		end

feature -- Properties

	row_height: INTEGER
			-- <Precursor>
		do
			if is_need_calculate_size then
				set_need_calculate_size (False)
				Result := tool_bar.row_height
				from
					start
				until
					after
				loop
					-- Ignore SD_TOOL_BAR's height, only take account of other widgets' height such as EV_COMBO_BOX
					-- Otherwise, when dragging a multi-row floating tool bar, the height is larger and larger after dock it back
					if not attached {SD_TOOL_BAR} item then
						Result := Result.max (item.minimum_height)
					end
					forth
				end
				set_row_height (Result)
			else
				Result := tool_bar.row_height
			end
		end

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM)
			-- <Precursor>
		do
			tool_bar.extend (a_item)
			a_item.set_tool_bar (Current)
			if attached {SD_TOOL_BAR_WIDGET_ITEM} a_item as l_widget_item then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width.max (1), l_widget_item.widget.minimum_height.max (1))
			end
			set_need_calculate_size (True)
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER)
			-- <Precursor>
		do
			tool_bar.force (a_item, a_index)
			if attached {SD_TOOL_BAR_WIDGET_ITEM} a_item as l_widget_item then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
			set_need_calculate_size (True)
		end

	prune (a_item: SD_TOOL_BAR_ITEM)
			-- <Precursor>
		do
			tool_bar.prune (a_item)
			if attached {SD_TOOL_BAR_WIDGET_ITEM} a_item as l_widget_item then
				prune_fixed (l_widget_item.widget)
			end

			if attached {SD_TOOL_BAR_RESIZABLE_ITEM} a_item as l_resizable_item then
				l_resizable_item.clear
			end
			set_need_calculate_size (True)
		end

	compute_minimum_size
			-- <Precursor>
		local
			l_width, l_height: INTEGER
		do
			-- See bug#15525, toolbar can be void if `is_destroyed'
			if not is_destroyed then
				tool_bar.compute_minimum_size

				check has: has_fixed (tool_bar) end

				set_minimum_size (tool_bar.minimum_width, tool_bar.minimum_height)
				l_width := minimum_width
				l_height := minimum_height
				if l_width < 1 then
					l_width := 1
				end
				if l_height < 1 then
					l_height := 1
				end
				set_item_size (tool_bar, l_width, l_height)
			end
		end

	wipe_out
			-- <Precursor>
		do
			tool_bar.wipe_out
		end

	enable_capture
			-- <Precursor>
		do
			tool_bar.enable_capture
		end

	disable_capture
			-- <Precursor>
		do
			tool_bar.disable_capture
		end

	in_main_window: BOOLEAN
			-- If docking in main window?
		do
			if attached {SD_TOOL_BAR_ROW} parent as l_tool_bar_row then
				Result := l_tool_bar_row.docking_manager.query.is_in_main_window (Current)
			end
		end

	resize
			-- Recalculate items sizes in the row
		do
			if attached {SD_TOOL_BAR_ROW} parent as l_tool_bar_row then
				l_tool_bar_row.on_resize (l_tool_bar_row.size)
			end
		end

	resize_for_sizeble_item
			--	Call `resize' when no hidden items exist
		local
			l_content: detachable SD_TOOL_BAR_CONTENT
			l_zone: detachable SD_TOOL_BAR_ZONE
		do
			if attached {SD_TOOL_BAR_ROW} parent as l_tool_bar_row then
				l_content := l_tool_bar_row.docking_manager.tool_bar_manager.content_of (Current)
				if l_content /= Void then
					if l_tool_bar_row.hidden_items.count > 0 then
						resize
					end
					l_zone := l_content.zone
					if l_zone /= Void then
						-- Implied by current docking in SD_TOOL_BAR_ROW implies current is manaaged by docking manager (not using as standalone)
						l_zone.update_maximum_size
					end
				else
					check content_attached: False end
				end
			end
		end

	screen_x_end_row: INTEGER
			-- Maximum x position
		local
			l_zones: ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_found, l_is_end: BOOLEAN
		do
			if attached {SD_TOOL_BAR_ROW} parent as l_tool_bar_row then
				from
					l_zones := l_tool_bar_row.zones
					l_zones.start
				until
					l_zones.after or l_found
				loop
					if l_zones.item_for_iteration.tool_bar = Current then
						l_found := True
					end
					l_is_end := l_zones.index = l_zones.count
					l_zones.forth
				end

				if l_is_end then
					Result := l_tool_bar_row.screen_x + l_tool_bar_row.width
				else
					Result := l_zones.item_for_iteration.tool_bar.screen_x
				end
			end
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
				-- If Current is in a SD_FLOATING_TOOL_BAR_ZONE which is a 3 level parent
				l_parent := parent
				if l_parent /= Void then
					l_parent := l_parent.parent
					if l_parent /= Void then
						l_parent := l_parent.parent
						if attached {EV_WINDOW} l_parent as l_floating_zone then
							l_floating_zone.set_size (l_floating_zone.minimum_width, l_floating_zone.minimum_height)
						end
					end
				end
			end
		end

	set_tooltip (a_tooltip: READABLE_STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'
		do
			tool_bar.set_tooltip (a_tooltip)
		end

	set_need_calculate_size (a_bool: BOOLEAN)
			-- <Precursor>
		do
			tool_bar.set_need_calculate_size (a_bool)
		end

	remove_tooltip
			-- <Precursor>
		do
			tool_bar.remove_tooltip
		end

	destroy
			-- <Precursor>
		do
			if not is_destroyed then
				clear_content
				internal_shared.widgets.prune_tool_bar (Current)
				Precursor {EV_FIXED}
				if not tool_bar.is_destroyed then
					tool_bar.destroy
				end
			end
		end

feature -- Query

	content: detachable SD_TOOL_BAR_CONTENT
			-- <Precursor>
		do
			Result := tool_bar.content
		end

	items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			if tool_bar /= Void then
				Result := tool_bar.items
			else
				create Result.make (0)
			end
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If Current has `a_item'?
		do
				-- When exiting Eiffel Studio, everything is recycling, `tool_bar' maybe void
				-- See bug#14060
			Result := attached tool_bar as l_tool_bar and then l_tool_bar.has (a_item)
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Pointer motion actions
		do
			Result := tool_bar.pointer_motion_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button release actions
		do
			Result := tool_bar.pointer_button_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button press actions
		do
			Result := tool_bar.pointer_button_press_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button double press actions
		do
			Result := tool_bar.pointer_double_press_actions
		end

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Expose actions
		do
			Result := tool_bar.expose_actions
		end

	tooltip: STRING_32
			-- Tooltip
		do
			Result := tool_bar.tooltip
		end

	padding_width: INTEGER
			-- <Precursor>
		do
			Result := tool_bar.padding_width
		end

	is_item_position_valid (a_screen_x, a_screen_y: INTEGER_32): BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_item_position_valid (a_screen_x, a_screen_y)
		end

	is_need_calculate_size: BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_need_calculate_size
		end

	is_item_valid (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_item_valid (a_item)
		end

	is_content_attached: BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_content_attached
		end

	items_have_texts: BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.items_have_texts
		end

feature {SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE}

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' at `a_x', `a_y'
		do
			tool_bar.draw_pixmap (a_x, a_y, a_pixmap)
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear rectangle area
		do
			tool_bar.clear_rectangle (a_x, a_y, a_width, a_height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw rectangle area
		do
			tool_bar.redraw_rectangle (a_x, a_y, a_width, a_height)
		end

feature -- Contract support

	is_parent_set (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If `a_item' parent equal `tool_bar'?
		do
			Result := a_item.tool_bar = Current
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_start_x_set (a_x)
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_start_y_set (a_y)
		end

	is_displayed: BOOLEAN
			-- If Current displayed?
		do
			Result := tool_bar.is_displayed
		end

	has_capture: BOOLEAN
			-- If Current has capture?
		do
			Result := tool_bar.has_capture
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_GENERIC_TOOL_BAR} -- Internal issues

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER
			-- <Precursor>
		do
			Result := tool_bar.item_x (a_item)
		end

	item_y (a_item: SD_TOOL_BAR_ITEM): INTEGER
			-- <Precursor>
		do
			Result := tool_bar.item_y (a_item)
		end

	standard_height: INTEGER
			-- <Precursor>
		do
			Result := tool_bar.standard_height
		end

	set_row_height (a_height: INTEGER)
			-- <Precursor>
		do
			tool_bar.set_row_height (a_height)
		end

	update
			-- <Precursor>
		do
			tool_bar.update
			on_expose (0, 0, width, height)
		end

	all_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		do
			Result := tool_bar.all_items
		end

	set_content (a_content: SD_TOOL_BAR_CONTENT)
			-- <Precursor>
		do
			tool_bar.set_content (a_content)
		end

	clear_content
			-- <Precursor>
		do
			tool_bar.clear_content
		end

	set_start_x (a_x: INTEGER)
			-- <Precursor>
		do
			tool_bar.set_start_x (a_x)
		end

	set_start_y (a_y: INTEGER)
			-- <Precursor>
		do
			tool_bar.set_start_y (a_y)
		end

	start_x: INTEGER
			-- <Precursor>
		do
			Result := tool_bar.start_x
		end

	start_y: INTEGER
			-- <Precursor>
		do
			Result := tool_bar.start_y
		end

	item_at_position (a_screen_x, a_screen_y: INTEGER_32): detachable SD_TOOL_BAR_ITEM
			-- <Precursor>
		do
			Result := tool_bar.item_at_position (a_screen_x, a_screen_y)
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.is_row_height_valid (a_height)
		end

feature {NONE} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM)
			-- Redraw `a_item'
		do
		end

	tool_bar: SD_TOOL_BAR
			-- Tool bar decorated by `Current'.

	drawer: SD_TOOL_BAR_DRAWER
			-- Tool bar drawer
		do
			Result := internal_shared.tool_bar_drawer
			Result.set_tool_bar (tool_bar)
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- <Precursor>
		do
		end

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle tool bar expose actions
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_x, l_item_y: INTEGER
			l_rect: EV_RECTANGLE
			l_widget: EV_WIDGET
			w: INTEGER
		do
			create l_rect.make (a_x, a_y, a_width, a_height)
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				if
					attached {SD_TOOL_BAR_WIDGET_ITEM} l_items.item as l_widget_item and then
					-- There are maybe expose actions have been called delayed, so we should check if has `l_widget_item'.
					(l_widget_item.has_rectangle (l_rect) and then
					has (l_widget_item))
				then
					l_widget := l_widget_item.widget
					if has_fixed (l_widget) then
						l_item_x := item_x (l_widget_item)
						l_item_y := item_y (l_widget_item)
						w := l_widget.minimum_width.max (1)
						if
							l_item_x /= l_widget.x_position
							or else l_item_y /= l_widget.y_position
						then
							set_item_position_and_size (l_widget, l_item_x, l_item_y, w, l_widget.height)
						else
							if l_widget.width /= w then
								set_item_width (l_widget, w)
							end
						end
					end
				end
				l_items.forth
			end
		end

	internal_shared: SD_SHARED
			-- <Precursor>
		do
			Result := tool_bar.internal_shared
		end

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
