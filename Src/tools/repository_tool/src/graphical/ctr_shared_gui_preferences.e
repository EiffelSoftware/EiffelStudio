note
	description: "Summary description for {CTR_SHARED_GUI_PREFERENCES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SHARED_GUI_PREFERENCES

inherit
	CTR_SHARED_PREFERENCES
		redefine
			preferences, internal_preferences
		end

feature -- Access

	preferences: detachable CTR_GUI_PREFERENCES assign set_preferences
		do
			Result := internal_preferences.item
		end

feature {NONE} -- Implementation

	internal_preferences: CELL [detachable CTR_GUI_PREFERENCES]
		once
			create Result.put (Void)
		end

end
