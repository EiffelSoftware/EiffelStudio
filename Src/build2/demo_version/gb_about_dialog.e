indexing
	description	: "About Dialog, displaying general information about $EiffelGraphicalCompiler$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	GB_ABOUT_DIALOG

inherit
	EV_DIALOG

	EV_STOCK_COLORS
		rename
			implementation as old_implementation
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EV_LAYOUT_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	GB_ABOUT_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		redefine
			t_version_info
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
			copyright_label: EV_LABEL
			info_label: EV_LABEL
			version_label: EV_LABEL
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
		do
			default_create
			set_title (Product_name)
			disable_user_resize

				-- Create controls.
			eiffel_image := (create {GB_SHARED_PIXMAPS}).Help_about_pixmap.twin
			eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
			eiffel_image.set_background_color (White)
			create info_label.make_with_text (t_info)
			info_label.align_text_left
			info_label.set_background_color (White)
			
			create version_label.make_with_text (t_version_info)
			version_label.align_text_left
			version_label.set_background_color (White)
			
			create copyright_label.make_with_text (t_Copyright_info)
			copyright_label.align_text_left
			copyright_label.set_background_color (White)
			create ok_button.make_with_text_and_action ("OK", agent destroy)
			set_default_size_for_button (ok_button)

				-- Box with text.
			create eiffel_text_box
			eiffel_text_box.set_background_color (White)
			eiffel_text_box.set_padding (Default_padding_size)
			eiffel_text_box.set_background_color (White)
			eiffel_text_box.extend (version_label)
			eiffel_text_box.extend (copyright_label)
			eiffel_text_box.extend (info_label)

				-- Texts box			
			create texts_box
			texts_box.set_background_color (White)
			texts_box.extend (eiffel_text_box)
			texts_box.disable_item_expand (eiffel_text_box)
			create white_cell
			white_cell.set_background_color (White)
			texts_box.extend (white_cell) -- expandable item

				-- Box with left image + text
			create hbox
			hbox.set_padding (Default_padding_size)
			hbox.set_border_width (Default_border_size)
			hbox.set_background_color (White)
			hbox.extend (eiffel_image)
			hbox.disable_item_expand (eiffel_image)
			hbox.extend (texts_box)

				-- Box where the Ok button is
			create button_box
			button_box.set_border_width (Default_border_size)
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
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end
		
feature {NONE} -- Implementation

	t_version_info: STRING is
		once
			Result := Precursor {GB_ABOUT_DIALOG_CONSTANTS} + "%NEvaluation Version:"
		end

end -- class GB_ABOUT_DIALOG
