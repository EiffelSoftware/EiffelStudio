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

	cursors: EDITOR_CURSORS
			-- Editor cursors
		
	icons: EDITOR_ICONS
			-- Editor icons
		
	syntax_files_path: DIRECTORY_NAME
			-- Path containing syntax definition files for highlighting
			
feature -- Status Setting

	set_cursors (a_cursors: like cursors) is
			-- Sets `cursors' with `a_cursors'
		require
			a_cursors_not_void: a_cursors /= Void
		do
			cursors := a_cursors
		ensure	
			cursors_set: cursors = a_cursors
		end

	set_icons (a_icons: like icons) is
			-- Sets `icons' with `a_icons'
		require
			a_icons_not_void: a_icons /= Void
		do
			icons := a_icons
		ensure	
			icons_set: icons = a_icons
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
