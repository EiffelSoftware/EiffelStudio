indexing
	description: "Simple dialog for displaying task process status."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROGRESS_DIALOG

inherit
	PROGRESS_DIALOG_IMP
		export
			{ANY} progress_bar 
		end

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
		end

end -- class PROGRESS_DIALOG

