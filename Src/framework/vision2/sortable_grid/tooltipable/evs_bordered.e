indexing
	description: "Object that represents a bordered general tooltip"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_BORDERED

inherit
	EVS_SETTING_CHANGE_ACTIONS

feature -- Setting

	set_left_border (a_left_border: INTEGER) is
			-- Assign `a_left_border' to `left_border'.
		require
			a_left_border_non_negative: a_left_border >= 0
		do
			lock_update
			left_border := a_left_border
			unlock_update
			try_call_setting_change_actions
		ensure
			left_border_set: left_border = a_left_border
		end

	set_right_border (a_right_border: INTEGER) is
			-- Assign `a_right_border' to `right_border'.
		require
			a_right_border_non_negative: a_right_border >= 0
		do
			lock_update
			right_border := a_right_border
			unlock_update
			try_call_setting_change_actions
		ensure
			right_border_set: right_border = a_right_border
		end

	set_top_border (a_top_border: INTEGER) is
			-- Assign `a_top_border' to `top_border'.
		require
			a_top_border_non_negative: a_top_border >= 0
		do
			lock_update
			top_border := a_top_border
			unlock_update
			try_call_setting_change_actions
		ensure
			top_border_set: top_border = a_top_border
		end

	set_bottom_border (a_bottom_border: INTEGER) is
			-- Assign `a_bottom_border' to `bottom_border'.
		require
			a_bottom_border_non_negative: a_bottom_border >= 0
		do
			lock_update
			bottom_border := a_bottom_border
			unlock_update
			try_call_setting_change_actions
		ensure
			bottom_border_set: bottom_border = a_bottom_border
		end

	set_border_line_width (a_width: INTEGER) is
			-- Set `border_line_width' with `a_width'.
		require
			a_width_non_negative: a_width >= 0
		do
			lock_update
			border_line_width := a_width
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_border_line_width_set: border_line_width = a_width
		end

	set_border_line_color (a_color: EV_COLOR) is
			-- Set `border_line_color' with `a_color'.
		require
			a_color_attached: a_color /= Void
		do
			lock_update
			border_line_color := a_color
			unlock_update
			try_call_setting_change_actions
		ensure
			tooltip_border_line_color_set: border_line_color = a_color
		end

feature -- Access

	border_line_color: EV_COLOR
			-- Border line color of tooltip window

	border_line_width: INTEGER
			-- Width of border line in pixel of tooltip window

	left_border: INTEGER
			-- Spacing between the contents of `Current' and the left edge of `Current' in pixels.

	right_border: INTEGER
			-- Spacing between the contents of `Current' and the right edge of `Current' in pixels.

	top_border: INTEGER
			-- Spacing between the contents of `Current' and the top edge of `Current' in pixels.

	bottom_border: INTEGER
			-- Spacing between the contents of `Current' and the bottom edge of `Current' in pixels.

	actual_border_line_color: EV_COLOR is
			-- Actual border line color used to draw border line
		do
			if border_line_color = Void then
				Result := border_line_color_internal
			else
				Result := border_line_color
			end
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Implementation

	border_line_color_internal: EV_COLOR is
		local
			l_colors: EV_STOCK_COLORS
		once
			create l_colors
			Result := l_colors.black
		ensure
			result_attached: Result /= Void
		end

invariant
	border_line_color_internal_attached: border_line_color_internal /= Void
	actual_border_line_color_attached: actual_border_line_color /= Void
	left_border_non_negative: left_border >= 0
	right_border_non_negative: right_border >= 0
	top_border_non_negative: top_border >= 0
	bottom_border_non_negative: bottom_border >= 0
	border_line_width_non_negative: border_line_width >= 0

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
