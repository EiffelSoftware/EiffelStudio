indexing
	description: "Initial State"
	author: "pascalf"
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
			proceed_with_new_state(Create {WIZARD_NUMBER_STATE}.make(wizard_information))
		end

	display_state_text is
		do
			title.set_text ("EiffelWIizard wizard")
			message.set_text ("Welcome.%NThis wizard will help you to build your first Eiffel wizard.")
		end
	
end -- class WIZARD_INITIAL_STATE
