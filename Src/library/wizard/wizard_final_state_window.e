indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		redefine
			proceed_with_current_info,is_final_state
		end

feature -- Basic Operations

	display is
		do
			build
		end

	build is
			-- Special display box for the first and the last state
		local
			text: EV_LABEL
			h1: EV_HORIZONTAL_BOX
			v1, v2: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
			cont: EV_CONTAINER
		do
			first_window.set_final_state ("Finish")

			Create h1
			create message
			create title
			title.set_background_color (white_color)
			title.align_text_center
			message.set_background_color (white_color)
			message.align_text_left
			Create sep_v
			cont := pixmap.parent
			if cont /= Void then
				cont.prune (pixmap)
			end
			pixmap.set_minimum_height (312)
			pixmap.set_minimum_width (165)

			h1.extend (pixmap)
			h1.extend (sep_v)

			Create choice_box
			choice_box.set_minimum_width (330)
			choice_box.extend (title)
			choice_box.disable_item_expand (title)
			choice_box.extend (message)
			h1.extend (choice_box)

			h1.disable_item_expand (sep_v)
			h1.disable_item_expand (choice_box)

			display_state_text
			main_box.extend (h1)			
		end

	proceed_with_current_info is
			-- destroy the window.
			-- Descendants have to redefine this routine
			-- if they want to add generation, warnings, ...
		local
			warning: EV_WARNING_DIALOG
		do
			precursor
--			Create warning.make_with_text (final_message)
--			warning.show_modal
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

	pixmap_location: STRING is "eiffel_wizard_new.bmp"

	ebench_launcher: EBENCH_LAUNCHER
		-- Class to launch ebench after the generation

feature {NONE}-- Access

	is_final_state: BOOLEAN is TRUE

	choice_box: EV_VERTICAL_BOX

	

	final_message: STRING is 
		deferred
		end

end -- class WIZARD_FINAL_STATE_WINDOW
