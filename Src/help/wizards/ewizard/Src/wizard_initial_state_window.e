indexing
	description	: "Initial State"
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

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
		do
			title.set_text ("Welcome to the New Wizard%NApplication Wizard")
			message.set_text (
				"Using this wizard you can create a Wizard application%N%
				%%N%
				%You will have to choose how many state should be in%N%
				%your wizard.%N%
				%Then all the usefull classes will be generated, and you will%N%
				%just have to fill the WIZARD_xxxx_STATE classes.%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Store Wizard
	
end -- class WIZARD_INITIAL_STATE
