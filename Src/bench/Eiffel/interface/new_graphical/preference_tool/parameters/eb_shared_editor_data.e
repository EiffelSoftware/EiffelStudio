indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHARED_EDITOR_DATA

feature -- Resources

	editor_preferences: EB_EDITOR_DATA is
		once
			create Result
		end

end -- class EB_SHARED_EDITOR_DATA
