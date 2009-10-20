note
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

	make
			-- Creation method
		local
			l_shared: SD_SHARED
		do
			create l_shared
			state := {SD_TOOL_BAR_ITEM_STATE}.normal
			is_sensitive_internal := True
			is_displayed := True
			description := l_shared.interface_names.separator
			name := generating_type
			pixmap := l_shared.icons.tool_bar_separator_icon
		end

feature -- Redefine agents

	on_pointer_motion (a_relative_x, a_relative_y: INTEGER)
			-- <Precursor>
		do
		end

	on_pointer_leave
			-- <Precursor>
		do
		end

	on_pointer_press (a_relative_x, a_relative_y: INTEGER)
			-- <Precursor>
		do
		end

	on_pointer_release (a_relative_x, a_relative_y: INTEGER)
			-- <Precursor>
		do
		end

	on_pointer_motion_for_tooltip (a_relative_x, a_relative_y: INTEGER)
			-- <Precursor>
		do
			if rectangle.has_x_y (a_relative_x, a_relative_y) then
				tool_bar.remove_tooltip
			end
		end

	on_pointer_press_forwarding (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- <Precursor>
		do
		end

feature -- Redefine querys

	width: INTEGER = 6
			-- <Precursor>

	has_rectangle (a_rect: EV_RECTANGLE): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	rectangle: EV_RECTANGLE
			-- <Precursor>
		do
			if tool_bar /= Void and then is_wrap then
				create Result.make (0, tool_bar.item_y (Current), tool_bar.minimum_width, width)
			else
				Result := Precursor {SD_TOOL_BAR_ITEM}
			end
		end

feature {SD_TOOL_BAR} -- Pick and drop issues.

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY)
			-- Update for pick and drop
		do
			-- Separator do nothing.
		end
note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end
