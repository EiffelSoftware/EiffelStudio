indexing
	description: "Preferences for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES
	
inherit
	EC_PREFERENCES
		rename
			make as make_ec
		end
	
	EB_GUI_PREFERENCES	
		rename
			make as make_gui
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		do
			make_ec (a_preferences)
			make_gui (a_preferences)
			preferences := a_preferences
		end
		
feature -- Access

	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.

end -- class EB_PREFERENCES
