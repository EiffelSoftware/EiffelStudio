indexing
	description: "Toolbar associated to an editor window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_WINDOW_TOOLBAR

inherit
	ECASE_TOOLBAR
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (Parent: EC_EDITOR_WINDOW [ ANY ]) is
			-- Initialize
		require else 
			container_exists: parent.global_container /= Void
		do
			precursor ( Parent )
			fill_with_buttons
		end

	fill_with_buttons is
			-- Fill the toolbar with the buttons
		do				
		end

end -- class EDITOR_WINDOW_TOOLBAR
