indexing
	description: "Constants for `bench'."
	date: "$Date$"
	revision: "$Revision$"

class EB_CONSTANTS

inherit
	TTY_CONSTANTS
	
feature {NONE} -- Resources

	Graphical_resources: GRAPHICAL_CATEGORY is
			-- General resources
		once
			create Result.make
		end

	Project_resources: PROJECT_CATEGORY is
			-- Resources for the project tool
		once
			create Result.make
		end

	System_resources: SYSTEM_CATEGORY is
			-- Resources for the system tool
		once
			create Result.make
		end

	Object_resources: OBJECT_CATEGORY is
			-- Resources for the feature tool
		once
			create Result.make
		end

	Explain_resources: EXPLAIN_CATEGORY is
			-- Resources for the feature tool
		once
			create Result.make
		end

	Profiler_resources: PROFILE_CATEGORY is
			-- Resources for the profiler tool
		once
			create Result.make
		end

	Dynamic_lib_resources: DYNAMIC_LIB_CATEGORY is
			-- Resources for the Dynamic_lib_tool tool
		once
			create Result.make
		end

	Warning_messages: WARNING_MESSAGES is
			-- All warning used in the interface
		once
			create Result
		end

	Interface_names: INTERFACE_NAMES is
			-- All names used in the interface
		once
			create Result
		end

	Pixmaps: SHARED_PIXMAPS is
			-- All pixmaps used in the interface
		once
			create Result
		end

	Cursors: SHARED_CURSORS is
			-- All pixmaps used in the interface
		once
			create Result
		end

end -- class EB_CONSTANTS
