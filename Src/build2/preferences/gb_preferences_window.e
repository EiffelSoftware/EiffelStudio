indexing
	description: "EiffelStudio preference window."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_PREFERENCES_WINDOW

inherit
	PREFERENCES_GRID_WINDOW
		rename
			preferences as view_preferences
		redefine
			make,
			on_close
		end
		
	EIFFEL_ENV
		export
			{NONE} all	
		undefine
			copy, default_create
		end
		
	GB_SHARED_TOOLS
		undefine
			copy, default_create
		end

create
	make

feature -- Access

	make (a_preferences: like view_preferences; a_parent_window: like parent_window) is
			-- New window.  Redefined to register EiffelStudio specific resource widgets for
			-- special resource types.
		do						
			set_root_icon (icon_preference_root)
			set_folder_icon (icon_preference_folder)
			Precursor {PREFERENCES_GRID_WINDOW} (a_preferences, a_parent_window)
			set_icon_pixmap (icon_preference_root)			
			close_request_actions.extend (agent on_close)			
		end

	on_close is
			-- Window was closed
		do
			main_window.clip_recent_projects
			Precursor
		end		

feature {NONE} -- Implementation

	icon_preference_root: EV_PIXMAP is
			-- Icon for preferences root node
		local
			l_filename: FILE_NAME
		do						
			create l_filename.make_from_string (bitmaps_path.twin)			
			l_filename.extend ("png")
			l_filename.extend ("icon_preferences_root.png")
			create Result
			Result.set_with_named_file (l_filename.string)			
		end
		
	icon_preference_folder: EV_PIXMAP is
			-- Icon for preferences folder node
		local
			l_filename: FILE_NAME
		do					
			create l_filename.make_from_string (bitmaps_path.twin)			
			l_filename.extend ("png")
			l_filename.extend ("icon_preferences_folder.png")
			create Result
			Result.set_with_named_file (l_filename.string)			
		end	

end -- class GB_PREFERENCES_WINDOW
