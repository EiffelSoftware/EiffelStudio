indexing
	description	: "Template for the first state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_INITIAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		redefine
			display_pixmap
		end

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

			display_state_text
			create message_and_title_box
			message_and_title_box.set_background_color (white_color)			
			message_and_title_box.set_border_width (Default_border_size)
			message_and_title_box.set_padding (Default_padding_size)
			message_and_title_box.extend (title)
			message_and_title_box.disable_item_expand (title)
			message_and_title_box.extend (message)
			message_and_title_box.extend (choice_box)

			local_pixmap := pixmap.ev_clone
			local_pixmap.set_minimum_height (dialog_unit_to_pixels(312))
			local_pixmap.set_minimum_width (165)
			local_pixmap.draw_pixmap (91, 9, pixmap_icon)

			create vertical_separator

			create interior_box
			interior_box.extend (local_pixmap)
			interior_box.disable_item_expand (local_pixmap)
			interior_box.extend (vertical_separator)
			interior_box.disable_item_expand (vertical_separator)
			interior_box.extend (message_and_title_box) -- Expandable item
			main_box.extend (interior_box)			
		end

	pixmap_location: STRING is "eiffel_wizard.bmp"

	pixmap_icon_location: STRING is
			-- Path in which can be found the pixmap icon associated with
			-- the current state.
		deferred
		ensure
			exists: Result /= Void
		end

	display_pixmap is
			-- Draw pixmap
		local
			fi: FILE_NAME
		do
			Precursor {WIZARD_STATE_WINDOW}

			create fi.make_from_string (wizard_pixmaps_path)
			fi.extend (pixmap_icon_location)
			pixmap_icon.set_with_named_file (fi)
		end

	choice_box: EV_VERTICAL_BOX

end -- class WIZARD_INITIAL_STATE_WINDOW
