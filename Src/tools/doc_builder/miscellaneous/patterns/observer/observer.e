indexing
	description: "Observer (Observer pattern (Design Patterns, 293, Gamma et.al)))"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OBSERVER		

feature -- Implementation

	update is
			-- Update
		require
			should_update: should_update
		deferred
		end		

feature -- Access

	should_update: BOOLEAN
			-- Should Current be updated in update notification?

end -- class OBSERVER
