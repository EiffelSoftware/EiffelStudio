indexing

	description:
		"Resource vategory for the explain tool.";
	date: "$Date$";
	revision: "$Revision$"

class EXPLAIN_CATEGORY

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
			!! tool_width.make ("explain_tool_width", rt, 440);
			!! tool_height.make ("explain_tool_height", rt, 500);
			!! command_bar.make ("explain_tool_command_bar", rt, True);
			!! format_bar.make ("explain_tool_format_bar", rt, True);
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
	format_bar: BOOLEAN_RESOURCE

end -- class EXPLAIN_CATEGORY
