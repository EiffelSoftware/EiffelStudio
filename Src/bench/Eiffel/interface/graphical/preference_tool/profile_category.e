indexing

	description:
		"Resource category for the profile tool.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_CATEGORY

inherit
	RESOURCE_CATEGORY

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current
		do
			!! users.make;
			!! modified_resources.make
		end

feature {TTY_RESOURCES} -- Initialization

	initialize (rt: RESOURCE_TABLE) is
			-- Initialize all resources valid for Current.
		do
			!! tool_width.make ("profile_tool_width", rt, 400);
			!! query_tool_width.make ("profile_query_tool_width", rt, 450);
			!! query_tool_height.make ("profile_query_tool_height", rt, 400);
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	tool_width: INTEGER_RESOURCE;
	query_tool_width: INTEGER_RESOURCE;
	query_tool_height: INTEGER_RESOURCE;

end -- class PROFILE_CATEGORY
