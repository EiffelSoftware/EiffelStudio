note
	description: "About License for current EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LICENSE_DIALOG

inherit
	EB_DIALOG

	SYSTEM_CONSTANTS
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_imp
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature -- Initialization

	make (a_license_path: PATH)
		local
			eiffel_image: EV_PIXMAP
			eiffel_image_box: EV_VERTICAL_BOX
			eiffel_text_box: EV_VERTICAL_BOX
			texts_box: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			button_box: EV_HORIZONTAL_BOX
			hbox: EV_HORIZONTAL_BOX
			license_text: EV_TEXT
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
		do
			default_create
			license_path := a_license_path
			set_title (Interface_names.t_License)

				-- Create controls.
			eiffel_image := Pixmaps.bm_About.twin
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			eiffel_image.set_background_color (Default_background_color)
			create eiffel_image_box
			eiffel_image_box.extend (eiffel_image)
			eiffel_image_box.disable_item_expand (eiffel_image)
			create white_cell
			white_cell.set_background_color (Default_background_color)
			eiffel_image_box.extend (white_cell)

			create license_text.make_with_text (license_info)
			license_text.set_background_color (Default_background_color)
			license_text.set_foreground_color (default_foreground_color)

			license_text.disable_edit
			license_text.set_minimum_width (450)
			license_text.set_minimum_height (200)
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent destroy)
			Layout_constants.set_default_width_for_button (ok_button)

				-- Box with text.
			create eiffel_text_box
			eiffel_text_box.set_background_color (Default_background_color)
			eiffel_text_box.set_foreground_color (default_foreground_color)
			eiffel_text_box.set_padding (Layout_constants.Default_padding_size)
			eiffel_text_box.extend (license_text)

				-- Texts box			
			create texts_box
			texts_box.set_background_color (Default_background_color)
			texts_box.set_foreground_color (default_foreground_color)
			texts_box.extend (eiffel_text_box)

				-- Box with left image + text
			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
			hbox.set_border_width (Layout_constants.Default_border_size)
			hbox.set_background_color (Default_background_color)
			hbox.extend (eiffel_image_box)
			hbox.disable_item_expand (eiffel_image_box)
			hbox.extend (texts_box)

				-- Box where the Ok button is
			create button_box
			button_box.set_border_width (Layout_constants.Default_border_size)
			button_box.extend (create {EV_CELL})
			button_box.extend (ok_button)
			button_box.disable_item_expand (ok_button)

				-- Box with everything in it.
			create vbox
			vbox.extend (hbox) -- Expandable item
			create hsep
			vbox.extend (hsep)
			vbox.disable_item_expand (hsep)
			vbox.extend (button_box)
			vbox.disable_item_expand (button_box)

			extend (vbox)
			set_default_push_button (ok_button)
			set_default_cancel_button (ok_button)
		end

feature -- Access

	license_path: PATH
			-- Path to license file.

	license_info: STRING_32
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_path (license_path)
			if f.exists then
				create Result.make (f.count)
				f.open_read
				from
				until
					f.end_of_file or f.exhausted
				loop
					f.read_line
					Result.append_string (f.last_string)
					Result.append_character ('%N')
				end
				f.close
			else
				create Result.make_from_string ({STRING_32} "Missing LICENSE file!%N")
				Result.append_string_general ("location: ")
				Result.append (license_path.name)
				Result.append_character ('%N')
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class EB_LICENSE_DIALOG
