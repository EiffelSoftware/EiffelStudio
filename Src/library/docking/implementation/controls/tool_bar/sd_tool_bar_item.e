indexing
	description: "Tool bar items for SD_TOOL_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TOOL_BAR_ITEM

feature -- Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion.
		deferred
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer motion for tooltip setting.
		deferred
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer press.
		deferred
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Handle pointer leave.
		deferred
		end

	on_pointer_leave is
			-- Handle pointer leave.
		deferred
		end

	on_pointer_press_forwarding (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Pointer press actions forwarding.
		deferred
		end

feature -- Query

	is_need_redraw: BOOLEAN
			-- Redefine

	width: INTEGER is
			-- Width of Current item.
		deferred
		end

	height: INTEGER is
			-- Height of Current item
		do
			if tool_bar /= Void then
				Result :=  tool_bar.row_height
			end
		end

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- If `a_rect' inlcude Current?
		require
			not_void: a_rect /= Void
		deferred
		end

	state: INTEGER
			-- State to draw for`item'.
			-- One value from SD_TOOL_BAR_ITEM_STATE

	is_sensitive: BOOLEAN
			-- If Current sensitive?

	rectangle: EV_RECTANGLE is
			--  Button rectangle area
		do
			if tool_bar /= Void and then tool_bar.has (Current) then
				create Result.make (tool_bar.item_x (Current), tool_bar.item_y (Current), width, tool_bar.row_height)
			else
				-- Current is hidden when current line is not enough horizontal space.
				create Result.make (0, 0, 0, 0)
			end
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Redefine
		do
			if internal_drop_actions = Void then
				create internal_drop_actions
			end
			Result := internal_drop_actions
		end

	pebble_function: FUNCTION [ANY, TUPLE, ANY]
			-- Returns data to be transported by pick and drop mechanism.

	accept_cursor: EV_POINTER_STYLE
			-- Accept cursor for PND, maybe void.

	deny_cursor: EV_POINTER_STYLE
			-- Deny cursor for PND, maybe void.

feature -- Properties

	tool_bar: SD_TOOL_BAR
			-- Tool bar which Current button belong to.

	set_wrap (a_wrap: BOOLEAN) is
			-- Set `wrap'
		do
			is_wrap := a_wrap
		ensure
			set: is_wrap = a_wrap
		end

	is_wrap: BOOLEAN
			-- If Current is wrap state?
			-- If it's wrap, then Current's next button will go to next line.	

	is_displayed: BOOLEAN
			-- If it is displayed on SD_TOOL_BAR_ZONE.

	description: STRING_32
			-- Description when use SD_TOOL_BAR_CUSTOMIZE_DIALOG to customize SD_TOOL_BAR.

	set_description (a_description: STRING_GENERAL) is
			-- Set `description'
		require
			not_void: a_description /= Void
		do
			description := a_description
		ensure
			set: description.is_equal (a_description.as_string_32)
		end

	enable_displayed is
			-- Enable `is_displayed'.
		do
			is_displayed := True
		end

	disable_displayed is
			-- Disable `is_displayed'
		do
			is_displayed := False
		end

	is_destroyed: BOOLEAN is False
			-- There is no under native widget for Current.
			-- So, it'll never destroyed.

	pixmap: EV_PIXMAP
			-- Pixmap shown on Current.

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		do
			pixmap := a_pixmap
			if tool_bar /= Void then
				tool_bar.need_calculate_size
			end
			refresh
		ensure
			set: pixmap = a_pixmap
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer which is always 32bits.
			-- It will not lose alpha datas.

	set_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Set `pixel_buffer'
		do
			pixel_buffer := a_pixel_buffer
			if tool_bar /= Void then
				tool_bar.need_calculate_size
			end
			refresh
		ensure
			set: pixel_buffer = a_pixel_buffer
		end

	name: STRING_32
			-- Name which is used for store configuration
			-- This name should be fixed in all locales.

	set_name (a_name: STRING_GENERAL) is
			-- Set `name'
		require
			not_void: a_name /= Void
		do
			name := a_name
		ensure
			set: name.is_equal (a_name.as_string_32)
		end

	set_pebble_function (a_pebble: like pebble_function) is
			-- Set `pebble_function' with `a_pebble'
		do
			pebble_function := a_pebble
		ensure
			set: pebble_function = a_pebble
		end

	set_accept_cursor (a_cursor: EV_POINTER_STYLE) is
			-- Set `accept_cursor' with `a_cursor'
		do
			accept_cursor := a_cursor
		ensure
			set: accept_cursor = a_cursor
		end

	set_deny_cursor (a_cursor: EV_POINTER_STYLE) is
			-- Set `deny_cursor' with `a_cursor'
			-- FIXIT: set_deny_cursor not working correctly. I think it's a Vision2 set deny cursor bug during PND. Larry Apr. 27 2007.
		do
			deny_cursor := a_cursor
		ensure
			set: deny_cursor = a_cursor
		end

	set_data (a_data: ANY) is
			-- Set `data'
		do
			data := a_data
		ensure
			set: data = a_data
		end

	data: ANY
			-- User data.

feature {SD_NOTEBOOK_TAB_AREA} -- Implementation

	update is
			-- Redraw Current
		do
			is_need_redraw := True
			if tool_bar /= Void and then not tool_bar.is_destroyed then
				tool_bar.update
			end
		end

feature {SD_TOOL_BAR, SD_TOOL_BAR_ITEM} -- Internal issues

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			--  Update for pick and drop.
		require
			not_void: a_starting implies a_pebble /= Void
		deferred
		end

	disable_redraw is
			-- Set `is_need_redraw' False.
		do
			is_need_redraw := False
		end

	set_tool_bar (a_tool_bar: SD_TOOL_BAR) is
			-- Set `tool_bar'.
		do
			tool_bar := a_tool_bar
		ensure
			set: tool_bar = a_tool_bar
		end

feature {NONE} -- Implementation

	refresh is
			-- Refresh button drawing if possible
			-- This is useful just after `pixel_buffer' or `bitmap' changed
		local
			l_tool_bar: SD_TOOL_BAR
		do
			l_tool_bar := tool_bar
			if l_tool_bar /= Void then
				is_need_redraw := True
				l_tool_bar.update
			end
		end

	internal_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions.

invariant
	not_void: name /= Void

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

