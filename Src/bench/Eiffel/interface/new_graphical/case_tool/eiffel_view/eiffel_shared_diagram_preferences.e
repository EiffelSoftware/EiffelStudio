indexing
	description: "Objects that singleton for diagram preferences."
	author: "Benno Baumgartner"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SHARED_DIAGRAM_PREFERENCES
	
feature {NONE} -- Access

	diagram_preferences: EIFFEL_DIAGRAM_PREFERENCES is
		once
			create Result
		end

end -- class EIFFEL_SHARED_DIAGRAM_PREFERENCES
