note
	description: "Splash displayer."
	author: "Daniel Furrer <daniel.furrer@gmail.com"
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_SPLASH_DISPLAYER

inherit
	SPLASH_DISPLAYER_I

	EV_ANY_IMP

	EIFFEL_LAYOUT

	NS_ENVIRONEMENT

create
	make_with_text

feature -- Splash displayer

	make
		do

		end

	show
			-- Show splash screen
		local
			icon, splash_image: NS_IMAGE
			image_view: NS_IMAGE_VIEW
			window_rect: NS_RECT
		do
			create icon.make_with_referencing_file (icon_file_name)
			app_implementation.set_application_icon_image (icon)

			create splash_image.make_with_referencing_file (splash_image_file_name)

			create window_rect.make_rect (0, 0, splash_image.size.width, splash_image.size.height)
			window_rect.origin.x := main_screen.frame.size.width // 2 - splash_image.size.width // 2
			window_rect.origin.y := main_screen.frame.size.height // 2 - splash_image.size.height // 2
			create window.make (window_rect, {NS_WINDOW}.borderless_window_mask, True)
			window.set_level ({NS_WINDOW}.modal_panel_window_level)
			--window.center
			window.set_opaque (False)
			window.set_background_color (create {NS_COLOR}.clear_color)
			create image_view.make
			image_view.set_image (splash_image)
			window.set_content_view (image_view)
			window.set_alpha_value ({REAL_32}0.0)
			window.make_key_and_order_front (window)
			window.animator.set_alpha_value ({REAL_32}1.0)
		end

	close
		local
			timer: NS_TIMER
		do
			window.animator.set_alpha_value ({REAL_32}0.0)
			create timer.scheduled_timer (1.0, agent window.order_out, Void, False)
		end

feature {NONE} -- Implementation

	splash_image_file_name: FILE_NAME
			-- Image file name.
		do
			create Result.make_from_string (eiffel_layout.bitmaps_path)
			Result.extend ("png")
			Result.set_file_name ("splash_shadow.png")
		end

	icon_file_name: FILE_NAME
			-- Icon file name.
		do
			create Result.make_from_string (eiffel_layout.bitmaps_path)
			Result.extend ("png")
			Result.set_file_name ("estudio.png")
		end

	window: NS_WINDOW;

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
