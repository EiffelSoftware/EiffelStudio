indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

creation
	make

feature -- Basic Operations

	proceed_with_current_info is
		do
		end

feature -- Access

	display_state_text is
		do
			title.set_text ("Final Step")
			message.set_text ("Last step")
		end

	final_message: STRING is
		do
		end

end -- class FINAL_STATE
