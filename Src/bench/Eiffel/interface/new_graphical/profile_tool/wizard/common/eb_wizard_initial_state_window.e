indexing
	description	: "Template for the first state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_WIZARD_INITIAL_STATE_WINDOW

inherit
	EB_WIZARD_STATE_WINDOW
		export
			{NONE} all
		end

feature -- Access

	choice_box: EV_VERTICAL_BOX
			-- Container where the choice the user should do are present.

feature -- Basic Operations

	display is
			-- Display Current State
		do
			build
		end

	build is
			-- Special display box for the first and the last state
		local
			vertical_separator: EV_VERTICAL_SEPARATOR
			local_pixmap: EV_PIXMAP
			interior_box: EV_HORIZONTAL_BOX
			message_and_title_box: EV_VERTICAL_BOX
			white_cell: EV_CELL
		do
			create title
			title.set_background_color (white_color)
			title.align_text_left
			title.set_font (welcome_title_font)
			title.set_minimum_height (dialog_unit_to_pixels(40))

			create message
			message.set_background_color (white_color)
			message.align_text_left

			create choice_box
			choice_box.set_background_color (white_color)
			
			create white_cell
			white_cell.set_background_color (white_color)

			display_state_text
			create message_and_title_box
			message_and_title_box.set_background_color (white_color)			
			message_and_title_box.set_border_width (Default_border_size)
			message_and_title_box.set_padding (Default_padding_size)
			message_and_title_box.extend (title)
			message_and_title_box.disable_item_expand (title)
			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)
			message_and_title_box.extend (choice_box)
			message_and_title_box.disable_item_expand (choice_box)
			message_and_title_box.extend (white_cell) -- Expandable item

			local_pixmap := clone (pixmap)
			local_pixmap.set_minimum_size (
				dialog_unit_to_pixels(165),
				dialog_unit_to_pixels(312))
			local_pixmap.draw_pixmap (122, 69, pixmap_icon)

			create vertical_separator

			create interior_box
			interior_box.extend (local_pixmap)
			interior_box.disable_item_expand (local_pixmap)
			interior_box.extend (vertical_separator)
			interior_box.disable_item_expand (vertical_separator)
			interior_box.extend (message_and_title_box) -- Expandable item
			main_box.extend (interior_box)			
		end

end -- class WIZARD_INITIAL_STATE_WINDOW
