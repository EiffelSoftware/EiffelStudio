indexing
	description	: "About Dialog, displaying general information about current system"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ABOUT_DIALOG

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
		undefine
			default_create, copy
		end
		
	INSTALLATION_LOCATOR
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
			copyright_label: EV_LABEL
			info_label: EV_LABEL
			version_label: EV_LABEL
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
			file_name: FILE_NAME
			file: RAW_FILE
		do
			default_create
			set_title ("EiffelVision2 Demo")
			disable_user_resize

				-- Create controls.
			create eiffel_image
			if installation_location /= Void then
				create file_name.make_from_string (installation_location)
				file_name.extend ("bitmaps")
				file_name.extend ("png")
				file_name.extend ("bm_about.png")
				create file.make (file_name)
				if file.exists then
					eiffel_image.set_with_named_file (file_name.out)
					eiffel_image.set_minimum_size (eiffel_image.width, eiffel_image.height)
					eiffel_image.set_background_color (White)				
				end
			end
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
			texts_box.extend (white_cell)

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
		end

feature -- Constant strings

	t_version_info: STRING is
		once
			Result := "EiffelVision2 Demo"
		end
		

	t_Copyright_info: STRING is
		once
			Result := 
				"Copyright (C) 1985-2004 Eiffel Software Inc.%N%
				%All rights reserved"
		end

	t_info: STRING is
		once
			create Result.make (500)
			Result.append (
				"Eiffel Software Inc.%N%
				%ISE Building%N%
				%356 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone: 805-685-1006, Fax 805-685-6869%N%
				%Electronic mail: <info@eiffel.com>%N%
				% %N%
				%Web Customer Support: http://support.eiffel.com%N%
				%Visit Eiffel on the Web: http://www.eiffel.com%N"
			)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class ABOUT_DIALOG
