indexing
	description: "Constants for editor."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EDITOR_DATA	

feature -- Resources

	panel_manager: TEXT_PANEL_MANAGER is
			-- List of open panels
		once
			create Result
		end		

	editor_preferences: EDITOR_DATA is
			-- Editor preferences
		require
			initialized: initialized
		do
			Result := editor_preferences_cell.item
		end

feature -- Query

	initialized: BOOLEAN is
			-- 
		do
			Result := initialized_cell.item = True	
		end		
		
feature {NONE} -- Implementation		

	editor_preferences_cell: CELL [EDITOR_DATA] is
			-- 
		once
			create Result
		end
	
	initialized_cell: CELL [BOOLEAN] is
			-- 
		once
			create Result	
		end
		
	preference_codes: SHARED_PREFERENCE_CODES is
	        -- Document preference codes
	    once
	        create Result
	    end		
		
end -- class SHARED_EDITOR_DATA
