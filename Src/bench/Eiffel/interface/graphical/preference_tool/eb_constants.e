indexing

	description:
		"Constants for `bench'.";
	date: "$Date$";
	revision: "$Revision$"

class EB_CONSTANTS

feature {NONE} -- Resources

	Graphical_resources: GRAPHICAL_CATEGORY is
			-- General resources
		once
			!! Result.make
		end;

	System_resources: SYSTEM_CATEGORY is
			-- General resources
		once
			!! Result.make
		end;

	Project_tool_resources: PROJECT_CATEGORY is
			-- Resources for the project tool
		once
			!! Result.make
		end;

	System_tool_resources: SYSTEM_W_CATEGORY is
			-- Resources for the system tool
		once
			!! Result.make
		end;

	Class_tool_resources: CLASS_W_CATEGORY is
			-- Resources for the class tool
		once
			!! Result.make
		end;

	Feature_tool_resources: ROUTINE_W_CATEGORY is
			-- Resources for the feature tool
		once
			!! Result.make
		end;

	Object_tool_resources: OBJECT_W_CATEGORY is
			-- Resources for the feature tool
		once
			!! Result.make
		end;

	Explain_tool_resources: EXPLAIN_W_CATEGORY is
			-- Resources for the feature tool
		once
			!! Result.make
		end;

	Interface_names: INTERFACE_NAMES is
			-- All names used in the interface
		once
			!! Result
		end

end -- class EB_CONSTANTS
