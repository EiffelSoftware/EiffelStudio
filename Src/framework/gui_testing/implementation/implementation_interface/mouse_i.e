note
	description:
		"Interface for a mouse implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MOUSE_I

inherit
	ANY
	
	BUTTONS
		export
			{NONE} all
			{ANY} is_valid_button
		end

feature -- Pressing

	press_button (a_mouse_button: INTEGER)
			-- Press `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		deferred
		end

	release_button (a_mouse_button: INTEGER)
			-- Release `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		deferred
		end

feature -- Moving

	move_to_absolute_position (an_x, a_y: INTEGER)
			-- Move mouse to absolute coordinates `an_x' `a_y'.
		deferred
		end

feature -- Scrolling

	scroll_up
			-- Scroll mouse wheel up.
		deferred
		end

	scroll_down
			-- Scroll mouse wheel down.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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

end
