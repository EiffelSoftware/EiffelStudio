indexing
	description	: "About Dialog, displaying general information about $EiffelGraphicalCompiler$"
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

	SHARED_BENCH_LICENSES
		export
			{NONE} all
		undefine
			default_create, copy
		end

creation
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
			disable_user_resize

				-- Create controls.
			eiffel_image := clone (Pixmaps.bm_About)
			eiffel_image.set_minimum_size (eiffel_image.width, Layout_constants.dialog_unit_to_pixels(200))
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

				borland_image := clone (Pixmaps.bm_Borland)
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
		end

feature {NONE} -- Implementation

	registration_info: STRING is
			-- Clause in the about dialog concerning the license.
		local
			un: STRING
		do
			create Result.make (50)
			un := license.username
			if un /= Void and then not un.is_empty then
				Result := l_Registered + un + "%R%N%R%N"
			else
				Result := l_Unregistered_version
			end
			
		end

feature {NONE} -- Constant strings

	t_Version_info: STRING is
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
		once
			Result := 
				"Copyright (C) 1985-2000 Interactive Software Engineering Inc.%N%
				%All rights reserved"
		end

	t_info: STRING is
		once
			create Result.make (500)
			Result.append (
				"Interactive Software Engineering Inc.%N%
				%ISE Building%N%
				%360 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone: 805-685-1006, Fax 805-685-6869%N%
				%Electronic mail: <info@eiffel.com>%N%
				% %N%
				%Web Customer Support: http://support.eiffel.com%N%
				%Visit Eiffel on the Web: http://eiffel.com%N"
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

	l_Unregistered_version: STRING is "Unregistered version.%NPlease contact ISE on http://eiffel.com/forms/secure.html."
			-- User has not registered his version.

	l_Registered: STRING is "Version registered to "
			-- Introductory text for the name of the user.

end -- class EB_ABOUT_DIALOG
