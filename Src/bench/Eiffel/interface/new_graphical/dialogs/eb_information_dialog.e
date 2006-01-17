--| FIXME: This class has been commented out because it does not work
--| with the current implementation of Vision2 under Windows.
indexing
	description: "Information dialog for ebench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_INFORMATION_DIALOG

inherit
	EV_INFORMATION_DIALOG
--		redefine
--			show_modal_to_window, destroy
--		end

create
	make_with_text,	make_with_text_and_actions

feature -- Basic operations

--	show_modal_to_window (window: EV_WINDOW) is
--			-- Show as blocking until left button is pressed.
--		do
--			key_press_actions.force_extend (~destroy)
--			pointer_button_press_actions.extend (~on_mouse_button_down)
--			set_x_position ((window.x_position + ((window.width - width) // 2)).max(0))
--			set_y_position ((window.y_position + ((window.height - height)// 2)).max(0))
--			show_relative_to_window (window)
--			enable_capture
--			block
--		end			

feature {NONE} -- Events

--	on_mouse_button_down (abs_x_pos, y_pos, buttn: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
--			-- A mouse button has been pressed.
--		do
--			if buttn = 1 then
--				destroy
--			end
--		end

feature {NONE} -- Implementation

--	destroy is
--			-- Remove capture and Destroy `Current'.
--		do
--			if has_capture then
--				disable_capture
--			end
--			if not is_destroyed then
--				Precursor
--			end
--		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EB_INFORMATION_DIALOG
