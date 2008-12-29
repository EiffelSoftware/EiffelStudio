note
	description: "[
		Factory class for creating cursors from icons
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EVS_CURSOR_FACTORY

feature -- Factory

	pointer_style_from_icon (a_icon: EV_PIXEL_BUFFER): EV_POINTER_STYLE
			-- Creates a cursor from an icon
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_icon_big_enough: a_icon.width <= 16 and a_icon.height <= 16
		local
			l_buffer: EV_PIXEL_BUFFER
		do
			create l_buffer.make_with_size (32, 32)
			l_buffer.draw_pixel_buffer_with_x_y (8, 8, a_icon)
			create Result.make_with_pixel_buffer (l_buffer, 16, 16)
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

	pointer_style_from_icon_and_overlay (a_icon: EV_PIXEL_BUFFER; a_overlay: EV_PIXEL_BUFFER): EV_POINTER_STYLE
			-- Creates a cursor from an icon
		require
			a_icon_attached: a_icon /= Void
			not_a_icon_is_destroyed: not a_icon.is_destroyed
			a_icon_big_enough: a_icon.width <= 16 and a_icon.height <= 16
			a_overlay_big_enough: a_overlay.width = 10 and a_overlay.height = 10
		local
			l_buffer: EV_PIXEL_BUFFER
		do
			create l_buffer.make_with_size (32, 32)
			l_buffer.draw_pixel_buffer_with_x_y (8, 8, a_icon)
			l_buffer.draw_pixel_buffer_with_x_y (17, 17, a_overlay)
			create Result.make_with_pixel_buffer (l_buffer, 16, 16)
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

;note
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
