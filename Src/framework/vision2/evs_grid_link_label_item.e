note
	description: "Specialized {EV_GRID_LABEL_ITEM} which displays the current text as a clickable link."
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_LINK_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			make_with_text,
			create_interface_objects
		end

create
	make_empty,
	make_with_text

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			pointer_style := (create {EV_STOCK_PIXMAPS}).hyperlink_cursor
		end

	make
			-- Initialize `Current'.
		do
			set_foreground_color ((create {EV_STOCK_COLORS}).blue)
			pointer_enter_actions.extend (
				agent
					do
						pointer_motion_actions.extend (agent on_pointer_motion)
					end)
			pointer_leave_actions.extend (
				agent
					do
						pointer_motion_actions.prune_all (agent on_pointer_motion)
						if is_hovering then
							reset_pointer
						end
					end)
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_button_release_actions.extend (agent on_pointer_release)
		end

	make_empty
		do
			default_create
			make
		end

	make_with_text (a_text: STRING_GENERAL)
			-- <Precursor>
		do
			Precursor (a_text)
			make
		end

feature -- Access

	pointer_style: EV_POINTER_STYLE
			-- Pointer used when hovering over link

feature {NONE} -- Access

	last_pointer_style: detachable EV_POINTER_STYLE
			-- Pointer last used for `parent'

feature {NONE} -- Status report

	is_hovering: BOOLEAN
			-- Is the pointer currently hovering over the text?
		do
			Result := last_pointer_style /= Void
		ensure
			definition: Result = attached last_pointer_style
		end

	is_first_button_active: BOOLEAN
			-- Was the first button pressed while `is_hovering' was true?

feature {NONE} -- Implementation

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Called when pointer is being moved around on `Current'.
		local
			l_pixmap: like pixmap
			l_left, l_right: INTEGER
		do
			l_left := left_border
			l_pixmap := pixmap
			if l_pixmap /= Void then
				l_left := l_left + spacing + l_pixmap.width
			end
			l_right := l_left + text_width
			if l_left <= a_x and then a_x <= l_right then
				if not is_hovering then
					set_pointer
				end
			else
				if is_hovering then
					reset_pointer
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Called when a button is pressed on `Current'.
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				is_first_button_active := is_hovering
			end
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Called when a button is released on `Current'.
		do
			if
				a_button = {EV_POINTER_CONSTANTS}.left and then
				is_first_button_active
			then
				if is_hovering then
					select_actions.call (Void)
				end
				is_first_button_active := False
			end
		end

	set_pointer
			-- Set current pointer to `pointer_style'
		require
			not_destroyed: not is_destroyed
			parented: has_parent
			not_hovering: not is_hovering
		do
			if attached parent as p then
				last_pointer_style := p.pointer_style
				p.set_pointer_style (pointer_style)
			else
				check has_parent: False end
			end
		ensure
			hovering: is_hovering
			has_parent: attached parent as en_parent
			same_parent: en_parent = old parent
			last_pointer_set: last_pointer_style = old parent_pointer_style
			current_pointer_set: en_parent.pointer_style = pointer_style
		end

	reset_pointer
			-- Reset current pointer to `last_pointer_style'
		require
			not_destroyed: not is_destroyed
			parented: has_parent
			hovering: is_hovering
		do
			if attached last_pointer_style as l_pointer then
				if attached parent as p then
					p.set_pointer_style (l_pointer)
				else
					check has_parent: False end
				end
				last_pointer_style := Void
			end
		ensure
			current_pointer_reset: attached parent as en_parent and then en_parent.pointer_style = old last_pointer_style
			not_hovering: is_hovering
		end

feature {NONE} -- Assertion helpers

	parent_pointer_style: detachable like pointer_style
		do
			if attached parent as p then
				Result := p.pointer_style
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
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
