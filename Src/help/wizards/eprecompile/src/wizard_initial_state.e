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
			title.set_text ("Precompile Tool")
			message.set_text ("Welcome.%NThis tool will allow you to precompile any Eiffel libraries.%
								%%NYou will be able to choose among the libraries you have bought%
								% but also you can precompile your own library by providing the Ace file.%
								%%NIf you need to re-precompile a library, then the previous version will%	
								% be overwritten")
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard

end -- class WIZARD_INITIAL_STATE
