indexing
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
	SD_TOOL_BAR
		rename
			make as make_tool_bar,
			implementation as implementation_not_use
		undefine
			create_implementation,
			is_in_default_state,
			is_equal,
			destroy
		redefine
			row_height,
			extend,
			force,
			prune,
			compute_minimum_size,
			wipe_out,
			items,
			has,
			item_x,
			item_y,
			update,
			is_parent_set,
			is_start_x_set,
			is_start_y_set,
			enable_capture,
			disable_capture,
			has_capture,
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			expose_actions,
			draw_pixmap,
			clear_rectangle,
			redraw_rectangle,
			set_start_x,
			set_start_y,
			start_x,
			start_y,
			redraw_item,
			is_displayed,
			update_size,
			tooltip,
			set_tooltip,
			is_bridge_ok,
			is_cloned,
			drawer,
			items_have_texts,
			on_pointer_release,
			on_expose,
			initialize,
			item_at_position,
			line_width,
			drawing_mode
		select
			has_capture_vision2,
			enable_capture_vision2,
			disable_capture_vision2
		end

	SD_FIXED
		rename
			extend as extend_fixed,
			wipe_out as wipe_out_fixed,
			has as has_fixed,
			prune as prune_fixed,
			force as force_fixed,
			has_capture as has_capture_not_use,
			enable_capture as enable_capture_not_use,
			disable_capture as disable_capture_not_use
		export
			{NONE} all
			{ANY} is_destroyed
		undefine
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			is_displayed,
			initialize
		redefine
			destroy
		select
			implementation
		end

create
	make

feature {NONE} -- Initlization

	make (a_tool_bar: SD_TOOL_BAR) is
			-- Creation method.
		require
			not_void: a_tool_bar /= Void
		do

			create internal_shared

			tool_bar := a_tool_bar

			tool_bar.expose_actions.extend (agent on_expose)
			default_create

			extend_fixed (tool_bar)

			tool_bar.expose_actions.extend (agent on_tool_bar_expose_actions)

			-- We create this only for making sure the invariant not borken.
			create internal_items.make (0)

			internal_shared.widgets.add_tool_bar (Current)
		ensure
			set: tool_bar = a_tool_bar
		end

	initialize is
			-- Redefine
		do
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, True)
		end

feature -- Properties

	row_height: INTEGER is
			--  Height of row.
		local
			l_tool_bar: SD_TOOL_BAR
		do
			if is_need_calculate_size then
				is_need_calculate_size := False
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
				internal_row_height  := Result
			else
				Result := internal_row_height
			end
		end

feature -- Command

	extend (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item'.
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
			is_need_calculate_size := True
		end

	force (a_item: SD_TOOL_BAR_ITEM; a_index: INTEGER) is
			-- Extend `a_item' at `a_index'
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.force (a_item, a_index)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				extend_fixed (l_widget_item.widget)
				set_item_size (l_widget_item.widget, l_widget_item.widget.minimum_width, l_widget_item.widget.minimum_height)
			end
			is_need_calculate_size := True
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
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
			is_need_calculate_size := True
		end

	compute_minimum_size is
			-- Compute minimum size.
		do
			tool_bar.compute_minimum_size
			check has: has_fixed (tool_bar) end
			set_minimum_size (tool_bar.minimum_width, tool_bar.minimum_height)
			set_item_size (tool_bar, minimum_width, minimum_height)
		end

	wipe_out is
			-- Wipe out.
		do
			tool_bar.wipe_out
		end

	enable_capture is
			-- Enable capture.
		do
			tool_bar.enable_capture
		end

	disable_capture is
			-- Disable capture.
		do
			tool_bar.disable_capture
		end

	in_main_window: BOOLEAN is
			-- If docking in main window?
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				Result := l_tool_bar_row.docking_manager.query.is_in_main_window (Current)
			end
		end

	resize is
			-- Recalculate items sizes in the row.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				l_tool_bar_row.on_resize (l_tool_bar_row.size)
			end
		end

	resize_for_sizeble_item is
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

	screen_x_end_row: INTEGER is
			-- Maximum x position.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_zones: DS_ARRAYED_LIST [SD_TOOL_BAR_ZONE]
			l_found, l_is_end: BOOLEAN
			l_next_tool_bar: SD_TOOL_BAR
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

	update_size is
			-- Update `tool_bar' size if Current width changed.
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

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			tool_bar.set_tooltip (a_tooltip)
		end

	destroy is
			-- Redefine
		do
			content := Void
			internal_shared.widgets.prune_tool_bar (Current)
			Precursor {SD_FIXED}
			if tool_bar /= Void then
				tool_bar.destroy
				tool_bar := Void
			end
		end

feature -- Query

	items: ARRAYED_SET [SD_TOOL_BAR_ITEM] is
			-- All items in Current.
		do
			Result := tool_bar.items
		end

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item'?
		do
			Result := tool_bar.has (a_item)
		end

	pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE	is
			-- Pointer motion actions.
		do
			Result := tool_bar.pointer_motion_actions
		end

	pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button release actions.
		do
			Result := tool_bar.pointer_button_release_actions
		end

	pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button press actions.
		do
			Result := tool_bar.pointer_button_press_actions
		end

	pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Pointer button double press actions.
		do
			Result := tool_bar.pointer_double_press_actions
		end

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Expose actions.
		do
			Result := tool_bar.expose_actions
		end

	tooltip: STRING_32 is
			-- Tooltip.
		do
			Result := tool_bar.tooltip
		end

	is_bridge_ok (a_string: STRING_32): BOOLEAN is
			-- Fake implementation for decorator pattern.
		do
			Result := True
		end

	is_cloned (a_string: STRING_32): BOOLEAN is
			-- Fake implementation for decorator pattern.
		do
			Result := True
		end

	items_have_texts: BOOLEAN is
			-- Redefine.
		do
			Result := tool_bar.items_have_texts
		end

feature {SD_TOOL_BAR_DRAWER_I, SD_TOOL_BAR_ZONE}

	draw_pixmap (a_x, a_y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' at `a_x', `a_y'.
		do
			tool_bar.draw_pixmap (a_x, a_y, a_pixmap)
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Clear rectangle area.
		do
			tool_bar.clear_rectangle (a_x, a_y, a_width, a_height)
		end

	redraw_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw rectangle area.
		do
			tool_bar.redraw_rectangle (a_x, a_y, a_width, a_height)
		end

feature -- Contract support

	is_parent_set (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If `a_item' parent equal `tool_bar'?
		do
			Result := a_item.tool_bar = Current
		end

	is_start_x_set (a_x: INTEGER): BOOLEAN is
			-- If `a_x' equal `start_x' of `tool_bar'?
		do
			Result := tool_bar.is_start_x_set (a_x)
		end

	is_start_y_set (a_y: INTEGER): BOOLEAN is
			-- If `a_y' equal `start_y' of `tool_bar'?
		do
			Result := tool_bar.is_start_y_set (a_y)
		end

	is_displayed: BOOLEAN is
			-- If Current displayed?
		do
			Result := tool_bar.is_displayed
		end

	has_capture: BOOLEAN is
			-- If Current has capture?
		do
			Result := tool_bar.has_capture
		end

feature {SD_TOOL_BAR_DRAWER_IMP, SD_TOOL_BAR_ITEM, SD_TOOL_BAR} -- Internal issues

	item_x (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Item x position on Current.
		do
			Result := tool_bar.item_x (a_item)
		end

	item_y (a_item: SD_TOOL_BAR_ITEM): INTEGER is
			-- Item y position on Current.
		do
			Result := tool_bar.item_y (a_item)
		end

	update is
			-- Redraw item(s) which `is_need_redraw'
		do
			tool_bar.update
			on_expose (0, 0, width, height)
		end

	set_start_x (a_x: INTEGER) is
			-- Set `start_x'
		do
			tool_bar.set_start_x (a_x)
		end

	set_start_y (a_y: INTEGER) is
			-- Set `start_y'
		do
			tool_bar.set_start_y (a_y)
		end

	start_x: INTEGER is
			-- Set `internal_start_x' of `tool_bar'.
		do
			Result := tool_bar.start_x
		end

	start_y: INTEGER is
			-- Set `internal_start_y' of `tool_bar'.
		do
			Result := tool_bar.start_y
		end

	item_at_position (a_screen_x, a_screen_y: INTEGER_32): SD_TOOL_BAR_ITEM is
			-- Redefine
		do
			Result := tool_bar.item_at_position (a_screen_x, a_screen_y)
		end

feature {NONE} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM) is
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

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Redefine
		do
		end

	on_expose (a_x, a_y, a_width, a_height: INTEGER_32) is
			-- Redefine.
		local
			l_items: like internal_items
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

	on_tool_bar_expose_actions (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
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

feature -- Contract support

	line_width: INTEGER is
			-- Redefine `line_width' from {EV_DRAWABLE} to make sure invariant not broken.
			-- See bug#13387.
		do
		end

	drawing_mode: INTEGER is
			-- Redefine `drawing_mode' from {EV_DRAWABLE} to make sure invariant not broken.
			-- See bug#13387.
		do
		end

invariant
	not_void: tool_bar /= Void

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
