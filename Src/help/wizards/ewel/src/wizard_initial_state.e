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
			title.set_text ("WEL Wizard")
			message.set_text ("%N%TWelcome.%N%NThis wizard will help you to start a WEL application.%
								%%N%NYou will have to provide a few information, and an Eiffel%
								%%Nproject will be generated at the end of this wizard.")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Wel Wizard
	
end -- class WIZARD_INITIAL_STATE
