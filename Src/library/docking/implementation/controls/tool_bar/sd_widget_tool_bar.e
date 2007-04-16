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
			is_equal
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
			is_row_height_set,
			is_row_height_valid,
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
			on_pointer_release
		end

	EV_FIXED
		rename
			extend as extend_fixed,
			wipe_out as wipe_out_fixed,
			has as has_fixed,
			prune as prune_fixed,
			force as force_fixed
		export
			{NONE} all
			{ANY} is_destroyed
		undefine
			enable_capture,
			disable_capture,
			has_capture,
			pointer_motion_actions,
			pointer_button_release_actions,
			pointer_button_press_actions,
			pointer_double_press_actions,
			is_displayed,
			initialize
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

			default_create

			extend_fixed (tool_bar)

			tool_bar.expose_actions.extend (agent on_tool_bar_expose_actions)
		ensure
			set: tool_bar = a_tool_bar
		end

feature -- Properties

	row_height: INTEGER is
			--  Height of row.
		do
			Result := tool_bar.row_height
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
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			tool_bar.prune (a_item)
			l_widget_item ?= a_item
			if l_widget_item /= Void then
				prune_fixed (l_widget_item.widget)
			end
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

	update_size is
			-- Update `tool_bar' size if Current width changed.
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
			l_parent: EV_CONTAINER
			l_floating_zone: SD_FLOATING_TOOL_BAR_ZONE
		do
			compute_minimum_size
			l_tool_bar_row ?= parent
			if l_tool_bar_row /= Void then
				l_tool_bar_row.set_item_size (Current, minimum_width, minimum_height)
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

	is_row_height_set (a_new_height: INTEGER): BOOLEAN is
			-- If `a_new_height' equal `row_height'?
		do
			Result := tool_bar.row_height = a_new_height
		end

	is_row_height_valid (a_height: INTEGER): BOOLEAN is
			-- If `a_height' equal `row_height'?
		do
			Result := tool_bar.row_height = a_height
		end

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

feature {NONE} -- Implementation

	redraw_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Redraw `a_item'
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			l_item ?= a_item
			if l_item = Void then
				tool_bar.redraw_item (a_item)
			end
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
						if l_item_x /= l_item.widget.x_position or else l_item_y /= l_item.widget.y_position then
							set_item_position (l_item.widget, l_item_x, l_item_y)
						end
				end
				l_items.forth
			end
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
