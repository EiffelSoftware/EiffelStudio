indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

creation
	make

feature -- Basic Operations
	build_finish is 
			-- Build user entries.
		local
			h1: EV_HORIZONTAL_BOX
		do
			choice_box.wipe_out
			choice_box.set_border_width (10)
			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			choice_box.extend(create {EV_CELL})
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			choice_box.extend(create {EV_CELL})

			choice_box.set_background_color (white_color)
			progress.set_background_color (white_color)
			progress_text.set_background_color (white_color)

		end


	proceed_with_current_info is
		do
			build_finish

			Precursor
		end

feature -- Access

	display_state_text is
		do
			title.set_text ("Final Step")
			message.set_text ("My text")
		end

	final_message: STRING is
		do
		end

end -- class WIZARD_FINAL_STATE
