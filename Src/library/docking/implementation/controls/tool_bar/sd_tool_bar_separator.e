indexing
	description: "Tool bar separator for SD_TOOL_BAR_SEPARATOR."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_SEPARATOR

inherit
	SD_TOOL_BAR_ITEM
		redefine
			rectangle
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		local
			l_shared: SD_SHARED
		do
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			is_sensitive := True
			is_displayed := True
			description := generating_type
			name := generating_type
			create l_shared
			pixmap := l_shared.icons.default_icon
		end

feature -- Redefine Agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

	on_pointer_leave is
			-- Redefine
		do
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER) is
			-- Redefine
		do
			if rectangle.has_x_y (a_relative_x, a_relative_y) then
				tool_bar.remove_tooltip
			end
		end

	on_pointer_press_forwarding (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Redefine
		do
		end

feature -- Redefine querys

	width: INTEGER is 6
			-- Redefine

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN is
			-- Redefine
		do
			Result := True
		end

	rectangle: EV_RECTANGLE is
			-- Redefine
		do
			if is_wrap then
				create Result.make (0, tool_bar.item_y (Current), tool_bar.minimum_width, width)
			else
				Result := Precursor {SD_TOOL_BAR_ITEM}
			end
		end

feature {SD_TOOL_BAR} -- Pick and drop issues.

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Update for pick and drop
		do
			-- Separator do nothing.
		end
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
