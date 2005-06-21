indexing
	description: "Preferences for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES
	
inherit
	EC_PREFERENCES
		rename
			make as make_batch
		end
	
	EB_GUI_PREFERENCES
		rename
			make as make_gui
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES; gui_mode: BOOLEAN) is
			-- Create `Current' using `a_preferences'
		do
			make_batch (a_preferences)
			if gui_mode then
				make_gui (a_preferences)
			end						
			preferences := a_preferences
		end
		
feature -- Access

	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.

end -- class EB_PREFERENCES
