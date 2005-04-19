indexing
	description: "Preferences for EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCES
	
inherit
	EC_PREFERENCES
		redefine
			make
		end
	
	EB_GUI_PREFERENCES
		redefine
			make
		end
	
create
	make

feature {NONE} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create `Current' using `a_preferences'
		do
			Precursor {EC_PREFERENCES} (a_preferences)
			Precursor {EB_GUI_PREFERENCES} (a_preferences)
			preferences := a_preferences
		end
		
feature -- Access

	preferences: PREFERENCES
			-- Actual preferences.  Use only to get a preference which you do not know the type
			-- of at runtime through `get_resource'.

end -- class EB_PREFERENCES
