indexing
	description: "Empty panel used during developpement"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VOID_ENTRY_PANEL

inherit
	EB_ENTRY_PANEL
		redefine
			update
		end

creation
	make

feature {NONE} -- Initialization


	update_resources is 
			-- Update `resources'.
		do
		end

	associated_category: EB_PARAMETERS is
		do
			Result := Void
		end

feature --	
	update is
		do
		end

feature -- Access

	name: STRING is "To be implemented later"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Void
		end

end -- class EB_VOID_ENTRY_PANEL
