indexing
	description: "Initial State"
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE
inherit
	WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

creation
	make

feature -- basic Operations

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_FIRST_STATE}.make(wizard_information))
		end

	display_state_text is
		do
			title.set_text ("<FL_WIZARD_NAME>")
			message.set_text ("Welcome.%NMy text")
		end
	
end -- class WIZARD_INITIAL_STATE
