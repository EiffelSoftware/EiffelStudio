indexing
	description: "Window manager for explanation windows."
	date: "$Date$"
	revision: "$Revision$"

class EXPLAIN_WIN_MGR 

inherit
	EDITOR_MGR
		redefine
			editor_type, make
		end

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
		 	-- Initialize Current.
		do
			{EDITOR_MGR} precursor (a_screen)
			Explain_resources.add_user (Current)
		end

feature {NONE} -- Properties

	editor_type: EXPLAIN_W
	
	create_editor: EXPLAIN_W is
			-- Create an object tool
		do
			!! Result.make (screen)
		end

end -- class EXPLAIN_WIN_MGR
