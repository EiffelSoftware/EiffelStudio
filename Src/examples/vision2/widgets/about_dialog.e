indexing
	description	: "About Dialog, displaying general information."
	date		: "$Date$"
	revision	: "$Revision$"

class
	ABOUT_DIALOG

inherit
	EV_DIALOG

	EV_STOCK_COLORS
		export
			{NONE} all
		undefine
			default_create, copy
		end
		
	EV_LAYOUT_CONSTANTS
		undefine
			default_create, copy
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create current.
		local
			eiffel_image: EV_PIXMAP
			eiffel_text_box: EV_VERTICAL_BOX
			texts_box: EV_VERTICAL_BOX
			vbox: EV_VERTICAL_BOX
			button_box: EV_HORIZONTAL_BOX
			hbox: EV_HORIZONTAL_BOX
			copyright_label: EV_LABEL
			info_label: EV_LABEL
			hsep: EV_HORIZONTAL_SEPARATOR
			ok_button: EV_BUTTON
			white_cell: EV_CELL
		do
			default_create
			set_title ("Vision2 widget demo")
			disable_user_resize

				-- Create controls.
			create eiffel_image
			eiffel_image.set_with_named_file ("../../bm_About.png")
			eiffel_image.set_minimum_size (eiffel_image.width, dialog_unit_to_pixels(200))
			eiffel_image.set_background_color (White)
			create info_label.make_with_text (t_info)
			info_label.align_text_left
			info_label.set_background_color (White)
			
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

	t_Copyright_info: STRING is
		once
			Result := 
				"Copyright (C) 1985-2000 Interactive Software Engineering Inc.%N%
				%All right reserved"
		end

	t_info: STRING is
		once
			create Result.make (500)
			Result.append (
				"Interactive Software Engineering Inc.%N%
				%ISE Building, 2nd floor%N%
				%270 Storke Road, Goleta, CA 93117 USA%N%
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

end -- class ABOUT_DIALOG

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

