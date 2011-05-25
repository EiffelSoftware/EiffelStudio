note
	description: "[
		EiffelVision2 helper functions
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVS_HELPERS

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Basic operations

	perform_window_locking_action (a_action: PROCEDURE [ANY, TUPLE]; a_container: EV_CONTAINER)
			-- Performs an operation locking the user interface.
			-- Note: If the UI is already locked by another window then locking will be skipped.
			--
			-- `a_action': An action to be performed whilst locking any window update.
			-- `a_container': A container to attempt to locate a parent window for (the parent window will be locked)
			--                The container can be Void but no locking will occur if it is.
		require
			a_action_attached: a_action /= Void
			not_a_container_is_destroyed: a_container /= Void implies not a_container.is_destroyed
			a_container_has_parent: a_container /= Void implies a_container.has_parent
		local
			l_window: detachable EV_WINDOW
			l_locked: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				if a_container /= Void then
					l_window := widget_top_level_window (a_container, False)
					if l_window /= Void and then not l_window.is_destroyed and then ev_application.locked_window = Void then
							-- Lock window updates
						l_window.lock_update
						l_locked := True
					end
				end

				a_action.call ([])
			end

			if l_locked then
					-- Unlock window
				check l_window_attached: l_window /= Void end
				l_window.unlock_update
			end
		ensure
			ev_application_locked_window_unchanged: ev_application.locked_window = old ev_application.locked_window
		rescue
			retried := True
			retry
		end

feature -- Query

	widget_top_level_window (a_widget: EV_WIDGET; a_main: BOOLEAN): detachable EV_WINDOW
			-- Locates parent window of `a_widget', if the widget has been parented.
			--
			-- `a_widget': A widget to locate a top level window for.
			-- `a_main': True to retrieve the top-most window, which attempts to find the application window.
		require
			a_widget_attached: a_widget /= Void
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_stop_looking: BOOLEAN
		do
			Result ?= a_widget
			if a_main and Result /= Void then
				l_stop_looking := attached {EV_TITLED_WINDOW} Result
			else
				l_stop_looking := Result /= Void
			end
			if not l_stop_looking then
				if a_widget.has_parent and then attached a_widget.parent as p then
					Result := widget_top_level_window (p, a_main)
				else
					if
						attached {EV_DIALOG} a_widget as l_dialog and then
						attached l_dialog.blocking_window as w
					then
						Result := widget_top_level_window (w, a_main)
					end
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
				Result := widget_top_level_window (l_widget, False)
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
			l_screen: SD_SCREEN
			l_width: INTEGER
			l_height: INTEGER
		do
			if
				attached {EV_TITLED_WINDOW} widget_top_level_window (a_window, True) as l_top_window and then
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

	maximum_string_width (a_strings: attached ARRAY [detachable READABLE_STRING_GENERAL]; a_font: detachable EV_FONT): INTEGER
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
			l_str: detachable READABLE_STRING_GENERAL
			l_upper, i: INTEGER
		do
			from
				i := a_strings.lower
				l_upper := a_strings.upper
			until
				i > l_upper
			loop
				l_str := a_strings [i]
				if l_str /= Void then
					if attached {STRING_GENERAL} l_str as l_sg then
						Result := Result.max (a_font.string_width (l_sg))
					else
						Result := Result.max (a_font.string_width (l_str.as_string_32))
					end
				end
				i := i + 1
			end
		end

	maximum_string_size (a_strings: attached ARRAY [detachable READABLE_STRING_GENERAL]; a_font: detachable EV_FONT): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
			-- Maximum width of a collection of strings
			--
			-- `a_strings': An array of string to determine the maximum width for.
			-- `a_font': The font to use to determine the space requirements.
			-- `Result': The size in pixels the largest string will require. See {EV_FONT}.string_size for more information.
		require
			not_a_string_is_empty: not a_strings.is_empty
			a_strings_contains_attached_items: not a_strings.has (Void)
			a_font_attached: a_font /= Void
		local
			l_str: detachable READABLE_STRING_GENERAL
			l_size: like maximum_string_size
			l_upper, i: INTEGER
		do
			from
				create Result
				i := a_strings.lower
				l_upper := a_strings.upper
			until
				i > l_upper
			loop
				l_str := a_strings [i]
				if l_str /= Void then
					if attached {STRING_GENERAL} l_str as l_sg then
						l_size := a_font.string_size (l_sg)
					else
						l_size := a_font.string_size (l_str.as_string_32)
					end
					Result.width := Result.width.max (l_size.width)
					Result.height := Result.height.max (l_size.height)
					Result.right_offset := Result.right_offset.max (l_size.right_offset)
					Result.left_offset := Result.left_offset.min (l_size.left_offset)
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
			a_widget_has_parent: a_widget.has_parent or (({EV_WINDOW}) #? a_widget /= Void)
			a_width_positive: a_width > 0
			a_height_positive: a_height > 0
		local
			l_current_window: like widget_top_level_window
			l_top_window: like widget_top_level_window
			l_area: like window_working_area
			l_current_area,
			l_top_area: detachable like window_working_area
			l_new_x: INTEGER
			l_new_y: INTEGER
			l_screen: SD_SCREEN
		do
			create l_screen
			l_top_window := widget_top_level_window (a_widget, True)
			l_current_window := widget_top_level_window (a_widget, False)
			if l_current_window /= Void and l_top_window /= Void then
				l_current_area := window_working_area (l_current_window)
				l_top_area := window_working_area (l_top_window)
			end

			if l_current_area /= Void and l_top_area /= Void then
				l_area := l_top_area
				if l_current_area.x > l_top_area.x then
						-- Current window area is on the right of the top window
					if a_screen_x > l_top_area.x + l_top_area.width or a_screen_y > l_top_area.y + l_top_area.height then
						l_area := l_current_area
					end
				else
						-- Current window area is on the left of the top window
					if a_screen_x < l_top_area.x or a_screen_y < l_top_area.y then
						l_area := l_current_area
					end
				end

					-- Adjust X position
				if (a_screen_x + a_width) > (l_area.x + l_area.width) then
						-- Out of space, given width
					l_new_x := 	(l_area.x + l_area.width) - a_width
				else
					l_new_x := a_screen_x
				end

					-- Adjust Y position
				if (a_screen_y + a_height) > (l_area.y + l_area.height) then
						-- Out of space, given height
					l_new_y := 	(l_area.y + l_area.height) - a_height
				else
					l_new_y := a_screen_y
				end
			else
				l_new_x := a_screen_x
				l_new_y := a_screen_y
			end

			l_new_x := l_new_x.max (l_screen.virtual_x)
			l_new_y := l_new_y.max (l_screen.virtual_y)
			Result := [l_new_x, l_new_y]
		ensure
			result_attached: Result /= Void
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
