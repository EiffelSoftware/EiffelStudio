indexing
	description: "Preferences for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES
	
inherit
	EC_PREFERENCES
		rename
			make as initialize_ec_preferences
		export
			{EB_KERNEL}
				initialize_ec_preferences
		end
	
	EB_GUI_PREFERENCES
		rename
			make as initialize_gui_preferences
		export
			{EB_KERNEL}
				initialize_gui_preferences
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create `Current' using `a_preferences'
		do
			preferences := a_preferences
		end
		
feature -- Access

	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.

end -- class EB_PREFERENCES
