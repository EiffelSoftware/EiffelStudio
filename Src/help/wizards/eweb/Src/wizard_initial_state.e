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
			proceed_with_new_state(Create {GENERATION_SELECTION_STATE}.make(wizard_information))
		end

feature -- Implementation

	pixmap_location: STRING is "small_essai.bmp"

	message: STRING is "Welcome.%NThis wizard will help you to build your first Eiffel Web %N Application."

	title: STRING is "Eiffel Web wizard"

end -- class WIZARD_INITIAL_STATE
