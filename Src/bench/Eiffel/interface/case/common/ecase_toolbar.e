indexing
	description: "Toolbar for all Ecase window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	ECASE_TOOLBAR

inherit
	CONSTANTS

creation
	make

feature -- Initialization

	make (Parent: ECASE_WINDOW ) is
			-- Initialize
		require
			parent_exists: parent /= Void
		do
		end

feature {NONE} -- Implementation

	tool_bar: EV_TOOL_BAR
		-- Toolbar in which we put the colored buttons

end -- class ECASE_TOOLBAR
