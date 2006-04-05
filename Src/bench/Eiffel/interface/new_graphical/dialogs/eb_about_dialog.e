indexing
	description	: "About Dialog, displaying general information about $EiffelGraphicalCompiler$"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_ABOUT_DIALOG

inherit
	EV_DIALOG

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

	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature -- Initialization

	make is
		local
			eiffel_image: EV_PIXMAP
			eiffel_text_box: EV_VERTICAL_BOX
			texts_box: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			button_box: EV_HORIZONTAL_BOX
			hbox: EV_HORIZONTAL_BOX
			version_label: EV_LABEL
			copyright_label: EV_LABEL
			registration_label: EV_LABEL
			info_label: EV_LABEL
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
			borland_label: EV_LABEL
			borland_box: EV_HORIZONTAL_BOX
			borland_image: EV_PIXMAP
		do
			default_create
			set_icon_pixmap (Pixmaps.Icon_dialog_window)
			set_title (Interface_names.t_About)

				-- Create controls.
			eiffel_image := Pixmaps.bm_About.twin
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			eiffel_image.set_background_color (White)
			create info_label.make_with_text (t_info)
			info_label.align_text_left
			info_label.set_background_color (White)
			create version_label.make_with_text (t_Version_info)
			version_label.align_text_left
			version_label.set_background_color (White)
			create copyright_label.make_with_text (t_Copyright_info)
			copyright_label.align_text_left
			copyright_label.set_background_color (White)
			create registration_label.make_with_text (registration_info)
			registration_label.align_text_left
			registration_label.set_background_color (White)
			create ok_button.make_with_text_and_action (Interface_names.b_Ok, agent destroy)
			Layout_constants.set_default_size_for_button (ok_button)

				-- Box with text.
			create eiffel_text_box
			eiffel_text_box.set_background_color (White)
			eiffel_text_box.set_padding (Layout_constants.Default_padding_size)
			eiffel_text_box.set_background_color (White)
			eiffel_text_box.extend (version_label)
			eiffel_text_box.extend (copyright_label)
			eiffel_text_box.extend (info_label)
			eiffel_text_box.extend (registration_label)

				-- Box with image + text + Borland logo
			if has_borland then
				create borland_label.make_with_text (t_Borland)
				borland_label.align_text_left
				borland_label.set_background_color (White)

				borland_image := Pixmaps.bm_Borland.twin
				borland_image.set_minimum_size (borland_image.width, borland_image.height)
				borland_image.set_background_color (White)

				create borland_box
				borland_box.set_background_color (White)
				borland_box.extend (borland_label)
				borland_box.extend (borland_image)
				borland_box.disable_item_expand (borland_image)
			end

				-- Texts box			
			create texts_box
			texts_box.set_background_color (White)
			texts_box.extend (eiffel_text_box)
			texts_box.disable_item_expand (eiffel_text_box)
			create white_cell
			white_cell.set_background_color (White)
			texts_box.extend (white_cell) -- expandable item
			if has_borland then
				texts_box.extend (borland_box)
				texts_box.disable_item_expand (borland_box)
			end

				-- Box with left image + text
			create hbox
			hbox.set_padding (Layout_constants.Default_padding_size)
			hbox.set_border_width (Layout_constants.Default_border_size)
			hbox.set_background_color (White)
			hbox.extend (eiffel_image)
			hbox.disable_item_expand (eiffel_image)
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

			disable_user_resize
		end

feature {NONE} -- Implementation

	registration_info: STRING is
			-- Clause in the about dialog concerning the license.
		do
			create Result.make (50)
			Result.append ("%NInstallation information:%N")
			Result.append ("$ISE_EIFFEL = " + eiffel_installation_dir_name + "%N")
			Result.append ("$ISE_PLATFORM = " + eiffel_platform)
			if platform_constants.is_windows then
				Result.append ("%N$ISE_C_COMPILER = " + eiffel_c_compiler)
			end
		end

feature {NONE} -- Constant strings

	t_version_info: STRING is
		once
			create Result.make (100)
			Result.append (Interface_names.t_Project)
			Result.append (" ")
			Result.append_integer (Major_version_number)
			Result.append (" (")
			Result.append (Version_number)
			Result.append (")")
		end

	t_Copyright_info: STRING is
		local
			c_date: C_DATE
		once
			create c_date
			Result :=
				"Copyright (C) 1985-" + c_date.year_now.out + " Interactive Software Engineering Inc.%N%
				%All rights reserved"
		end

	t_info: STRING is
		once
			create Result.make (500)
			Result.append (
				"Eiffel Software%N%
				%356 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone: 805-685-1006%N%
				%Fax: 805-685-6869%N%
				%Electronic mail: <info@eiffel.com>%N%
				% %N%
				%Web Customer Support: http://support.eiffel.com%N%
				%Visit Eiffel on the Web: http://www.eiffel.com%N"
			)
		end

	t_borland: STRING is
			-- Text for Borland.
		once
			create Result.make (256)
			Result.append (
				"Includes Free Borland command-line%N%
				%C++ compiler.%N%
				%Visit http://www.borland.com/bcppbuilder")

		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_ABOUT_DIALOG
