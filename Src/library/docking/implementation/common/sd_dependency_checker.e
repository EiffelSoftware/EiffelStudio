indexing
	description: "Docking library dependency checker To check if some librarys relied exists."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DEPENDENCY_CHECKER

feature -- Command

	check_dependency (a_parent_window: EV_WINDOW) is
			-- Check native library dependency.
		deferred
		end

end
