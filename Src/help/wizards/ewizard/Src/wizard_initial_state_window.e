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
			title.set_text ("EIFFELWIZARD CONSTRUCTOR")
			message.set_text ("%TWelcome.%N%NThis wizard will help you to build an Eiffel wizard.%N%
								%%NYou will have to choose how many state should be in your wizard.%
								%%NThen all the usefull classes will be generated, and you will%
								%%Njust have to fill the WIZARD_xxxx_STATE classes.%N%
								%%NThe generated project is compilable as the ace will also be%
								%%Ngenerated. You must however have the Wizard library.")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard
	
end -- class WIZARD_INITIAL_STATE
