indexing
	description: "Initial State"
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE

inherit
	BENCH_WIZARD_INITIAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

creation
	make

feature -- basic Operations

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_PROJECT_NAME_AND_LOCATION_STATE}.make(wizard_information))
		end

	display_state_text is
			-- Dispay the text for the current state.
		do
			title.set_text ("Welcome to the New WEL%NApplication Wizard")
			message.set_text (
				"Using this wizard you can create a Windows application%N%
				%based on the WEL library.%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Wel Wizard
	
end -- class WIZARD_INITIAL_STATE
