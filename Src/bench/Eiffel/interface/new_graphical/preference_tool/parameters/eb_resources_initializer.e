indexing
	description:
		"Class used for the initialization of all resources %
		%used in $EiffelGraphicalCompiler$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_RESOURCES_INITIALIZER

inherit
--	EB_GRAPHICAL_DATA
--	EB_TOOL_DATA
--	EB_PROJECT_TOOL_DATA
--	EB_DEBUG_TOOL_DATA
--	EB_SYSTEM_TOOL_DATA
--	EB_OBJECT_TOOL_DATA
--	EB_EXPLAIN_TOOL_DATA
--	EB_PROFILE_TOOL_DATA
--	EB_DYNAMIC_TOOL_DATA
	SHARED_EIFFEL_PROJECT
	TTY_RESOURCES
		redefine
			initialize_resources
		end

creation 
	initialize

feature {NONE} -- Initialization

	initialize_resources (a_table: RESOURCE_TABLE) is
			-- Initialize all resources for bench
		do
			Precursor (a_table)
			if not Eiffel_project.batch_mode then
--				Graphical_resources.initialize (a_table)
--				Tool_resources.initialize (a_table)
--				Project_resources.initialize (a_table)
--				Debug_resources.initialize (a_table)
--				System_resources.initialize (a_table)
--				Object_resources.initialize (a_table)
--				Explain_resources.initialize (a_table)
--				Profile_resources.initialize (a_table)
--				Dynamic_lib_resources.initialize (a_table)
			end
		end

end -- class EB_RESOURCES_INITIALIZER
