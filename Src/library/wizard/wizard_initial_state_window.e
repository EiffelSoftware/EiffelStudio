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
			tuple: TUPLE
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
			message_and_title_box.disable_item_expand (choice_box)

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

			create tuple.make
			choice_box.set_help_context (~create_help_context (tuple))
		end

	pixmap_location: FILE_NAME is
			-- Pixmap location
		once
			create Result.make_from_string ("eiffel_wizard")
			Result.add_extension (pixmap_extension)
		end

	pixmap_icon_location: FILE_NAME is
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
			retried: BOOLEAN
			info_dialog: EV_INFORMATION_DIALOG
			info_message: STRING
		do
			if not retried then
				Precursor {WIZARD_STATE_WINDOW}

				create fi.make_from_string (wizard_pixmaps_path)
				fi.extend (pixmap_icon_location)
				pixmap_icon.set_with_named_file (fi)
			end
		rescue
			if not retried then
				create info_message.make (30)
				info_message.append ("Unable to open the pixmap named%N%"")
				if fi /= Void then
					info_message.append (fi)
				else
					info_message.append ("UNKNOWN FILE")
				end
				info_message.append ("%"")
				create info_dialog.make_with_text (info_message)
				info_dialog.show_modal_to_window (first_window)
				retried := True
				retry
			end
		end

	current_help_context: WIZARD_HELP_CONTEXT is
			-- Help context for this window
		local
			hc: FUNCTION [ANY, TUPLE, EV_HELP_CONTEXT]
		do
			hc := choice_box.help_context
			Result ?= hc.item (hc.operands)		
		end		

	choice_box: EV_VERTICAL_BOX

end -- class WIZARD_INITIAL_STATE_WINDOW
