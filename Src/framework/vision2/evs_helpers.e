indexing
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
			l_window: EV_WINDOW
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

	widget_top_level_window (a_widget: EV_WIDGET; a_main: BOOLEAN): EV_WINDOW is
			-- Locates parent window of `a_widget', if the widget has been parented.
			--
			-- `a_widget': A widget to locate a top level window for.
			-- `a_main': True to retrieve the top-most window, which attempts to find the application window.
		require
			a_widget_attached: a_widget /= Void
			a_widget_is_parented: a_widget.has_parent or (({EV_WINDOW}) #? a_widget /= Void)
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		local
			l_stop_looking: BOOLEAN
			l_dialog: EV_DIALOG
		do
			Result ?= a_widget
			if a_main and Result /= Void then
				l_stop_looking := (({EV_TITLED_WINDOW}) #? Result /= Void)
			else
				l_stop_looking := Result /= Void
			end
			if not l_stop_looking then
				if a_widget.has_parent then
					Result := widget_top_level_window (a_widget.parent, a_main)
				else
					l_dialog ?= a_widget
					if l_dialog /= Void and then l_dialog.blocking_window /= Void then
						Result := widget_top_level_window (l_dialog.blocking_window, a_main)
					end
				end
			else
				check result_attached: Result /= Void end
			end
		end

	parent_window_of_focused_widget: EV_WINDOW is
			-- Parent window of current focused widget
			-- Result maybe void.
		local
			l_application: EV_APPLICATION
			l_env: EV_ENVIRONMENT
		do
			create l_env
			l_application := l_env.application
			if {l_widget: EV_WIDGET} l_application.focused_widget then
				Result := widget_top_level_window (l_widget, False)
			end
		end

feature -- Screen

	window_working_area (a_window: EV_WINDOW): TUPLE [x, y, width, height: INTEGER] is
			-- Retrieves a working area for window `a_window'
			--
			-- `a_window': Window to retrieve a working area for.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_destroyed: not a_window.is_destroyed
		local
			l_top_window: EV_TITLED_WINDOW
			l_screen: SD_SCREEN
			l_width: INTEGER
			l_height: INTEGER
		do
			l_top_window ?= widget_top_level_window (a_window, True)
			if l_top_window /= Void and l_top_window.is_maximized then
				l_width := l_top_window.client_width + ((l_top_window.width - l_top_window.client_width) / 2).truncated_to_integer
				l_height := l_top_window.client_height + ((l_top_window.height - l_top_window.client_height) / 2).truncated_to_integer
				if l_top_window = a_window then
					Result := [l_top_window.x_position, l_top_window.y_position, l_width, l_height]
				else
					if
						a_window.width + a_window.x_position <= l_width and
						a_window.height + a_window.y_position <= l_height
					then
							-- Window is within main window, so use main window coords
						Result := [l_top_window.x_position, l_top_window.y_position, l_width, l_height]
					end
				end
			end

			if Result = Void then
					-- Use full screen coords
				create l_screen
				Result := [0, 0, l_screen.virtual_width, l_screen.virtual_height]
			end
		ensure
			result_attached: Result /= Void
			not_result_x_negative: Result.x >= 0
			not_result_y_negative: Result.y >= 0
			result_width_big_enough: Result.width > Result.x
			result_height_big_enough: Result.height > Result.y
			result_width_small_enough: Result.width <= (create {EV_SCREEN}).width
			result_height_small_enough: Result.height <= (create {EV_SCREEN}).height
		end

feature -- Widget

	maximum_string_width (a_strings: !ARRAY [?READABLE_STRING_GENERAL]; a_font: ?EV_FONT): INTEGER
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
			l_str: ?READABLE_STRING_GENERAL
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
					if {l_sg: STRING_GENERAL} l_str then
						Result := Result.max (a_font.string_width (l_sg))
					else
						Result := Result.max (a_font.string_width (l_str.as_string_32))
					end
				end
				i := i + 1
			end
		end

	maximum_string_size (a_strings: !ARRAY [?READABLE_STRING_GENERAL]; a_font: ?EV_FONT): TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
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
			l_str: ?READABLE_STRING_GENERAL
			l_size: TUPLE [width: INTEGER; height: INTEGER; left_offset: INTEGER; right_offset: INTEGER]
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
					if {l_sg: STRING_GENERAL} l_str then
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

	suggest_pop_up_widget_location_with_size (a_widget: EV_WIDGET; a_screen_x, a_screen_y, a_width, a_height: INTEGER): TUPLE [x, y: INTEGER] is
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
			l_current_area: like window_working_area
			l_top_area: like window_working_area
			l_new_x: INTEGER
			l_new_y: INTEGER
		do
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
				if a_screen_x + a_width > l_area.x + l_area.width then
						-- Out of space, given width
					l_new_x := 	(l_area.x + l_area.width) - a_width
					if l_new_x < 0 then
							-- Off screen, so use original
						l_new_x := a_screen_x
					end
				else
					l_new_x := a_screen_x
				end

					-- Adjust Y position
				if a_screen_y + a_height > l_area.y + l_area.height then
						-- Out of space, given height
					l_new_y := 	(l_area.y + l_area.height) - a_height
					if l_new_y < 0 then
							-- Off screen, so use original
						l_new_y := a_screen_y
					end
				else
					l_new_y := a_screen_y
				end
			else
				l_new_x := a_screen_x
				l_new_y := a_screen_y
			end

			l_new_x := l_new_x.max (0)
			l_new_y := l_new_y.max (0)
			Result := [l_new_x, l_new_y]
		ensure
			result_attached: Result /= Void
			result_x_non_negative: Result.x >= 0
			result_y_non_negative: Result.y >= 0
			result_x_on_screen: Result.x <= (create {EV_SCREEN}).width
			result_y_on_screen: Result.y <= (create {EV_SCREEN}).height
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
