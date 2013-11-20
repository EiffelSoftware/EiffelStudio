note
	description: "Template for the first state of a wizard"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INITIAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		redefine
			display_pixmap
		end

feature -- Basic Operations

	display
			-- Display Current State
		do
			build
		end

	build
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
--			title.set_minimum_height (dialog_unit_to_pixels(40))

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
			fill_message_and_title_box (message_and_title_box)

			local_pixmap := pixmap.twin
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

			create tuple
			choice_box.set_help_context (agent create_help_context (tuple))
		end

	current_help_context: detachable WIZARD_HELP_CONTEXT
			-- Help context for this window
		do
			if
				attached choice_box.help_context as hc and then
				attached {like current_help_context} hc.item (hc.operands) as l_help_context
			then
				Result := l_help_context
			end
		end

feature {NONE} -- Widgets

	choice_box: EV_VERTICAL_BOX

feature {NONE} -- Implementation

	fill_message_and_title_box (message_and_title_box: EV_VERTICAL_BOX)
			-- Fill `message_and_title_box' with needed widgets.
		local
			white_cell: EV_CELL
		do
			create white_cell
			white_cell.set_background_color (white_color)

			message_and_title_box.extend (message)
			message_and_title_box.disable_item_expand (message)
			message_and_title_box.extend (choice_box)
			message_and_title_box.disable_item_expand (choice_box)
			message_and_title_box.extend (white_cell)
		end

	display_pixmap
			-- Draw pixmap
		local
			p: detachable PATH
			retried: BOOLEAN
			info_dialog: EV_INFORMATION_DIALOG
			info_message: STRING_32
		do
			if not retried then
				Precursor {WIZARD_STATE_WINDOW}
				p := wizard_pixmaps_path.extended_path (pixmap_icon_location)
				pixmap_icon.set_with_named_path (p)
			end
		rescue
			retried := True
			create info_message.make (30)
			info_message.append ("Unable to open the pixmap named%N%"")
			if attached p then
				info_message.append (p.name)
			else
				info_message.append ("UNKNOWN FILE")
			end
			info_message.append ("%"")
			create info_dialog.make_with_text (info_message)
			info_dialog.show_modal_to_window (first_window)
			retry
		end

feature {NONE} -- Constants

	pixmap_location: PATH
			-- Pixmap location.
		once
			create Result.make_from_string ("eiffel_wizard" + pixmap_extension)
		end

	pixmap_icon_location: PATH
			-- Path in which can be found the pixmap icon associated with
			-- the current state.
		deferred
		ensure
			exists: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
