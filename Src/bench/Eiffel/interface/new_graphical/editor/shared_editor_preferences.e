indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EDITOR_PREFERENCES

feature -- Access

	editor_preferences: EDITOR_PREFERENCES is
		once
			create Result
		end

end -- class SHARED_EDITOR_PREFERENCES
