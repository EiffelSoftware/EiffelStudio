indexing
	description:
		"Class used for the initialization of all resources %
		%used in EiffelBench"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RESOURCES_INITIALIZER

inherit
	NEW_EB_CONSTANTS
	EB_PROFILE_TOOL_DATA
	SHARED_EIFFEL_PROJECT
--	TTY_RESOURCES
--		redefine
--			initialize_resources
--		end

creation 
	initialize

feature {NONE} -- Initialization

	initialize_resources (a_table: RESOURCE_TABLE) is
			-- Initialize all resources for bench
		do
--			Precursor (a_table)
			if not Eiffel_project.batch_mode then
				Graphical_resources.initialize (a_table)
				Project_resources.initialize (a_table)
				System_resources.initialize (a_table)
				Object_resources.initialize (a_table)
				Explain_resources.initialize (a_table)
				Profile_resources.initialize (a_table)
				Dynamic_lib_resources.initialize (a_table)
			end
		end

end -- class EB_RESOURCES_INITIALIZER
