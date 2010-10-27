note
	description: "Summary description for {CTR_SHARED_PREFERENCES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CTR_SHARED_PREFERENCES

feature -- Access

	preferences: detachable CTR_PREFERENCES assign set_preferences
		do
			Result := internal_preferences.item
		end

feature {NONE} -- Implementation

	set_preferences (p: like preferences)
		do
			internal_preferences.replace (p)
		end

	internal_preferences: CELL [detachable CTR_PREFERENCES]
		once
			create Result.put (Void)
		end

end
