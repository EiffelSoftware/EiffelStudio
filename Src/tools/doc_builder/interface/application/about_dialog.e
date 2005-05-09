indexing
	description: "Dialog for about information."
	date: "$Date$"
	revision: "$Revision$"

class
	ABOUT_DIALOG

inherit
	ABOUT_DIALOG_IMP

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			ok_button.select_actions.extend (agent destroy)
		end

feature {NONE} -- Implementation

	
end -- class ABOUT_DIALOG

