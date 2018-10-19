note
	description: "	EiffelVision2 helper functions"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date: па$"
	revision: "$Revision$"

class
	EVS_HELPERS

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Query

	widget_top_level_window (a_widget: EV_WIDGET): detachable EV_WINDOW
			-- Locates parent window of `a_widget', if the widget has been parented.
			--
			-- `a_widget': A widget to locate a top level window for.
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_parent: detachable EV_WIDGET
		do
				-- Perform a loop rather than recursion that is much slower.
			from
				l_parent := a_widget
			until
				l_parent = Void or else Result /= Void
			loop
				if attached {EV_WINDOW} l_parent as l_window then
					Result := l_window
				else
						-- Go one level up
					l_parent := l_parent.parent
				end
			end
		end

	parent_window_of_focused_widget: detachable EV_WINDOW
			-- Parent window of current focused widget
			-- Result maybe void.
		do
			if
				attached (create {EV_ENVIRONMENT}).application as l_application and then
				attached l_application.focused_widget as l_widget
			then
				Result := widget_top_level_window (l_widget)
			end
		end

	widget_has_recursive_focus (a_widget: EV_WIDGET): BOOLEAN
			-- Is `a_widget' (or its childs) focused?
		require
			attached_widget: a_widget /= Void
		do
			if
				not a_widget.is_destroyed and then
				a_widget.is_displayed
			then
				if a_widget.has_focus then
					Result := True
				elseif attached {EV_CONTAINER} a_widget as cont then
					if
						attached (create {EV_ENVIRONMENT}).application as env_app and then
						attached env_app.focused_widget as fw
					then
						Result := cont.has_recursive (fw)
					end
				end
			end
		end

feature -- Screen

	window_working_area (a_window: EV_WINDOW): TUPLE [x, y, width, height: INTEGER]
			-- Retrieves a working area for window `a_window'
			--
			-- `a_window': Window to retrieve a working area for.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_destroyed: not a_window.is_destroyed
		local
			l_area: detachable like window_working_area
			l_screen: EV_SCREEN
			l_width: INTEGER
			l_height: INTEGER
		do
			if
				attached {EV_TITLED_WINDOW} widget_top_level_window (a_window) as l_top_window and then
				l_top_window.is_maximized
			then
				l_width := l_top_window.client_width + ((l_top_window.width - l_top_window.client_width) / 2).truncated_to_integer
				l_height := l_top_window.client_height + ((l_top_window.height - l_top_window.client_height) / 2).truncated_to_integer
				if l_top_window = a_window then
					l_area := [l_top_window.x_position, l_top_window.y_position, l_width, l_height]
				else
					if
						a_window.width + a_window.x_position <= l_width and
						a_window.height + a_window.y_position <= l_height
					then
							-- Window is within main window, so use main window coords
						l_area := [l_top_window.x_position, l_top_window.y_position, l_width, l_height]
					end
				end
			end

			if l_area = Void then
					-- Use full screen coords
				create l_screen
				Result := [l_screen.virtual_x, l_screen.virtual_y, l_screen.virtual_width, l_screen.virtual_height]
			else
				Result := l_area
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Widget

	maximum_string_width (a_strings: ARRAY [detachable READABLE_STRING_GENERAL]; a_font: EV_FONT): INTEGER
			-- Maximum width of a collection of strings
			--
			-- `a_strings': An array of string to determine the maximum width for.
			-- `a_font': The font to use to determine the space requirements.
			-- `Result': The width in pixels the largest string will require.
		require
			not_a_string_is_empty: not a_strings.is_empty
			a_strings_contains_attached_items: not a_strings.has (Void)
			a_font_attached: a_font /= Void
		local
			l_upper, i: INTEGER
		do
			from
				i := a_strings.lower
				l_upper := a_strings.upper
			until
				i > l_upper
			loop
				if attached a_strings [i] as l_str then
					Result := Result.max (a_font.string_width
						(if attached {STRING_GENERAL} l_str as l_sg then l_sg else l_str.as_string_32 end))
				end
				i := i + 1
			end
		end

feature -- Placement

	suggest_pop_up_widget_location_with_size (a_widget: EV_WIDGET; a_screen_x, a_screen_y, a_width, a_height: INTEGER): TUPLE [x, y: INTEGER]
			-- Suggests a location for a widget based on it's size
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		local
			l_top_window: like widget_top_level_window
			l_top_area: detachable like window_working_area
			l_new_x: INTEGER
			l_new_y: INTEGER
			l_screen: EV_RECTANGLE
		do
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (a_screen_x, a_screen_y)

			l_top_window := widget_top_level_window (a_widget)
			if l_top_window /= Void then
				l_top_area := window_working_area (l_top_window)
			end

			if l_top_area /= Void then
					-- Adjust X position
				if (a_screen_x + a_width) > (l_top_area.x + l_top_area.width) then
						-- Out of space, given width
					l_new_x := 	(l_top_area.x + l_top_area.width) - a_width
				else
					l_new_x := a_screen_x
				end

					-- Adjust Y position
				if (a_screen_y + a_height) > (l_top_area.y + l_top_area.height) then
						-- Out of space, given height
					l_new_y := 	(l_top_area.y + l_top_area.height) - a_height
				else
					l_new_y := a_screen_y
				end
			else
				l_new_x := a_screen_x
				l_new_y := a_screen_y
			end

			l_new_x := l_new_x.max (l_screen.x)
			l_new_y := l_new_y.max (l_screen.y)

			Result := [l_new_x, l_new_y]
		ensure
			result_attached: Result /= Void
		end

	suggest_pop_up_location_by_rectangle_side (a_rect: EV_RECTANGLE; a_width, a_height: INTEGER): TUPLE [x, y: INTEGER]
			-- Suggests a location for a widget based on it's size
			-- Position priority: right, left, bellow, above.
			-- If no space arround the `a_rect', overlapping is allowed on the right bottom.
		require
			a_rect_attached: a_rect /= Void
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		local
			l_new_x: INTEGER
			l_new_y: INTEGER
			l_screen: EV_RECTANGLE
		do
				-- Current monitor
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (
				a_rect.x, a_rect.y)

			if (a_rect.x + a_rect.width + a_width) > l_screen.width + l_screen.x then
					-- Out of space on the right, given width
					-- Move to the left.
				l_new_x := a_rect.x - a_width
				if l_new_x < l_screen.x then
						-- Out of the screen on left side, move it back to right side and x coordinate overlap is allowed.
					l_new_x := l_screen.x + l_screen.width - a_width
				end
			else
					-- Place on the right.
				l_new_x := a_rect.x + a_rect.width
			end

			if l_new_x > a_rect.x - a_width and then l_new_x < a_rect.x + a_rect.width then
					-- Overlapped x, try the space bellow and above.
				if l_screen.y + l_screen.height - a_rect.y - a_rect.height >= a_height then
						-- Enough space bellow.
					l_new_y := a_rect.y + a_rect.height
				elseif a_rect.y - l_screen.y >= a_height then
						-- Enough space above
					l_new_y := a_rect.y - a_height
				else
						-- Allow overlap on bottom.
					l_new_y := l_screen.y + l_screen.height - a_height
				end
			else
					-- x is not overlapped, simply adjust y.
				if a_rect.y + a_height > l_screen.y + l_screen.height then
						-- Out of space, given height.
					l_new_y := l_screen.y + l_screen.height - a_height
				else
						-- Align to the top line of the area.
					l_new_y := a_rect.y
				end
			end

			Result := [l_new_x, l_new_y]
		ensure
			result_attached: Result /= Void
		end

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
