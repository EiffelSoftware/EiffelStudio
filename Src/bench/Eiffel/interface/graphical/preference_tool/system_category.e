indexing

	description:
		"Resource valid for the system tool.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_CATEGORY

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
			!! tool_width.make ("system_tool_width", rt, 440);
			!! tool_height.make ("system_tool_height", rt, 500);
			!! command_bar.make ("system_tool_command_bar", rt, true);
			!! format_bar.make ("system_tool_format_bar", rt, true);
			--!! hidden_clusters.make ("hidden_clusters", rt, <<>>)
		end

feature -- Validation

	valid (a_resource: RESOURCE): BOOLEAN is
			-- Is `a_resource' valid for Current?
		do
			Result := True
		end

feature -- Resources

	tool_width: INTEGER_RESOURCE;
	tool_height: INTEGER_RESOURCE;
	command_bar: BOOLEAN_RESOURCE;
	format_bar: BOOLEAN_RESOURCE;
	--hidden_clusters: ARRAY_RESOURCE

end -- class SYSTEM_CATEGORY
