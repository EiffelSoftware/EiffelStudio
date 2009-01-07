note
	description: "[
					Tool bar that support SD_TOOL_BAR_WIDGET_ITEM.
					A decorator for SD_TOOL_BAR.
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
			-- Creation method.
		require
			not_void: a_tool_bar /= Void
		do
			tool_bar := a_tool_bar

			tool_bar.expose_actions.extend (agent on_expose)

			default_create

			extend_fixed (tool_bar)

			tool_bar.expose_actions.extend (agent on_tool_bar_expose_actions)

			internal_shared.widgets.add_tool_bar (Current)
		ensure
			set: tool_bar = a_tool_bar
		end

	initialize
			-- Redefine
		do
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, True)
		end

feature -- Properties

	row_height: INTEGER
			-- <Precursor>
		local
			l_tool_bar: SD_TOOL_BAR
		do
			if is_need_calculate_size then
				set_need_calculate_size (False)
				Result := tool_bar.row_height
				from
					start
				until
					after
				loop
					l_tool_bar ?= item
					-- Ignore SD_TOOL_BAR's height, only take account of other widgets' height such as EV_COMBO_BOX.
					-- Otherwise, when dragging a multi-row floating tool bar, the height is larger and larger after dock it back.
					if l_tool_bar = Void then
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
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.extend (a_item)
			a_item.set_tool_bar (Current)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
			set_need_calculate_size (True)
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER)
			-- <Precursor>
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.force (a_item, a_index)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
			set_need_calculate_size (True)
		end

	prune (a_item: SD_TOOL_BAR_ITEM)
			-- <Precursor>
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
			l_resizable_item: SD_TOOL_BAR_RESIZABLE_ITEM
		do
			tool_bar.prune (a_item)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				prune_fixed (l_widget_item.widget)
			end

			l_resizable_item ?= a_item
			if l_resizable_item /= Void then
				l_resizable_item.clear
			end
			set_need_calculate_size (True)
		end

	compute_minimum_size
			-- <Precursor>
		do
			tool_bar.compute_minimum_size
			if {lt_widget: EV_WIDGET} tool_bar then
				check has: has_fixed (lt_widget) end

				set_minimum_size (tool_bar.minimum_width, tool_bar.minimum_height)
				set_item_size (lt_widget, minimum_width, minimum_height)
			else
				check not_possible: False end
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
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				Result := l_tool_bar_row.docking_manager.query.is_in_main_window (Current)
			end
		end

	resize
			-- Recalculate items sizes in the row.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				l_tool_bar_row.on_resize (l_tool_bar_row.size)
			end
		end

	resize_for_sizeble_item
			--	Call `resize' when no hidden items exist.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_content: SD_TOOL_BAR_CONTENT
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				l_content := l_tool_bar_row.docking_manager.tool_bar_manager.content_of (Current)
				check not_void: l_content /= Void end
				if l_content /= Void then
					if l_tool_bar_row.hidden_items.count > 0 then
						resize
					end
					l_content.zone.update_maximum_size
				end
			end
		end

	screen_x_end_row: INTEGER
			-- Maximum x position.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_found, l_is_end: BOOLEAN
			l_next_tool_bar: SD_GENERIC_TOOL_BAR
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then

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
					l_next_tool_bar := l_zones.item_for_iteration.tool_bar
					Result := l_next_tool_bar.screen_x
				end
			end
		end

	update_size
			-- <Precursor>
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_parent: EV_CONTAINER
			l_floating_zone: EV_WINDOW
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

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
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
				set_content (Void)
				internal_shared.widgets.prune_tool_bar (Current)
				Precursor {EV_FIXED}
				if tool_bar /= Void then
					tool_bar.destroy
					tool_bar := Void
				end
			end
		end

feature -- Query

	content: SD_TOOL_BAR_CONTENT
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
		local
			l_tool_bar: like tool_bar
		do
			-- When exiting Eiffel Studio, everything is recycling, `tool_bar' maybe void.
			-- See bug#14060.
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				Result := l_tool_bar.has (a_item)
			end
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Pointer motion actions.
		do
			Result := tool_bar.pointer_motion_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button release actions.
		do
			Result := tool_bar.pointer_button_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button press actions.
		do
			Result := tool_bar.pointer_button_press_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Pointer button double press actions.
		do
			Result := tool_bar.pointer_double_press_actions
		end

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Expose actions.
		do
			if {lt_tool_bar: SD_TOOL_BAR} tool_bar then
				Result := lt_tool_bar.expose_actions
			else
				check not_possible: False end
			end
		end

	tooltip: STRING_32
			-- Tooltip.
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

	items_have_texts: BOOLEAN
			-- <Precursor>
		do
			Result := tool_bar.items_have_texts
		end

feature {SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE}

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP)
			-- Draw `a_pixmap' at `a_x', `a_y'.
		do
			if {lt_tool_bar: SD_TOOL_BAR} tool_bar then
				lt_tool_bar.draw_pixmap (a_x, a_y, a_pixmap)
			else
				check not_possible: False end
			end
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Clear rectangle area.
		do
			tool_bar.clear_rectangle (a_x, a_y, a_width, a_height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Redraw rectangle area.
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

	item_at_position (a_screen_x, a_screen_y: INTEGER_32): SD_TOOL_BAR_ITEM
			-- Redefine
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
			-- Tool bar which decorated by Current.

	drawer: SD_TOOL_BAR_DRAWER
			-- Tool bar drawer.
		do
			Result := internal_shared.tool_bar_drawer
			Result.set_tool_bar (tool_bar)
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			-- Redefine
		do
		end

	on_expose (a_x, a_y, a_width, a_height: INTEGER_32)
			-- <Precursor>
		local
			l_items: like items
			l_rect: EV_RECTANGLE
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
			l_widget: EV_WIDGET
		do
			create l_rect.make (a_x, a_y, a_width, a_height)
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.has_rectangle (l_rect) then
					l_widget_item ?= l_items.item
					if l_widget_item /= Void then
						l_widget := l_widget_item.widget
						if has_fixed (l_widget) then
							set_item_width (l_widget, l_widget.minimum_width)
						end
					end
				end
				l_items.forth
			end
		end

	on_tool_bar_expose_actions (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle tool bar expose actions.
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_item_x, l_item_y: INTEGER
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_item ?= l_items.item
				if l_item /= Void and
					-- There are maybe expose actions have been called delayed, so we should check if has `l_item'.
					 then l_item.has_rectangle (create {EV_RECTANGLE}.make (a_x, a_y, a_width, a_height)) and has (l_item) then
						l_item_x := item_x (l_item)
						l_item_y := item_y (l_item)
						if (l_item_x /= l_item.widget.x_position or else l_item_y /= l_item.widget.y_position) and then has_fixed (l_item.widget) then
							set_item_position (l_item.widget, l_item_x, l_item_y)
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

feature -- Contract support

	line_width: INTEGER
			-- Redefine `line_width' from {EV_DRAWABLE} to make sure invariant not broken.
			-- See bug#13387.
		do
		end

	drawing_mode: INTEGER
			-- Redefine `drawing_mode' from {EV_DRAWABLE} to make sure invariant not broken.
			-- See bug#13387.
		do
		end

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
