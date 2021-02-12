note
	description	: "All shared attributes specific to the development window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_DEVELOPMENT_WINDOW_DATA

feature -- Value

	width, height: INTEGER
			-- Width and height for the development window.

	dpi: NATURAL
			-- Dpi for the development window. 		

	x_position, y_position: INTEGER
			-- X and Y position for development window.

	maximized_x_position, maximized_y_position: INTEGER
			-- X and Y position for development window when mazimized.

	is_maximized: BOOLEAN
			-- Is the development window maximized?

	is_minimized: BOOLEAN
			-- Is the development window minimized?

feature -- Element change

	save_size (a_width, a_height: INTEGER)
			-- Save width and height of window.
		do
			width := a_width
			height := a_height
		ensure
			width_set: width = a_width
			height_set: height = a_height
		end

	save_size_and_dpi (a_dpi: like dpi; a_width, a_height: INTEGER)
			-- Save width and height of window and dpi.
		do
			width := a_width
			height := a_height
			dpi := a_dpi
		ensure
			width_set: width = a_width
			height_set: height = a_height
		end

	save_position (a_x, a_y: INTEGER)
			-- Save position of window.
		do
			x_position := a_x
			y_position := a_y
		ensure
			x_position_set: x_position = a_x
			y_position_set: y_position = a_y
		end

	save_maximized_position (a_x, a_y: INTEGER)
			-- Save position of window when maximized.
		do
			maximized_x_position := a_x
			maximized_y_position := a_y
		ensure
			maximized_x_position_set: maximized_x_position = a_x
			maximized_y_position_set: maximized_y_position = a_y
		end

	save_window_state (a_minimized, a_maximized: BOOLEAN)
			-- Save the window state of the window.
		require
			states_valid: (a_minimized or a_maximized) implies a_maximized /= a_minimized
		do
			is_maximized := a_maximized
			is_minimized := a_minimized
		ensure
			states_set: is_maximized = a_maximized and is_minimized = a_minimized
		end

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

end -- class EB_DEVELOPMENT_WINDOW_DATA
